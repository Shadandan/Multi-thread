//
//  ViewController.m
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppInfoCell.h"
#import "NSString+Sandbox.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *appInfos;
@property(nonatomic,strong)NSOperationQueue *queue;
//图片缓存池
@property(nonatomic,strong)NSMutableDictionary *imageCache;
//下载操作缓存池
@property(nonatomic,strong)NSMutableDictionary *downloadCache;
@end
//1.创建模型类，获取数据，测试
//2.数据源方法
//3.同步下载图片-如果网速比较慢，界面会卡顿
//4.异步下载图片-图片显示不出来，点击cell或者上下拖动图片可以显示
//解决：使用占位图片
//5.图片缓存-把网络上下载的图片保存到内存-图片存储在模型对象中
//解决了图片重复下载，节省了用户的流量（用空间换时间）
//6.当图片下载速度特别慢时，出现错行问题
//解决：当图片下载完成后，重新加载对应的cell
//7.当收到内存警告，要清理内存，如果图片存储在模型对象中，不好清理内存
//解决：图片缓冲池（数组或字典）
//8.当有些图片下载速度比较慢，上下不停滚定的时候会重复下载图片，会浪费流量
//解决：创建下载操作的缓冲池，判断当前是否有对应图片的下载操作，如果没有，添加下载操作，如果有不要重复添加
//9.循环引用问题
//  vc->queue和downloadCache->op->block->self
//解决：操作完成后将操作从操作缓存池中移除，queue中的操作当执行完毕会自动从队列中移除
//10.如果没有联网的话，返回cell的方法会不停执行。
//解决；判断下载的图片是否为空
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //测试模型数据
    //NSLog(@"%@",self.appInfos);
}

//懒加载
-(NSArray *)appInfos{
    if (_appInfos==nil) {
        _appInfos=[AppInfo appInfos];
    }
    return _appInfos;
}
-(NSOperationQueue *)queue{
    if (_queue==nil) {
        _queue=[NSOperationQueue new];
    }
    return _queue;
}
-(NSMutableDictionary *)imageCache{
    if (_imageCache==nil) {
        _imageCache=[NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCache;
}
-(NSMutableDictionary *)downloadCache{
    if (_downloadCache==nil) {
        _downloadCache=[NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _downloadCache;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appInfos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId=@"appInfo";
    AppInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseId];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
//    }
    AppInfo *appInfo=self.appInfos[indexPath.row];
    
    //cell内部的子控件都是懒加载的
    //当返回cell之前，会调用cell的layoutSubviews方法,点击时会调用layoutSubviews方法，拖动时也会调用layoutSubviews方法
    //cell.textLabel.text=appInfo.name;
    //cell.detailTextLabel.text=appInfo.download;
    cell.appInfo=appInfo;
    //判断有没有图片缓存,有就从内存中直接获取
//    if (appInfo.image) {
//        cell.imageView.image=appInfo.image;
//        NSLog(@"从缓存加载图片");
//        return cell;
//    }
    
    
    
    //判断有没有图片缓存,有就从内存中直接获取
    if (self.imageCache[appInfo.icon]) {
        cell.iconView.image=self.imageCache[appInfo.icon ];
        NSLog(@"从图片缓存池加载图片");
        return cell;
    }
    
    //设置占位图片解决图片不显示的问题
    cell.iconView.image=[UIImage imageNamed:@"nameCard.png"];
    
    //判断沙盒缓存中是否有图片
    NSData *data=[NSData dataWithContentsOfFile:[appInfo.icon appendCache]];
    if(data){
        UIImage *image=[UIImage imageWithData:data];
        self.imageCache[appInfo.icon]=image;//拷贝到内存中，便于以后使用
        cell.iconView.image=image;
        NSLog(@"从沙盒中加载图片");
        return cell;
        
    }
    //判断下载操作缓冲池中是否有对应的操作
    if (self.downloadCache[appInfo.icon]) {
        NSLog(@"此下载操作正在执行，不需要重复下载");
        return cell;
    }
    
    
        //下载图片
    [self downloadImage:indexPath];
    return cell;
}
//异步下载图片
-(void)downloadImage:(NSIndexPath *)indexPath{
    AppInfo *appInfo=self.appInfos[indexPath.row];
    
    //同步下载图片,当网速不好时，加载时间长，页面拖拽时卡顿
    //异步下载图片，一开始图片显示不出来，因为没有大小和位置，点击或上下拖动可以显示出来，因为会调用layoutSubviews方法，此时图片已下载好，有了大小，因此会显示出来
    NSBlockOperation *op=[NSBlockOperation blockOperationWithBlock:^{
        //模拟耗时
        [NSThread sleepForTimeInterval:0.5];
        //下载图片
        NSLog(@"下载网络图片");
        NSURL *url=[NSURL URLWithString:appInfo.icon];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        
        //把图片保存到沙盒中
        [data writeToFile:[appInfo.icon appendCache] atomically:YES];
        
        //主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if(img){//如果有网络，下载的图片不为null，才执行下面的代码，若不加判断，当下载的图片为空时更新UI reload时就会反复执行这段代码，死循环
                //操作可变字典，线程不安全，所以放到主线程上顺序执行
                //把图片缓存到内存中，拿空间换时间
                //appInfo.image=img;
                //改进：缓存图片,存到图片缓存池（字典）中，以图片地址为键
                self.imageCache[appInfo.icon]=img;
                
                //图片下载完毕，从操作缓存池中移除该操作
                [self.downloadCache removeObjectForKey:appInfo.icon];
                
                //cell.imageView.image=img;//此时layoutSubviews已经执行完了，所以图片不会显示出来
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];//解决图片下载速度特别慢啊时出现的错行问题，重新加载对应的cell
            }
            
        }];
    }];
    [self.queue addOperation:op];
    //把操作添加到下载操作缓存池中
    self.downloadCache[appInfo.icon]=op;

}
//收到内存警告
-(void)didReceiveMemoryWarning{
    [self.imageCache removeAllObjects];//清空图片缓存池
    [self.downloadCache removeAllObjects];//清空操作缓冲池
}
@end

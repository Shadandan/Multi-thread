//
//  ViewController.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperationManager.h"
#import "AppInfo.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property(nonatomic,strong)NSArray *appInfos;
//记录当前图片的地址
@property(nonatomic,copy)NSString *currentURLString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //自定义操作
//    DownloaderOperation *op=[[DownloaderOperation alloc]init];
//    op.url=@"xxx.jpg";
//    [op setFinishedBlock:^(UIImage *img) {
//        NSLog(@"给控件赋值%@",img);
//    }];
    
}
//懒加载
-(NSArray *)appInfos{
    if (_appInfos==nil) {
        _appInfos=[AppInfo appInfos];
    }
    return _appInfos;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //随机取一个模型
    int index=arc4random_uniform((uint32_t)self.appInfos.count);
    AppInfo *appInfo=self.appInfos[index];
    //判断当前点击的图片地址和上一次图片的地址是否一样，如果不一样，取消上一次操作，如果不取消当多次点击屏幕会按顺序一个一个的跳转，想要实现直接跳转到最后一个的效果，所以要取消之前的下载操作
    if(![appInfo.icon isEqualToString:self.currentURLString]){
        //取消上一次操作
        [[DownloaderOperationManager sharedManager] cancelOperation:self.currentURLString];
    }
    //记录当前图片的地址
    self.currentURLString=appInfo.icon;
    //下载图片
    [[DownloaderOperationManager sharedManager]downloadWithURLString:appInfo.icon finishedBlock:^(UIImage *img) {
        self.imgView.image=img;
    }];
}

@end

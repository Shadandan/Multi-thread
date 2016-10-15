//
//  ViewController.m
//  03-异步下载网络图片
//
//  Created by shadandan on 2016/10/15.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ViewController
-(void)loadView{
    self.scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];//_scrollView必须是强指针，否则创建完scrollView没有强指针指向，就销毁了
    self.view=self.scrollView;//将当前的View设置为创建的scrollview，使页面一加载的时候就是一个scrollView，不是UIView
    self.imageView=[[UIImageView alloc]init];
    [self.view addSubview:self.imageView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadImage];
    
}

-(void)loadImage{
    NSURL *url=[NSURL URLWithString:@"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"];//http的协议是不安全的，要在info.plist里面加入
    /* <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>
     */
    //下载图片
    NSData *data=[NSData dataWithContentsOfURL:url];
    UIImage *image=[UIImage imageWithData:data];
    //要在主线程上更新UI控件 线程间通讯
    //waitUntilDone YES表示方法执行完毕才执行后续代码
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    
    
    
}
-(void)updateUI:(UIImage*)image{
    self.imageView.image=image;
    [self.imageView sizeToFit];//适配控件大小和图片大小一样
    //设置scrollView的滚动范围
    self.scrollView.contentSize=image.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

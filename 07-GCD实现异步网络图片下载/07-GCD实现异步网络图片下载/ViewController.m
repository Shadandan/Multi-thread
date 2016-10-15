//
//  ViewController.m
//  07-GCD实现异步网络图片下载
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
    //开启异步执行，下载网络图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
          NSURL *url=[NSURL URLWithString:@"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"];
        //下载图片
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        //回到主线程更新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image=image;
            [self.imageView sizeToFit];
            self.scrollView.contentSize=image.size;
        });

    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

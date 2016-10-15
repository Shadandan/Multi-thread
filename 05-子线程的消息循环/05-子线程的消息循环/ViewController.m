//
//  ViewController.m
//  05-子线程的消息循环
//
//  Created by shadandan on 2016/10/15.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建定时器
    NSTimer *timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(demo) userInfo:nil repeats:YES];
    //把定时器添加到消息循环中
    //[[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];//如果模式设为默认模式，当滚动控件中的内容时，定时器会停止
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];//改为NSRunLoopCommonModes时就可以同时执行了
    //[[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];//只有在滚动scrollView的时候才打印hello
}

-(void)demo{
    NSLog(@"hello%@",[NSRunLoop currentRunLoop].currentMode);//一开始是NSDefaultRunLoopMode模式，当滚动scrollView的时候，消息循环的模式自动改变成UITrackingRunloopMode
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

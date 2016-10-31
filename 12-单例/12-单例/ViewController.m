//
//  ViewController.m
//  12-单例
//  两种实现多线程单例的方式比较：once比加锁效率高
//  Created by shadandan on 2016/10/31.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "NetWorkTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self demo1];//
    [self demo2];//
}


//获取加锁的单例创建时间
-(void)demo1{
    CFAbsoluteTime start=CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [NetWorkTools sharedNetworkTools];
    }
    CFAbsoluteTime end=CFAbsoluteTimeGetCurrent();
    NSLog(@"加锁：%f",end-start);//加锁：0.002117
}
//获取Once的单例创建时间
-(void)demo2{
    CFAbsoluteTime start=CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [NetWorkTools sharedNetworkToolsOnce];
    }
    CFAbsoluteTime end=CFAbsoluteTimeGetCurrent();
    NSLog(@"Once：%f",end-start);//Once：0.000667
}

@end

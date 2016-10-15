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
    //开启一个子线程
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(demo) object:nil];
    [thread start];
    //往子线程消息循环中添加输入源，performSelector也是一种输入源，让指定的方法在指定的线程上执行
    [self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:YES];
    
}

-(void)demo{
    NSLog(@"I'm running");
    //开启子线程的消息循环方式1：如果这种方式开启，消息循环一直执行,"end"不输出，若消息循环中没有添加输入事件，消息循环会立即结束输出"end"
    //[[NSRunLoop currentRunLoop]run];
    //开启子线程的消息循环方式2:消息循环2秒钟后结束，即两秒钟后输出"end"
    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
        NSLog(@"end");
}
-(void)demo1{
    NSLog(@"I'm running on runloop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

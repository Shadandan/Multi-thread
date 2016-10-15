//
//  ViewController.m
//  08-串行队列
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
    [self demo1];
    [self demo2];
    
}
//1.串行队列，同步执行 顺序执行，不开新线程
-(void)demo1{
    //串行队列
    dispatch_queue_t queue=dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    for(int i=0;i<10;i++){
        dispatch_sync(queue, ^{
            NSLog(@"hello %d %@",i,[NSThread currentThread]);
        });
    }
}
//1.串行队列，异步执行 顺序执行，开新线程
-(void)demo2{
    //串行队列
    dispatch_queue_t queue=dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    for(int i=0;i<10;i++){
        dispatch_async(queue, ^{
            NSLog(@"hello %d %@",i,[NSThread currentThread]);
        });
    }
}
@end

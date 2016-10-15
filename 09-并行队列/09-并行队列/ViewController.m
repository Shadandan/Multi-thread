//
//  ViewController.m
//  09-并行队列
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
    [self demo2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//1 并行队列，同步执行   和串行队列同步执行效果一样  顺序执行，不开新线程
-(void)demo1{
    //并行队列
    dispatch_queue_t queue=dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"hello %d %@",i,[NSThread currentThread]);
        });
    }
}
//2.并行队列，异步执行  开多个线程，无序执行
-(void)demo2{
    //并行队列
    dispatch_queue_t queue=dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello %d %@",i,[NSThread currentThread]);
        });
    }
}
@end

//
//  ViewController.m
//  10-主队列
//
//  Created by shadandan on 2016/10/26.
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
}

//主队列，异步执行  主线程顺序执行
//主队列的特点，先执行完主线程上的代码，才会执行主队列上的任务
- (void)demo1{
    for (int i=0; i<10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"hello%d %@",i,[NSThread currentThread]);
        });
    }
}
//主队列，同步执行  主线程上执行才会死锁
//同步执行：会等着要同步执行的任务执行完才会继续往后执行
- (void)demo2{
    NSLog(@"begin");
    for (int i=0; i<10; i++) {
        dispatch_sync(dispatch_get_main_queue(), ^{//死锁
            NSLog(@"hello%d %@",i,[NSThread currentThread]);
        });
    }
    NSLog(@"end");
}
- (void)demo3{//解决demo2的死锁
    NSLog(@"begin");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{//子线程上执行，主线程不等待它完成不发生死锁
        for (int i=0; i<10; i++) {
            dispatch_sync(dispatch_get_main_queue(), ^{//死锁
                NSLog(@"hello%d %@",i,[NSThread currentThread]);
            });
        }
    });
    
    NSLog(@"end");
}
@end

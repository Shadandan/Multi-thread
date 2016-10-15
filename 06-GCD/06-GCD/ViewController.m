//
//  ViewController.m
//  06-GCD
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
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //1.创建队列
//    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
//    //2.创建任务
//    dispatch_block_t task=^{
//        NSLog(@"hello%@",[NSThread currentThread]);
//    };
//    //3.异步执行
//    dispatch_async(queue, task);
    
    //简化用法
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"hello%@",[NSThread currentThread]);

    });
}


@end

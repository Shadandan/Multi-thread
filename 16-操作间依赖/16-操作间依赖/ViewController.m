//
//  ViewController.m
//  16-操作间依赖
//
//  Created by shadandan on 2016/11/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //下载
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载");
    }];
    //解压
    NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"解压");
    }];
    //升级完成
    NSBlockOperation *op3=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"升级完成");
    }];
    //设置操作间的依赖,保证异步任务有顺序，依赖关系可以跨队列执行
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    //操作添加到队列中
    [self.queue addOperations:@[op1,op2] waitUntilFinished:NO];
    //操作3添加到主队列中
    [[NSOperationQueue mainQueue] addOperation:op3];
}
//懒加载
-(NSOperationQueue *)queue{
    if (_queue==nil) {
        _queue=[NSOperationQueue new];
    }
    return _queue;
}



@end

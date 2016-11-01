//
//  ViewController.m
//  14-NSOperation
//
//  Created by shadandan on 2016/10/31.
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
    [self demo6];
}

//NSInvocationOperation演示
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建操作
    NSInvocationOperation *op=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(demo) object:nil];
    //[op start];//不开启新线程，更新operation的状态，调用main方法
    
    //队列
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    //把操作添加到队列中
    [queue addOperation:op];
}
-(void)demo{
    NSLog(@"hello%@",[NSThread currentThread]);
}

//NSBlockOperation start演示
-(void)demo2{
    //创建操作
    NSBlockOperation *op=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello%@",[NSThread currentThread]);
    }];
    [op start];//不开启新线程
}

//NSBlockOperation start演示
-(void)demo3{
    //创建队列
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    //创建操作
    NSBlockOperation *op=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello%@",[NSThread currentThread]);
    }];
    //把操作添加到队列中
    [queue addOperation:op];//开启新线程
    
    //后两句可简化成
//    [queue addOperationWithBlock:^{
//        NSLog(@"hello%@",[NSThread currentThread]);
//    }];
    
}

//全局队列 并发队列，异步执行
-(void)demo4{
    for (int i=0; i<10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"hello%@",[NSThread currentThread]);
        }];
    }
}
//懒加载
-(NSOperationQueue *)queue{
    if(_queue==nil){
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
//operation的completeBlock
-(void)demo5{
    //创建操作
    NSBlockOperation *op=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello%@",[NSThread currentThread]);
    }];
    //op执行完执行completeBlock里面的内容 在子线程上执行，所以不能以这种方式更新UI
    [op setCompletionBlock:^{
        NSLog(@"end%@",[NSThread currentThread]);
    }];
    [self.queue addOperation:op];
}

//子线程主线程间通信
-(void)demo6{
    [self.queue addOperationWithBlock:^{
        //异步下载图片
        NSLog(@"异步下载图片");
        //获取当前队列
        //[NSOperationQueue currentQueue];
        //线程间通信，回到主线程更新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            NSLog(@"更新UI");
        }];
    }];
}

@end

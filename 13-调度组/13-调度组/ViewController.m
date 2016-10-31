//
//  ViewController.m
//  13-调度组
//
//  Created by shadandan on 2016/10/31.
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

//下载三首歌曲，等所有的歌曲都下载完毕之后转到主线程提示用户
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self demo1];
}
//演示调度组的基本使用
-(void)demo1{
    //创建组
    dispatch_group_t group=dispatch_group_create();
    //队列
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    //下载第一首歌曲
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第一首歌曲");
    });
    //下载第二首歌曲
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"正在下载第二首歌曲");
        
    });
    //下载第三首歌曲
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第三首歌曲");
    });
    //当三个异步任务都执行完成，才执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"over");
    });
}

//调度组内部原理
-(void)demo2{
    //创建组
    dispatch_group_t group=dispatch_group_create();
    //创建队列
    dispatch_queue_t queue=dispatch_queue_create("hm", DISPATCH_QUEUE_CONCURRENT);

    //任务1
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"任务1");
        dispatch_group_leave(group);
    });
    
    //任务2
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"任务2");
        dispatch_group_leave(group);
    });

    
    //任务3
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"任务3");
        dispatch_group_leave(group);
    });
    
    //等待组中任务组执行完才会执行中间代码
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"over");
    });
    
    //等待组中任务组执行完才会执行后续代码
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//第二个参数是超时，表示最多等待多长时间
    NSLog(@"hello");

}
@end

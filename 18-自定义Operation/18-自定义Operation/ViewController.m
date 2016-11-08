//
//  ViewController.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"
@interface ViewController ()
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //自定义操作
    DownloaderOperation *op=[[DownloaderOperation alloc]init];
    op.url=@"xxx.jpg";
    [op setFinishedBlock:^(UIImage *img) {
        NSLog(@"给控件赋值%@",img);
    }];
    [self.queue addOperation:op];//会自动执行main函数
}
-(NSOperationQueue *)queue{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  DownloaderOperation.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "DownloaderOperation.h"
#import "NSString+Sandbox.h"
@implementation DownloaderOperation
//重写main方法
-(void)main{
    @autoreleasepool {
        //断言,用于拦截异常，给出提示信息
        NSAssert(self.finishedBlock!=nil, @"finishBlock不能为空");
        //模拟网络延时
        //[NSThread sleepForTimeInterval:2.0];
        
        //判断是否被取消，可以取消正在执行的操作
        if(self.isCancelled){
            return;
        }
        
        //下载网络图片
        NSURL *url=[NSURL URLWithString:self.url];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        //缓存到沙盒中
        if (img) {//图片下载成功
            [data writeToFile:[self.url appendCache] atomically:YES];
        }
        NSLog(@"下载图片%@%@",self.url,[NSThread currentThread]);
        //图片下载完成，回到主线程更新UI
        if(self.finishedBlock){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(img);//调用自定义block finishedBlock，并传递的参数值为nil
            }];
        }
    }
}
+(instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *))finishedBlock{
    DownloaderOperation *op=[[DownloaderOperation alloc]init];
    op.url=urlString;
    op.finishedBlock=finishedBlock;
    return op;
}
@end

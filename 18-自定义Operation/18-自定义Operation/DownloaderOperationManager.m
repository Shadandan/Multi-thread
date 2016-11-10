//
//  DownloaderOperationManager.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "DownloaderOperationManager.h"
#import "DownloaderOperation.h"
#import "NSString+Sandbox.h"
//管理全局的下载操作
//管理全局缓存
@interface DownloaderOperationManager()
@property(nonatomic,strong)NSOperationQueue *queue;
//下载缓存池
@property(nonatomic,strong)NSMutableDictionary *operationCache;
//图片缓存池
@property(nonatomic,strong)NSMutableDictionary *imageCache;

@end
@implementation DownloaderOperationManager
-(NSOperationQueue *)queue{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
-(NSMutableDictionary *)operationCache{
    if (_operationCache==nil) {
        _operationCache=[NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _operationCache;
}
-(NSMutableDictionary *)imageCache{
    if (_imageCache==nil) {
        _imageCache=[NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCache;
}
+(instancetype)sharedManager{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[self new];
    });
    return instance;
}
//管理全局下载操作
-(void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *))finishedBlock{
    //断言,用于拦截异常，给出提示信息
    NSAssert(finishedBlock!=nil, @"finishBlock不能为空");
    //如果下载操作已经存在 返回 避免重复下载
    if (self.operationCache[urlString]) {
        return;
    }
    //判断图片是否有缓存
    if ([self checkImageCache:urlString]) {
        //有缓存，直接回调
        finishedBlock(self.imageCache[urlString]);
        return;
    }
    //使用类方法下载图片
    DownloaderOperation *op=[DownloaderOperation downloaderOperationWithURLString:urlString finishedBlock:^(UIImage *img) {
        //图片下载完成,回调
        finishedBlock(img);
        //缓存图片
        self.imageCache[urlString]=img;
        NSLog(@"更新UI%@  %@",op.url,[NSThread currentThread]);
       //下载完成，移除缓存的操作
        [self.operationCache removeObjectForKey:urlString];
    }];
    [self.queue addOperation:op];//会自动执行main函数
    //缓存下载操作
    self.operationCache[urlString]=op;

}
//取消操作
-(void)cancelOperation:(NSString *)urlString{
    if (!urlString) {//如果为空就return，第一次点击时urlStrings为空
        return;
    }
    //取消操作
    [self.operationCache[urlString] cancel];
    //从缓冲池删除操作
    [self.operationCache removeObjectForKey:urlString];
}
//检查是否有缓存（内存和沙盒都检查）
-(BOOL)checkImageCache:(NSString *)urlString{
    //检查内存缓存
    if(self.imageCache[urlString]){
        return YES;
    }
    //检查沙盒缓存
    UIImage *img=[UIImage imageWithContentsOfFile:[urlString appendCache]];
    if (img) {
        //从沙盒中读取的图片保存到内存中
        self.imageCache[urlString]=img;
        return YES;
    }
    return NO;
}
@end

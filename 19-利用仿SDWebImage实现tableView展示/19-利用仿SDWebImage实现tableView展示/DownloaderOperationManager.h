//  下载操作管理类-单例的
//  DownloaderOperationManager.h
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloaderOperationManager : NSObject
//单例方法
+(instancetype)sharedManager;
//管理全局下载操作
-(void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *))finishedBlock;
//取消操作
-(void)cancelOperation:(NSString *)urlString;
@end

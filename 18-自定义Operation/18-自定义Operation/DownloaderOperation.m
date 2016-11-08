//
//  DownloaderOperation.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "DownloaderOperation.h"

@implementation DownloaderOperation
-(void)main{
    @autoreleasepool {
        NSLog(@"下载图片%@%@",self.url,[NSThread currentThread]);
        //假设图片下载完成，回到主线程更新UI
        if(self.finishedBlock){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(nil);//调用自定义block finishedBlock，并传递的参数值为nil
            }];
        }
    }
}
@end

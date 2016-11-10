//
//  UIImageView+WebCache.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "DownloaderOperationManager.h"
#import <objc/runtime.h>
#define MYKEY "str"
@interface UIImageView()
//记录当前图片的地址
@property(nonatomic,copy)NSString *currentURLString;
@end
@implementation UIImageView (WebCache)
//在分类中增加属性，必须自己写属性的setter和getter方法
-(void)setCurrentURLString:(NSString *)currentURLString{
    objc_setAssociatedObject(self, MYKEY, currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)currentURLString{
    return objc_getAssociatedObject(self, MYKEY);
}
-(void)setImageUrlString:(NSString *)urlString{
    //判断当前点击的图片地址和上一次图片的地址是否一样，如果不一样，取消上一次操作，如果不取消当多次点击屏幕会按顺序一个一个的跳转，想要实现直接跳转到最后一个的效果，所以要取消之前的下载操作
    if(![urlString isEqualToString:self.currentURLString]){
        //取消上一次操作
        [[DownloaderOperationManager sharedManager] cancelOperation:self.currentURLString];
    }
    //记录当前图片的地址
    self.currentURLString=urlString;
    //下载图片
    [[DownloaderOperationManager sharedManager]downloadWithURLString:urlString finishedBlock:^(UIImage *img) {
        self.image=img;
    }];

}
@end

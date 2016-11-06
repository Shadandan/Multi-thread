//
//  AppInfo.h
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppInfo : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *download;

//缓存图片，图像存储在模型对象中，这种方式缓存图片有缺点，内存不足是取出图片清空缓存麻烦，采用图片缓存池来代替
//@property(nonatomic,strong)UIImage *image;

+(instancetype)appInfoWithDict:(NSDictionary *)dict;
+(NSArray *)appInfos;
@end

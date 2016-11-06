//
//  AppInfo.m
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
+(instancetype)appInfoWithDict:(NSDictionary *)dict{
    AppInfo *appInfo=[[self alloc]init];
    [appInfo setValuesForKeysWithDictionary:dict];
    return appInfo;
}
+(NSArray *)appInfos{
    //加载plist
    NSString *path=[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    //字典转模型
    NSMutableArray *mArray=[NSMutableArray arrayWithCapacity:10];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {//遍历数组中的元素，并作为参数传递到block中，执行block中的代码，第一个参数是元素对象，第二个参数是索引值，第三个参数是是否停止
       
        //字典模型
        AppInfo *appInfo=[self appInfoWithDict:obj];
        [mArray addObject:appInfo];
    }];
    return mArray.copy;//mArray是可变数组，线程不安全，而返回值类型应该是NSArray，因此要把可变数组编程不可变数组。
}
@end

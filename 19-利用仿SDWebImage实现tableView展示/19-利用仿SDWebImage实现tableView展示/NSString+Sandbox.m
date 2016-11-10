//  获取沙盒路径和文件名的分类
//  NSString+Sandbox.m
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "NSString+Sandbox.h"

@implementation NSString (Sandbox)
-(instancetype)appendCache{//实现存储在Cache目录下图片的全路径的拼接
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];//获取沙盒Cache全路径，拼接上字符串对象的最后一级的文件名，例如调用此函数的字符串对象是www.baidu.com/01.jpg  拼接完就是Cache目录/01.jpg
}
-(instancetype)appendTemp{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}
-(instancetype)appendDocument{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}
@end

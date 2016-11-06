//  获取沙盒路径和文件名的分类
//  NSString+Sandbox.h
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Sandbox)
-(instancetype)appendCache;
-(instancetype)appendTemp;
-(instancetype)appendDocument;
@end

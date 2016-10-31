//
//  NetWorkTools.m
//  12-单例
//
//  Created by shadandan on 2016/10/31.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools
//加锁的方式保证多线程单例
+(instancetype)sharedNetworkTools{
    static id instance=nil;
    //线程同步，保证线程安全
    @synchronized (self) {
        if (instance==nil){
            instance=[[self alloc]init];
        }
    }
    return instance;
}
//Once的方式保证多线程单例
+(instancetype)sharedNetworkToolsOnce{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance==nil){
            instance=[[self alloc]init];
        }

    });
    return instance;
}
@end

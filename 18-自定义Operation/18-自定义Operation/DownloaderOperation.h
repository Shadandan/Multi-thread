//
//  DownloaderOperation.h
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloaderOperation : NSOperation
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)void (^finishedBlock)(UIImage *img);//自定义block
@end

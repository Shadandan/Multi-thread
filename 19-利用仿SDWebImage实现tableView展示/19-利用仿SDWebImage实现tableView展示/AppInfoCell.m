//
//  AppInfoCell.m
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppInfoCell.h"
#import "AppInfo.h"
#import "UIImageView+WebCache.h"
@interface AppInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *download;

@end
@implementation AppInfoCell
-(void)setAppInfo:(AppInfo *)appInfo{
    _appInfo=appInfo;
    self.name.text=appInfo.name;
    self.download.text=appInfo.download;
    [self.iconView setImageUrlString:appInfo.icon];//下载网络图片
}
@end

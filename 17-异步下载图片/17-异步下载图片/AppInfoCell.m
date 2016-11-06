//
//  AppInfoCell.m
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppInfoCell.h"
#import "AppInfo.h"
@interface AppInfoCell()


@end
@implementation AppInfoCell
-(void)setAppInfo:(AppInfo *)appInfo{
    _appInfo=appInfo;
    self.name.text=appInfo.name;
    self.download.text=appInfo.download;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

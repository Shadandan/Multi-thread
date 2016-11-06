//
//  AppInfoCell.h
//  17-异步下载图片
//
//  Created by shadandan on 2016/11/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppInfo;
@interface AppInfoCell : UITableViewCell
@property(nonatomic,strong)AppInfo *appInfo;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *download;
@end

//
//  ViewController.m
//  19-利用仿SDWebImage实现tableView展示
//
//  Created by shadandan on 2016/11/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppInfoCell.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *appInfos;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //测试模型数据
    //NSLog(@"%@",self.appInfos);
}
//懒加载
-(NSArray *)appInfos{
    if (_appInfos==nil) {
        _appInfos=[AppInfo appInfos];
    }
    return _appInfos;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appInfos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId=@"appInfo";
    AppInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseId];
    AppInfo *appInfo=self.appInfos[indexPath.row];
    cell.appInfo=appInfo;
    return cell;
}


@end

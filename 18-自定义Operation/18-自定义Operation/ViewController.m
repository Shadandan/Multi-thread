//
//  ViewController.m
//  18-自定义Operation
//
//  Created by shadandan on 2016/11/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "AppInfo.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property(nonatomic,strong)NSArray *appInfos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //自定义操作
//    DownloaderOperation *op=[[DownloaderOperation alloc]init];
//    op.url=@"xxx.jpg";
//    [op setFinishedBlock:^(UIImage *img) {
//        NSLog(@"给控件赋值%@",img);
//    }];
    
}
//懒加载
-(NSArray *)appInfos{
    if (_appInfos==nil) {
        _appInfos=[AppInfo appInfos];
    }
    return _appInfos;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //随机取一个模型
    int index=arc4random_uniform((uint32_t)self.appInfos.count);
    AppInfo *appInfo=self.appInfos[index];
    [self.imgView setImageUrlString:appInfo.icon];
    }

@end

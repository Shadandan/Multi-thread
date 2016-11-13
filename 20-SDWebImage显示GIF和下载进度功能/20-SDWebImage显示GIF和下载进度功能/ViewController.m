//
//  ViewController.m
//  20-SDWebImage显示GIF和下载进度功能
//
//  Created by shadandan on 2016/11/13.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.imageView.image=[UIImage sd_animatedGIFNamed:@"1468302875"];
    
    NSURL *url=[NSURL URLWithString:@"http://www.pp3.cn/uploads/201509/2015090906.jpg"];
    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float progress=(float)receivedSize/expectedSize;
        NSLog(@"下载进度%ld",(long)receivedSize);
        NSLog(@"总大小%ld",(long)expectedSize);//有bug
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       //清空缓存
        [SDWebImageManager.sharedManager.imageCache clearMemory];
        [SDWebImageManager.sharedManager.imageCache clearDisk];
        NSLog(@"完成");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  11-Barrier
//
//  Created by shadandan on 2016/10/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *imageList;
@end

@implementation ViewController
//懒加载
-(NSMutableArray *)imageList{
    if(_imageList==nil){
        _imageList=[NSMutableArray array];
    }
    return _imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i=0; i<1000; i++) {
        [self downloadImage:i];
    }
}
-(void)downloadImage:(int) index{
    //创建并发队列
    dispatch_queue_t queue=dispatch_queue_create( "qe", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSString *fileName=[NSString stringWithFormat:@"angry_%02d.jpg",index%26];
        NSString *path=[[NSBundle mainBundle]pathForResource:fileName ofType:nil];//获取图片路径
        UIImage *image=[UIImage imageWithContentsOfFile:path];//获取图片
        dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{//不加这个会出现问题，可能会崩溃也可能少数据，因为可变数组是线程不安全的，当同时向数组中存数据时会发生漏存或出错的现象
            [self.imageList addObject:image];
            NSLog(@"保存图片到数组%@",fileName);
        });
        NSLog(@"图片下载完成%@",fileName);
        
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"共有%zd张图片存入数组",self.imageList.count);
}

@end

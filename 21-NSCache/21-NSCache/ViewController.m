//
//  ViewController.m
//  21-NSCache
//
//  Created by shadandan on 2016/11/13.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>
@property(nonatomic,strong)NSCache *cache;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置NSCache的代理
    self.cache.delegate=self;
    //添加缓存数据
    for (int i=0; i<10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        NSLog(@"添加%@",[NSString stringWithFormat:@"hello %d",i]);
    }
    //输出缓存数据
    for (int i=0; i<10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
}
//懒加载
-(NSCache *)cache{
    if (_cache==nil) {
        _cache=[[NSCache alloc]init];
        //设置缓存中总共可以存储多少条
        _cache.countLimit=5;
    }
    return _cache;
}

//将要从NSCache中移除一项的时候执行
-(void)cache:(NSCache *)cache willEvictObject:(nonnull id)obj{
    NSLog(@"从缓存中移除 %@",obj);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.cache removeAllObjects];//当收到内存警告，移除全部数据后就无法再添加缓存数据了
}


@end

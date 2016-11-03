//
//  ViewController.m
//  15-NSOperationQueue的应用-摇奖机
//
//  Created by shadandan on 2016/11/3.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//懒加载
-(NSOperationQueue *)queue{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
- (IBAction)clickBtn:(id)sender {
    //异步执行
    if(self.queue.operationCount==0){//开始和继续都走这个分支
        [self.queue addOperationWithBlock:^{
            [self random];
        }];
        self.queue.suspended=NO;
        [self.startBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }else if(self.queue.suspended==NO){//暂停走这个分支
        self.queue.suspended=YES;
        [self.startBtn setTitle:@"继续" forState:UIControlStateNormal];
    }
    
}
//生成随机数
-(void)random{
    while(self.queue.suspended==NO){
        [NSThread sleepForTimeInterval:0.05];
        int num1=arc4random_uniform(10);//[0,10)
        int num2=arc4random_uniform(10);
        int num3=arc4random_uniform(10);
        //回到主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label1.text=[NSString stringWithFormat:@"%d",num1];
            self.label2.text=[NSString stringWithFormat:@"%d",num2];
            self.label3.text=[NSString stringWithFormat:@"%d",num3];
        }];
    }
}

@end

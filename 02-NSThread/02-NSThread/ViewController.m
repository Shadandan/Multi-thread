//
//  ViewController.m
//  02-NSThread
//
//  Created by shadandan on 2016/10/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)int tickets;
//@property(atomic,assign)int tickets;//对于卖票的场合并不适用
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tickets=10;
    //方式1：
    //创建线程对象
    NSThread *thread1=[[NSThread alloc]initWithTarget:self selector:@selector(demo) object:nil];//第二个参数是要执行的方法，第一个参数是该方法所属的对象，第三个参数是传入方法的参数
    thread1.name=@"t1";
    //开启线程
    [thread1 start];
    //方式2：
    //[NSThread detachNewThreadSelector:@selector(demo) toTarget:self withObject:nil];
    //方式3：
    //[self performSelectorInBackground:@selector(demo) withObject:nil];//到后台执行，系统帮我们创建了一个新的线程
    
    //创建线程对象
    NSThread *thread2=[[NSThread alloc]initWithTarget:self selector:@selector(demo) object:nil];//第二个参数是要执行的方法，第一个参数是该方法所属的对象，第三个参数是传入方法的参数
    thread2.name=@"t2";
    //开启线程
    [thread2 start];
}
-(void)demo{
    @synchronized (self) {
        while(self.tickets>0){
            self.tickets=self.tickets-1;
            NSLog(@"%@卖了第%d张票",[NSThread currentThread],self.tickets);
        }
    }
    
//    while(self.tickets>0){
//        self.tickets=self.tickets-1;
//        NSLog(@"%@卖了第%d张票",[NSThread currentThread],self.tickets);
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

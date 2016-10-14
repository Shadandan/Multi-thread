//
//  ViewController.m
//  01-pthread
//
//  Created by shadandan on 2016/10/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import <pthread/pthread.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pthread_t pthread;//线程编号
    char *name1="zhangsan";
    NSString *name2=@"lisi";
    //第一个参数 线程编号的地址
    //第二个参数 线程的属性
    //第三个参数 线程要执行的函数 void *  (*)  (void *)
    //int *指向int类型的指针 void*指向任何类型的指针，有点类似OC中的id
    //第四个参数 要执行的函数的参数
    //函数的返回值 int 0表示成功 非0表示失败，返回失败码
    int result=pthread_create(&pthread, NULL, demo, (__bridge void *)(name2));//__bridge 桥接 OC中的对象和C语言的变量间转换需要桥接
    if(result==0){
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
    
    
}
void *demo(void *param){
    //NSLog(@"%s",param);//c语言的变量用%s打印
    NSString *name=(__bridge NSString *)(param);
    NSLog(@"%@",name);
    return NULL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

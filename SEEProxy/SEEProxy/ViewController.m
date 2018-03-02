//
//  ViewController.m
//  SEEDot
//
//  Created by 三只鸟 on 2018/2/9.
//  Copyright © 2018年 景彦铭. All rights reserved.
//

#import "ViewController.h"
#import "Fish.h"
#import "People.h"
#import "SEEProxy.h"
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Fish * fish = [Fish new];
    People * people = [People new];
    
    SEEProxy * fishMan = [SEEProxy proxyWithObjs:people,fish, nil];
    
    if ([fishMan respondsToSelector:@selector(say)]) {
        [fishMan performSelector:@selector(say)];
    }
    if ([fishMan respondsToSelector:@selector(swimming)]) {
        [fishMan performSelector:@selector(swimming)];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

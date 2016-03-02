//
//  ZWNewViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWNewViewController.h"

@interface ZWNewViewController ()

@end

@implementation ZWNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *NewItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highimage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = NewItem;
    // 设置背景色
    self.view.backgroundColor = ZWGlobalBg;
    

}

- (void)tagClick{
    ZWLogFunc;
}
@end

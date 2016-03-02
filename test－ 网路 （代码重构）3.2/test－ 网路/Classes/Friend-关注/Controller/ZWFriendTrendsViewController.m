//
//  ZWFriendTrendsViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWFriendTrendsViewController.h"
#import "ZWTuiJianViewController.h"
#import "ZWLoginRegisterViewController.h"
@interface ZWFriendTrendsViewController ()

@end

@implementation ZWFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏的内容
    self.navigationItem.title = @"我的关注";
    
    UIBarButtonItem *FriendItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highimage:@"friendsRecommentIcon-click" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = FriendItem;
    // 设置背景色
    self.view.backgroundColor = ZWGlobalBg;
}
- (IBAction)loginRegister {
    ZWLoginRegisterViewController *loginRster = [[ZWLoginRegisterViewController alloc]init];
    
    [self presentViewController:loginRster animated:YES completion:nil];
    
}

- (void)tagClick{
    
    ZWTuiJianViewController *tvc = [[ZWTuiJianViewController alloc]init];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
}
@end

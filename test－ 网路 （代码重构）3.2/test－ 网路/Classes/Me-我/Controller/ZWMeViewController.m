//
//  ZWMeViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWMeViewController.h"

@interface ZWMeViewController ()

@end

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏的内容
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *SettingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highimage:@"mine-setting-icon-click" target:self action:@selector(SettingClick)];
    
    self.navigationItem.rightBarButtonItem = SettingItem;
    
    UIBarButtonItem *MoonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highimage:@"mine-moon-icon-click" target:self action:@selector(MoonClick)];
    
    self.navigationItem.rightBarButtonItem = MoonItem;
    self.navigationItem.rightBarButtonItems = @[SettingItem,MoonItem];
    // 设置背景色
    self.view.backgroundColor = ZWGlobalBg;
}

- (void)SettingClick{
    ZWLogFunc;
}

- (void)MoonClick{
    ZWLogFunc;
}


@end

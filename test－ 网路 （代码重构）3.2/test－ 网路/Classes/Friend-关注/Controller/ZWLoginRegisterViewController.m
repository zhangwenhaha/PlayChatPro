//
//  ZWLoginRegisterViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/23.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWLoginRegisterViewController.h"

@interface ZWLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LoginBg;

/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;

@end

@implementation ZWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.LoginBg atIndex:0];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];

    if (self.LoginViewLeftMargin.constant == 0) {// 登录状态
        self.LoginViewLeftMargin.constant = - self.view.width;
        self.RegisterBtn.selected = YES;
    }else{// 注册状态
        self.LoginViewLeftMargin.constant = 0;
        self.RegisterBtn.selected = NO;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)Backdismiss:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 让状态颜色变为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

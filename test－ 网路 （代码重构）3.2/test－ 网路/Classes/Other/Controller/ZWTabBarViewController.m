//
//  ZWTabBarViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/26.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTabBarViewController.h"
#import "ZWeSsenceViewController.h"
#import "ZWFriendTrendsViewController.h"
#import "ZWMeViewController.h"
#import "ZWNewViewController.h"
#import "ZWTabBar.h"
#import "ZWNavigationController.h"
@interface ZWTabBarViewController ()

@end

@implementation ZWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 利用appearance属性 统一修改uitabbar中字体的颜色和大小；
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
     [self setUpChildVc:[[ZWeSsenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildVc:[[ZWNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChildVc:[[ZWFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVc:[[ZWMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    

    // 更换tabBar
    //    self.tabBar = [[XMGTabBar alloc] init]; tabar属性为只读属性，所以可以通过kvc的方式来替换系统的tabbar
    [self setValue:[[ZWTabBar alloc] init] forKeyPath:@"tabBar"];

}

// 建立一个初始化子控制器的方法
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)Image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:Image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    ZWNavigationController *naVc = [[ZWNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:naVc];
    
}

@end

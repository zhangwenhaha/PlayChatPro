//
//  ZWMeViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWMeViewController.h"
#import "ZWTMeCell.h"
#import "ZWMeFooterView.h"
#import "UIButton+WebCache.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "ZWSquare.h"
@interface ZWMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

static NSString * cellID = @"me";

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 设置tableview
    [self setMeTablewView];
    
   
    ZWLog(@"222");
    
}

- (void)setUpNav{
    // 设置导航栏的内容
    self.navigationItem.title = @"我的";
    ZWLog(@"222");

    UIBarButtonItem *SettingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highimage:@"mine-setting-icon-click" target:self action:@selector(SettingClick)];
    
    self.navigationItem.rightBarButtonItem = SettingItem;
    
    UIBarButtonItem *MoonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highimage:@"mine-moon-icon-click" target:self action:@selector(MoonClick)];
    
    self.navigationItem.rightBarButtonItem = MoonItem;
    self.navigationItem.rightBarButtonItems = @[SettingItem,MoonItem];
}

- (void)setMeTablewView{
    
    // 设置背景色
    self.tableView.backgroundColor = ZWGlobalBg;
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    // 注册cell
    [self.tableView registerClass:[ZWTMeCell class] forCellReuseIdentifier:cellID];
    
    // 调整header和footer
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[ZWMeFooterView alloc]init];
    
    
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ZWLog(@"%@",responseObject);
        
        NSArray *squares = [ZWSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        // 创建方块
        //[self createSquares:squares];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZWLog(@"222");
    }];
}

- (void)SettingClick{
    ZWLogFunc;
}

- (void)MoonClick{
    ZWLogFunc;
}

#pragma mark - 数据源方法

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZWTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"登录/注册"];
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"离线下载"];
    }
    return cell;
}
@end

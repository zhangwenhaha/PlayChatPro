//
//  ZWRecommendTagsTableViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWRecommendTagsTableViewController.h"
#import "ZWRecommendTag.h"
#import "ZWRecommendTagCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
@interface ZWRecommendTagsTableViewController ()
// 标签数据
@property (nonatomic,strong) NSArray *tags;

@end

static NSString * const ZWTagId = @"tag";

@implementation ZWRecommendTagsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableview
    [self setupTableView];
    
    // 发送请求网络数据
    [self loadTags];
    
    }

- (void)setupTableView{
    
    self.title = @"推荐关注";
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZWTagId];
    
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZWGlobalBg;
    
}

- (void)loadTags{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [ZWRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        
    }];

    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWTagId];
    
    cell.recommendtag = self.tags[indexPath.row];
    
    return cell;
}
@end

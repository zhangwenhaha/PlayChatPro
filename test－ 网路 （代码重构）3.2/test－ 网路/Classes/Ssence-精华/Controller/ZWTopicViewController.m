//
//  ZWTopicViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/23.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicViewController.h"
#import "ZWTopicModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ZWTopicCellTableViewCell.h"
#import "ZWCommentViewController.h"
@interface ZWTopicViewController ()
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray *topics;

/** 页码 */
@property (nonatomic,assign) NSInteger page;

/** 加载下一页所需参数 */
@property (nonatomic,copy) NSString *maxtime;

/** 上一次请求参数 */
@property (nonatomic,strong) NSDictionary *parmas;

@end

@implementation ZWTopicViewController



- (NSMutableArray *)topics{
    
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableview];
    
    // 添加刷新控件
    [self setupRefresh];
}

static NSString * const ZWTopicID = @"topic";
- (void)setupTableview{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = ZWTitlesViewH + ZWTitlesViewy;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWTopicCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZWTopicID];
    
    //self.tableView.rowHeight = 300;
    
}

- (void)setupRefresh{
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 设置一进来就刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */
- (void)loadNewTopic{
    
    // 结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parmas = parameters;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parmas != parameters) return;
        
        //[responseObject writeToFile:@"/Users/zw/Downloads/01/tiezi.plist" atomically:YES];
        
        // 存储需要加载下一页数据的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        self.topics = [ZWTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 先初始化页码为0 防止网络失败导致页码丢失
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parmas != parameters) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];    }];
    
}

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopic{
    
    // 结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"page"] = @(++self.page);
    parameters[@"maxtime"] = self.maxtime;
    self.parmas = parameters;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmas != parameters) return;
        
        // 存储需要加载下一页数据的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        NSArray *topics = [ZWTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:topics];
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parmas != parameters) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];    }];
    
    // 恢复页码
    self.page -- ;
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWTopicCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWTopicID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取出帖子模型
    ZWTopicModel *topic = self.topics[indexPath.row];
    
    // 返回这个模型对应的cell的高度
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
    ZWCommentViewController *cvc = [[ZWCommentViewController alloc]init];
    
    cvc.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:cvc animated:YES];

}

@end

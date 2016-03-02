//
//  ZWTuiJianViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/30.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTuiJianViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ZWTuiJianCatrgoryCell.h"
#import "MJExtension.h"
#import "ZWTuiJianCategory.h"
#import "ZWTuiJianCatrgoryCell.h"
#import "ZWTuiJianUserCell.h"
#import "ZWTuiJianUser.h"
#import "MJRefresh.h"

#define ZWSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface ZWTuiJianViewController ()<UITableViewDataSource,UITableViewDelegate>
/**左边的类别数据*/
@property (nonatomic,strong) NSArray *categories;
///**右边的用户数据*/
//@property (nonatomic,strong) NSArray *users;
/**左边的TableView表格*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**右边的UserTableView表格*/
@property (weak, nonatomic) IBOutlet UITableView *userTableview;

/** 请求参数*/
@property (nonatomic,strong) NSMutableDictionary *params;
/** AFN请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation ZWTuiJianViewController

static NSString * const ZWCategotyID = @"category";
static NSString * const ZWUserID = @"user";

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧数据
    [self loadCategoreis];
}
/**
 * 控件初始化
 */
- (void)setupTableView{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWTuiJianCatrgoryCell class]) bundle:nil] forCellReuseIdentifier:ZWCategotyID];
    
    [self.userTableview registerNib:[UINib nibWithNibName:NSStringFromClass([ZWTuiJianUserCell class]) bundle:nil] forCellReuseIdentifier:ZWUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableview.contentInset = self.categoryTableView.contentInset;
    self.userTableview.rowHeight = 70;
    
    // 设置标题
    self.navigationItem.title = @"我的关注";
    
    // 设置背景色
    self.view.backgroundColor = ZWGlobalBg;

}
/**
 * 添加刷新控件
 */
- (void)setupRefresh{
    self.userTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
                                    
    self.userTableview.mj_footer.hidden = YES;
}
/**
 * 加载左侧类别数据
 */
- (void)loadCategoreis{
    // 显示指示器
    //[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 添加刷新控件
        [self setupRefresh];
        
        // 从服务器返回指示器 MJExtension的使用
        self.categories = [ZWTuiJianCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        ZWLog(@"%@",responseObject);
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新的状态
        [self.userTableview.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[NSThread sleepForTimeInterval:3.0f];
        [SVProgressHUD showErrorWithStatus:@"网络连接失败，请检查网络设置"];
    }];

}

#pragma mark - 加载更多用户数据
- (void)loadNewUsers{
    ZWTuiJianCategory *c = ZWSelectedCategory;
    // 设置当前页码为1
    c.currentpage = 1;
    
    // 发送请求给服务器，加载右侧数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(c.id);
    parameters[@"page"] = @(c.currentpage);
    self.params = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        // 字典数据－> 模型数组
        NSArray *users = [ZWTuiJianUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清除所有旧数据
        [c.users removeAllObjects];
        
        // 添加当前类别对应的用户数据
        [c.users addObjectsFromArray:users];
        
        // 保存总数
        c.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != parameters) return ;

        // 刷新右边表格
        [self.userTableview reloadData];
        
        // 结束刷新
        [self.userTableview.mj_header endRefreshing];
        
        // 让底部结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.params != parameters) return ;
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        // 结束刷新
        [self.userTableview.mj_header endRefreshing];
    }];

}

- (void)loadMoreUsers{
    ZWTuiJianCategory *c = ZWSelectedCategory;
    
    // 发送请求给服务器，加载右侧数据(请求参数)
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(c.id);
    parameters[@"page"] = @(++c.currentpage);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数据－> 模型数组
        NSArray *users = [ZWTuiJianUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加当前类别对应的用户数据
        [c.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != parameters) return ;
        
        // 刷新表格
        [self.userTableview reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        // 结束刷新
        [self.userTableview.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self.userTableview.mj_footer endRefreshing];
    }];

}

/**
 *
 */
- (void)checkFooterState{
    ZWTuiJianCategory *c = ZWSelectedCategory;
    // 每次刷新右边数据时，都控制footer是否隐藏
    self.userTableview.mj_footer.hidden = (c.users.count == 0);
    // 刷新表格
    if (c.users.count == c.total) { // 全部加载完毕
        [self.userTableview.mj_footer endRefreshingWithNoMoreData];
    }else{// 还没有记载完毕
        [self.userTableview.mj_footer endRefreshing];
    }

}

#pragma makr - 实现数据源的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
   
    // 右边的用户表格
    // 监测footer的状态
    [self checkFooterState];
        
    return [ZWSelectedCategory users].count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView){
        ZWTuiJianCatrgoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWCategotyID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;

    }else{
         ZWTuiJianUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWUserID];
        
        cell.user = [ZWSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 结束刷新
    [self.userTableview.mj_header endRefreshing];
    [self.userTableview.mj_footer endRefreshing];
    
    ZWTuiJianCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //
        [self.userTableview reloadData];
    } else {
        // 赶紧刷新表格，目的是：马上显示当前分类的用户数据，不让用户看见一个分类的残留的数据  就是解决网络慢所带来的还是显示之前的数据
        [self.userTableview reloadData];
        
        // 进入下拉刷新状态
        [self.userTableview.mj_header beginRefreshing];
    }
    
}
#pragma mark - 控制器的销毁
- (void)dealloc{
    // 停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

@end

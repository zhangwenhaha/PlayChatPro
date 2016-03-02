//
//  ZWCommentViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/29.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWCommentViewController.h"
#import "ZWTopicCellTableViewCell.h"
#import "ZWTopicModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "ZWTopicComment.h"
#import "ZWCommenCell.h"
@interface ZWCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 工具条底部的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomspace;
//
@property (weak, nonatomic) IBOutlet UITableView *tableview;


/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComment;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *lastComments;

/** 保存帖子中的Top_cmt */
@property (nonatomic,strong) NSArray *save_Top_cmt;

/** 当前的页码 */
@property (nonatomic,assign) NSInteger currentPage;

@end

static NSString * const ZWCommentID = @"comment";

@implementation ZWCommentViewController

//- (NSMutableArray *)lastComments{
//
//    if (!_lastComments) {
//        _lastComments = [NSMutableArray array];
//    }
//    return _lastComments;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 界面的初始化
    [self setupBasic];
    
    [self setupHeader];
    
    [self settupRefresh];
}

- (void)settupRefresh{
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableview.mj_footer.hidden = YES;
}

- (void)loadMoreComments{
    
    // 页码
    NSInteger page = self.currentPage + 1;
    
    // 发送网络请求
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"page"] = @(page);
    ZWTopicComment *comments = [self.lastComments lastObject];
    parameters[@"lastcid"] = comments.ID;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 最新评论
         NSArray *lastComments = [ZWTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.lastComments addObjectsFromArray:lastComments];
        
        // 页码
        self.currentPage = page;
        
        // 刷新表格
        [self.tableview reloadData];
        
        
        // 控制footer的状态
        NSInteger totoal = [responseObject[@"total"] integerValue];
        
        if (self.lastComments.count >= totoal) {
            // 提示没有数据可以加载
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            // 结束刷新
            [self.tableview.mj_footer endRefreshing];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [self.tableview.mj_footer endRefreshing];
    }];

}


- (void)loadNewComments{
    
    // 发送网络请求
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        // 最热评论
        self.hotComment = [ZWTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.lastComments = [ZWTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [self.tableview reloadData];
        
        // 页码
        self.currentPage = 1;
        
        // 结束刷新
        [self.tableview.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger totoal = [responseObject[@"total"] integerValue];
        
        if (self.lastComments.count >= totoal) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        // 结束刷新
        [self.tableview.mj_header endRefreshing];
    }];

}

- (void)setupBasic{
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highimage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    // cell的高度设置
    self.tableview.estimatedRowHeight = 44;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    // 设置背景
    self.tableview.backgroundColor = ZWGlobalBg;
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 去掉系统自带的分割线
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupHeader{
    // 包装一层uiview方便以后可以加其他东西也使得便于调整
    UIView *header = [[UIView alloc]init];
    
    // 将首页面的最热评论消失
    if (self.topic.top_cmt.count) {
        self.save_Top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        self.topic.cellHeight = 0;
    }
    
    // 添加cell
    ZWTopicCellTableViewCell *cell = [ZWTopicCellTableViewCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(ZWScreenW, self.topic.cellHeight);
    [header addSubview:cell];

    // header的高度
    header.height = self.topic.cellHeight + 10;
    
    // 设置header
    self.tableview.tableHeaderView = header;
    
    // 注册自定义cell
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ZWCommenCell class]) bundle:nil] forCellReuseIdentifier:ZWCommentID];
    
    
    
}

- (void)keyboardWillChangFrame:(NSNotification *)note{
    
    // 键盘显示／隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部的约束
    self.bottomspace.constant = ZWScreenH - frame.origin.y;
    // 获得键盘弹出或者收回的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
       // 强制布局 
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 在控制器即将销毁时，将之间的删除Top_cmt的数据恢复
    if (self.topic.top_cmt.count) {
        self.topic.top_cmt = self.save_Top_cmt;
        
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
}


/**
 * 返回第section组的评论数据
 */

- (NSArray *)commentsInSetion:(NSInteger)section{
    if (section == 0) {
        return self.hotComment.count ? self.hotComment : self.lastComments ;
    }
    return self.lastComments;
}

- (ZWTopicComment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSetion:indexPath.section][indexPath.row];
}
#pragma mark - tableViewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotComment.count;
    NSInteger lastCount = self.lastComments.count;
    
    if (hotCount) return 2; // 表示有热门评论
    if (lastCount) return 1; // 表示只有最新评论
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComment.count;
    NSInteger lastCount = self.lastComments.count;

    tableView.mj_footer.hidden = lastCount ? NO : YES;
    
    if (section == 0) {
        return hotCount ? hotCount : lastCount;
    }

    // 非第0组
    return lastCount;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComment.count;
    
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZWCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWCommentID];
    
    cell.comments = [self commentInIndexPath:indexPath];
    
    return cell;
}

#pragma mark - tableviewdelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end

//
//  ZWeSsenceViewController.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWeSsenceViewController.h"
#import "ZWRecommendTagsTableViewController.h"
#import "ZWTopicViewController.h"
@interface ZWeSsenceViewController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic,weak) UIView *indicatorView;

/** 当前选中的按钮 */
@property (nonatomic,weak) UIButton *titleBtn;

/** 顶部标签 */
@property (nonatomic,weak) UIView *titlesview;

/** 底部的所有内容 */
@property (nonatomic,weak) UIScrollView *contentView;

@end

@implementation ZWeSsenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setUpChildVces];
    
    // 初始化导航栏
    [self setupNav];
    
    // 设置顶部标签栏
    [self setUpTitleView];
    
    // 底部的scrollview
    [self setUpcontentview];
    
}

/**
 * 初始化导航栏
 */
- (void)setupNav{
    // 设置导航栏的内容
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    UIBarButtonItem *ssenceItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highimage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = ssenceItem;
    // 设置背景色
    self.view.backgroundColor = ZWGlobalBg;
    
}

/**
 * 设置顶部标签栏
 */
- (void)setUpTitleView{
    
    // 标签栏整体
    UIView *titlesview = [[UIView alloc]init];
    //titlesview.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //titlesview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    titlesview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    titlesview.frame = CGRectMake(0, ZWTitlesViewy, self.view.width, ZWTitlesViewH);
    
    [self.view addSubview:titlesview];
    self.titlesview = titlesview;
    
    // 底部红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesview.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    
    // 标签栏的内部
    CGFloat w = titlesview.width / self.childViewControllers.count;
    CGFloat h = titlesview.height;
    for (NSInteger i = 0; i <self.childViewControllers.count; i++) {
        UIButton *titleBtn = [[UIButton alloc]init];
        titleBtn.tag = i;
        titleBtn.height = h;
        titleBtn.width = w;
        titleBtn.x = w * i;
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesview addSubview:titleBtn];
        
        // 默认点击了第一个按钮
        if (i == 0) {
        titleBtn.enabled = NO;
        self.titleBtn = titleBtn;

         // 让按钮内部的label根据文字内容来计算尺寸
            [titleBtn.titleLabel sizeToFit];
            self.indicatorView.centerX = titleBtn.centerX - 14;
            self.indicatorView.width = titleBtn.titleLabel.width;
            /* 第二种方法 */
//            self.indicatorView.centerX = titleBtn.centerX - 14;
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : titleBtn.titleLabel.font}].width;
        }
        
    }
    [titlesview addSubview:indicatorView];
    
}

- (void)titleClick:(UIButton *)button{
    // 修改按钮的状态
    self.titleBtn.enabled = YES;
    button.enabled = NO;
    self.titleBtn = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = button.centerX;
        self.indicatorView.width = button.titleLabel.width;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag  * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

/**
 * 底部的scrollview
 */
- (void)setUpcontentview{
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.backgroundColor = ZWGlobalBg;
    contentView.frame = self.view.bounds;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 * 初始化子控制器
 */
- (void)setUpChildVces{
    ZWTopicViewController *all = [[ZWTopicViewController alloc]init];
    all.title = @"全部";
    all.type = ZWTopicTypeAll;
    [self addChildViewController:all];
    
    ZWTopicViewController *video = [[ZWTopicViewController alloc]init];
    video.title = @"视频";
    video.type = ZWTopicTypeVideo;
    [self addChildViewController:video];
    
    ZWTopicViewController *voice = [[ZWTopicViewController alloc]init];
    voice.title = @"声音";
    voice.type = ZWTopicTypeVoice;
    [self addChildViewController:voice];
    
    ZWTopicViewController *picture = [[ZWTopicViewController alloc]init];
    picture.title = @"图片";
    picture.type = ZWTopicTypePicture;
    [self addChildViewController:picture];
    
    ZWTopicViewController *word = [[ZWTopicViewController alloc]init];
    word.title = @"段子";
    word.type = ZWTopicTypeWord;
    [self addChildViewController:word];
}

- (void)tagClick{
    ZWRecommendTagsTableViewController *tags = [[ZWRecommendTagsTableViewController alloc]init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark -<UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 让标签执行动画
    
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;// 设置控制器view的y值为0（默认为20）
    vc.view.height = scrollView.height;// 设置控制器view的height的值为整个屏的高度
    
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesview.subviews[index]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UIViewController *vc = [[UIViewController alloc]init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}
@end

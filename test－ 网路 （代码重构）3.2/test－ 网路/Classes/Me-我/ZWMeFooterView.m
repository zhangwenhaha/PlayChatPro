//
//  ZWMeFooterView.m
//  test－ 网路
//
//  Created by zw on 16/3/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWMeFooterView.h"
#import "AFNetworking.h"
#import "ZWSquare.h"
#import "MJExtension.h"
#import "ZWSquareButton.h"
#import "ZWMeWebViewController.h"

@implementation ZWMeFooterView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 请求参数
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *squares = [ZWSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:squares];

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        

    }
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)array {
    
    // 一行最多多少列
    int maxcols = 4;
    
    // 宽度和高度
    CGFloat buttonW = ZWScreenW / maxcols;
    CGFloat buttonH = buttonW ;
    
    for (int i = 0; i <array.count ;i++) {
        // 取出模型
        ZWSquare *square = array[i];
        
        // 创建button
        ZWSquareButton *button = [[ZWSquareButton alloc]init];
        
        // 添加点击事件
        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.square = square;
        
        int col = i % maxcols;
        int row = i / maxcols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        [self addSubview:button];
        
        self.height = CGRectGetMaxY(button.frame) + 10;

    }
    
    self.contentSize = CGSizeMake(ZWScreenW, self.height + 150 );
       // 重绘
    [self setNeedsDisplay];
}

// // 这个可以试着uiview的背景图片
//- (void)drawRect:(CGRect)rect{
//
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}


- (void)ButtonClick:(ZWSquareButton *)button{
    
    if (![button.square.url hasPrefix:@"http"]) return;
    
    ZWMeWebViewController *web = [[ZWMeWebViewController alloc]init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //  取出当前控制器
    UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nav = (UINavigationController *)tabbarVc.selectedViewController;
    
    [nav pushViewController:web animated:YES];
}
@end

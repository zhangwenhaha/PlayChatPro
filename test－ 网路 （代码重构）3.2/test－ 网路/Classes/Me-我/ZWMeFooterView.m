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
#import "UIButton+WebCache.h"


@implementation ZWMeFooterView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        

        
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
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i <array.count ;i++) {
        // 取出模型
        ZWSquare *square = array[i];
        
        // 创建button
        UIButton *button = [[UIButton alloc]init];
        
        // 添加文字
        [button setTitle:square.name forState:UIControlStateNormal];
        
        // 添加图片
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        
        int col = i % maxcols;
        int row = i / maxcols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        ZWLog(@"%d",array.count);
    }
   
}

// 这个可以试着uiview的背景图片
//- (void)drawRect:(CGRect)rect{
//
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

@end

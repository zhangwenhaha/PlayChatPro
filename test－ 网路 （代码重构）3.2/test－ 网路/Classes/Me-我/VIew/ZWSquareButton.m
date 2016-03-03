//
//  ZWSquareButton.m
//  test－ 网路
//
//  Created by zw on 16/3/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWSquareButton.h"
#import "UIButton+WebCache.h"
#import "ZWSquare.h"
@implementation ZWSquareButton

- (void)setup{
    // 文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 文字颜色和字体
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    // 添加背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    

}

// 通过代码创建
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 通过xib创建或者sb
- (void)awakeFromNib{
    
    [self setup];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.y = self.width * 0.1;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

- (void)setSquare:(ZWSquare *)square{

    _square = square;
    
    // 添加文字
    [self setTitle:square.name forState:UIControlStateNormal];
    
    // 添加图片
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end

//
//  ZWVerticalBtn.m
//  test－ 网路
//
//  Created by zw on 16/2/23.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWVerticalBtn.h"

@implementation ZWVerticalBtn

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
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
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end

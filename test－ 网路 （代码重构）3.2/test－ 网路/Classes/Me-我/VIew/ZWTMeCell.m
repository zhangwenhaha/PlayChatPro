//
//  ZWTMeCell.m
//  test－ 网路
//
//  Created by zw on 16/3/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTMeCell.h"

@implementation ZWTMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        // 设置cell的样式左边有箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 设置我的样式的背景图片
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        // 设置字体的颜色
        self.textLabel.textColor = [UIColor darkGrayColor];
        // 设置字体的字体大小
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    
    self.imageView.width = 25;
    self.imageView.height =  self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
}

//- (void)setFrame:(CGRect)frame{
//
//    frame.origin.y -= 25;
//    
//    [super setFrame:frame];
//    
//}

@end

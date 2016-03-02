//
//  ZWTuiJianCatrgoryCell.m
//  test－ 网路
//
//  Created by zw on 16/1/31.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTuiJianCatrgoryCell.h"
#import "ZWTuiJianCategory.h"
@interface ZWTuiJianCatrgoryCell()
@property (weak, nonatomic) IBOutlet UIView *leftindicator;

@end

@implementation ZWTuiJianCatrgoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = ZWRGBColor(244, 244, 244);
    self.leftindicator.backgroundColor = ZWRGBColor(219, 21, 26);
    self.textLabel.font = [UIFont systemFontOfSize:9 weight:320];
}

- (void)setCategory:(ZWTuiJianCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 重新调整内部的textlabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
}
/**
 可以在这个方法中监听cell的选中状态
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.leftindicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.leftindicator.backgroundColor : ZWRGBColor(78, 78, 78);
}

@end

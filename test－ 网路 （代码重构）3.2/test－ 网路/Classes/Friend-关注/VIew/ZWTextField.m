//
//  ZWTextField.m
//  test－ 网路
//
//  Created by zw on 16/2/23.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTextField.h"
#import <objc/runtime.h>
static NSString * const ZWPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation ZWTextField

/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */

- (void)awakeFromNib{
    // 修改占位文字的颜色
    [self setValue:[UIColor grayColor] forKeyPath:ZWPlacerholderColorKeyPath];
    
    // 设置光标颜色与占位文字的颜色一致
    self.tintColor = self.textColor;
    
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:ZWPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ZWPlacerholderColorKeyPath];
    return [super resignFirstResponder];
    
}
@end

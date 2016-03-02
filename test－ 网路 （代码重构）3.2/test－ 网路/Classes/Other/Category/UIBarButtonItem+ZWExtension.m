//
//  UIBarButtonItem+ZWExtension.m
//  test－ 网路
//
//  Created by zw on 16/1/27.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "UIBarButtonItem+ZWExtension.h"

@implementation UIBarButtonItem (ZWExtension)

+(instancetype)itemWithImage:(NSString *)image highimage:(NSString *)highimage target:(id)target action:(SEL)action
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    Btn.size = Btn.currentBackgroundImage.size;
    
    return [[self alloc]initWithCustomView:Btn];
}

@end

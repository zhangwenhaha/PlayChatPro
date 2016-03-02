//
//  UIImage+ZWExtension.m
//  test－ 网路
//
//  Created by zw on 16/3/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "UIImage+ZWExtension.h"

@implementation UIImage (ZWExtension)

- (UIImage *)cicrleimage{
    
    // no代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end

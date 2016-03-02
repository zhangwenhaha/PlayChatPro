//
//  NSDate+ZWExtension.h
//  test－ 网路
//
//  Created by zw on 16/2/25.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZWExtension)

/**
 * 比较self和from的时间差值
 */
- (NSDateComponents*)deltaFrom:(NSDate *)from;

/**
 * 是否是今年
 */
- (BOOL)isThisYear;

/**
 * 是否是今天
 */
- (BOOL)isToday;

/**
 * 是否是去年
 */
- (BOOL)isYesterday;



@end

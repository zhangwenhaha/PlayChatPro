//
//  ZWRecommendTag.h
//  test－ 网路
//
//  Created by zw on 16/2/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWRecommendTag : NSObject

/** 名字 */
@property (nonatomic,copy) NSString *theme_name;

/** 图片 */
@property (nonatomic,copy) NSString *image_list;

/** 订阅数 */
@property (nonatomic,assign) NSInteger sub_number;

@end

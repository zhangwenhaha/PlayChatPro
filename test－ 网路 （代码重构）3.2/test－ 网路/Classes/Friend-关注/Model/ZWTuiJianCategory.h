//
//  ZWTuiJianCategory.h
//  test－ 网路
//
//  Created by zw on 16/1/31.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWTuiJianCategory : NSObject

/** id  */
@property (nonatomic,assign) NSInteger id;

/** 总数 */
@property (nonatomic,assign) NSInteger count;

/** 名字 */
@property (nonatomic,copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic,strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic,assign) NSInteger total;
/** 当前页码 */
@property (nonatomic,assign) NSInteger currentpage;

@end

//
//  ZWTuiJianCategory.m
//  test－ 网路
//
//  Created by zw on 16/1/31.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTuiJianCategory.h"

@implementation ZWTuiJianCategory

- (NSMutableArray *)users{

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end

//
//  ZWTuiJianUser.h
//  test－ 网路
//
//  Created by zw on 16/2/11.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWTuiJianUser : NSObject
/** 头像 */
@property (nonatomic,copy) NSString *header;
/** 粉丝数 */
@property (nonatomic,assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic,copy) NSString *screen_name;
@end

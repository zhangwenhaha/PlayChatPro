//
//  ZWTopicComment.h
//  test－ 网路
//
//  Created by zw on 16/2/29.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWTopicUser;
@interface ZWTopicComment : NSObject
/** id */
@property (nonatomic,copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 音频文件的url地址 */
@property (nonatomic,copy) NSString *voiceuri;
/** 评论文字的内容 */
@property (nonatomic,copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic,assign) NSInteger like_count;
/** 用户 */
@property (nonatomic,strong) ZWTopicUser *user;
@end

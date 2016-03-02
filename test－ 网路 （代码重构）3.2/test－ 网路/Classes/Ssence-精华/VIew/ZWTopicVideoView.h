//
//  ZWTopicVideoView.h
//  test－ 网路
//
//  Created by zw on 16/2/28.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWTopicModel;
@interface ZWTopicVideoView : UIView

@property (nonatomic,strong) ZWTopicModel *topic;

+ (instancetype)VideoView;

@end

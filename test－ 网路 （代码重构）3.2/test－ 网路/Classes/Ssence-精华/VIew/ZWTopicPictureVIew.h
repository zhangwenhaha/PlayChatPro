//
//  ZWTopicPictureVIew.h
//  test－ 网路
//
//  Created by zw on 16/2/25.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWTopicModel;
@interface ZWTopicPictureVIew : UIView

@property (nonatomic,strong) ZWTopicModel *topic;

+ (instancetype)PictureView;

@end

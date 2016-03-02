//
//  ZWTopicCellTableViewCell.h
//  test－ 网路
//
//  Created by zw on 16/2/24.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTopicModel;
@interface ZWTopicCellTableViewCell : UITableViewCell

@property (nonatomic,strong) ZWTopicModel *topic;

+ (instancetype)cell;

@end

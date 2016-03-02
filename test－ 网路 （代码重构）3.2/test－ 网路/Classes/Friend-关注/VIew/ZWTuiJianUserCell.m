//
//  ZWTuiJianUserCell.m
//  test－ 网路
//
//  Created by zw on 16/2/11.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTuiJianUserCell.h"
#import "ZWTuiJianUser.h"
#import "UIImageView+WebCache.h"
@interface ZWTuiJianUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headimageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ZWTuiJianUserCell
- (void)setUser:(ZWTuiJianUser *)user{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fanscount = nil;
    if (user.fans_count < 10000) {
        fanscount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{
        fanscount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    
    self.fansCountLabel.text = fanscount;
    
    [self.headimageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end

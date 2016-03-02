//
//  ZWCommenCell.m
//  test－ 网路
//
//  Created by zw on 16/2/29.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWCommenCell.h"
#import "ZWTopicComment.h"
#import "ZWTopicUser.h"
#import "UIImageView+WebCache.h"

@interface ZWCommenCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImagView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *VoiceButton;


@end

@implementation ZWCommenCell

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

- (void)awakeFromNib {
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setComments:(ZWTopicComment *)comments{
    
    _comments = comments;
    
    // 头像的图片
    [self.profileImagView sd_setImageWithURL:[NSURL URLWithString:comments.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 性别
    self.sexView.image = [comments.user.sex isEqualToString:ZWTopicUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] :[UIImage imageNamed:@"Profile_womanIcon"];
    
    // 评论内容
    self.contentLabel.text = comments.content;
    
    self.userLabel.text = comments.user.username;
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd",comments.like_count];
    
    
    if (comments.voiceuri.length) {
        self.VoiceButton.hidden = NO;
        [self.VoiceButton setTitle:[NSString stringWithFormat:@"%zd",comments.voicetime]forState:UIControlStateNormal];
    }else{
        self.VoiceButton.hidden = YES;
    }
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    
    [super setFrame:frame];
}

@end

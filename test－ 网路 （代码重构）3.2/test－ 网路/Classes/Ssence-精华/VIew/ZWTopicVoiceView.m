//
//  ZWTopicVoiceView.m
//  test－ 网路
//
//  Created by zw on 16/2/28.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicVoiceView.h"
#import "ZWTopicModel.h"
#import "UIImageView+WebCache.h"
#import "ZWShowPictureViewController.h"
@interface ZWTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *playcount;

@property (weak, nonatomic) IBOutlet UILabel *voicelength;

@end

@implementation ZWTopicVoiceView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.imageview.userInteractionEnabled = YES;
    [self.imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture{
    ZWShowPictureViewController *spvc = [[ZWShowPictureViewController alloc]init];
    spvc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spvc animated:YES completion:nil];
}


+ (instancetype)VoiceView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
;
}

- (void)setTopic:(ZWTopicModel *)topic{
    _topic = topic;
    
    // 音乐图片
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcount.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    // 播放时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voicelength.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end

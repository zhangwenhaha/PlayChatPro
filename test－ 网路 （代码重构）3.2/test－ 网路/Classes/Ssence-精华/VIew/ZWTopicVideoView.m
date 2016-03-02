//
//  ZWTopicVideoView.m
//  test－ 网路
//
//  Created by zw on 16/2/28.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicVideoView.h"
#import "ZWTopicModel.h"
#import "UIImageView+WebCache.h"
#import "ZWShowPictureViewController.h"
#import "ZWPlayVideoViewController.h"
@interface ZWTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *videotime;


@end
@implementation ZWTopicVideoView

+ (instancetype)VideoView{
    
   return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.imageview.userInteractionEnabled = YES;
    [self.imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (IBAction)showPicture{
//    ZWShowPictureViewController *spvc = [[ZWShowPictureViewController alloc]init];
//    spvc.topic = self.topic;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spvc animated:YES completion:nil];
    ZWPlayVideoViewController *pvvc = [[ZWPlayVideoViewController alloc]init];
    pvvc.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pvvc animated:YES completion:nil];
    
}

- (void)setTopic:(ZWTopicModel *)topic{
    _topic = topic;
    
    // 视频图片
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:topic.cdn_img]];
    
    // 播放次数
    self.playcount.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    // 播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    self.videotime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}

@end

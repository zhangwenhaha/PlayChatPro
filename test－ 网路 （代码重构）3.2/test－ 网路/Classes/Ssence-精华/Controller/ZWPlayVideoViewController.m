//
//  ZWPlayVideoViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/28.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWPlayVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZWTopicModel.h"
@interface ZWPlayVideoViewController ()

@property (nonatomic,strong) MPMoviePlayerController *playerVideo;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation ZWPlayVideoViewController

- (void)awakeFromNib{
    
    self.view.autoresizingMask = UIViewAutoresizingNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)playVideo {
    // 隐藏按钮
    self.playBtn.hidden = YES;
    self.playBtn.enabled = YES;
    
    // 播放
    [self.playerVideo play];
}

#pragma mark -
- (MPMoviePlayerController *)playerVideo{
    if (_playerVideo == nil) {
        // 获取视频地址
        NSURL *url = [NSURL URLWithString:self.topic.videouri];
        
        // 创建控制器
        _playerVideo = [[MPMoviePlayerController alloc]initWithContentURL:url];
        
        // 设置控制器的view的位置
        _playerVideo.view.frame = CGRectMake(0, self.view.centerY - 30, ZWScreenW, ZWScreenW * 9 /16);
        // 将view添加到控制器上
        [self.view addSubview:_playerVideo.view];
    }
    return _playerVideo;
    
}

@end

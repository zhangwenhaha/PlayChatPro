//
//  ZWTopicPictureVIew.m
//  test－ 网路
//
//  Created by zw on 16/2/25.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicPictureVIew.h"
#import "UIImageView+WebCache.h"
#import "ZWTopicModel.h"
#import "DALabeledCircularProgressView.h"
#import "ZWShowPictureViewController.h"
@interface ZWTopicPictureVIew()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif图标 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageview;
/** 点击查看图片的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeButton;
/** 进度条的视图 */
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation ZWTopicPictureVIew

+ (instancetype)PictureView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 3;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture{
    ZWShowPictureViewController *spvc = [[ZWShowPictureViewController alloc]init];
    spvc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spvc animated:YES completion:nil];
    }

- (void)setTopic:(ZWTopicModel *)topic{
    
    _topic = topic;
     // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.progress animated:NO];

    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
       topic.progress = 1.0 * receivedSize / expectedSize;
       topic.progress = (topic.progress < 0) ? 0 : topic.progress;
        [self.progressView setProgress:topic.progress animated:YES];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",topic.progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图片，才需要绘图
        if (!topic.isbigPicture ) {
            return ;
        }
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat Width = topic.pictureViewFrame.size.width;
        
        CGFloat height = Width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, Width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 判断是否为gif
    NSString *extension  = topic.large_image.pathExtension;
    self.gifImageview.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否点击查看全图
    if (topic.isbigPicture) {// 大图
        self.seeButton.hidden = NO;
        // self.imageView.contentMode = UIViewContentModeTop;
    }else{
        self.seeButton.hidden = YES;
        // self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end

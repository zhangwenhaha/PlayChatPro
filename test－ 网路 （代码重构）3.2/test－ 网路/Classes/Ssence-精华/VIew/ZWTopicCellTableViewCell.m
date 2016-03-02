//
//  ZWTopicCellTableViewCell.m
//  test－ 网路
//
//  Created by zw on 16/2/24.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZWTopicModel.h"
#import "ZWTopicPictureVIew.h"
#import "ZWTopicVoiceView.h"
#import "ZWTopicVideoView.h"
#import "ZWTopicComment.h"
#import "ZWTopicUser.h"

@interface ZWTopicCellTableViewCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageVIew;
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 发帖时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *SinaImageView;
/** 文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *Text_label;

/** 图片帖子中间的内容 */
@property (weak, nonatomic) ZWTopicPictureVIew *pictureView;
/** 声音帖子中间的内容 */
@property (weak, nonatomic) ZWTopicVoiceView *VoiceView;
/** 视频帖子中间的内容 */
@property (weak,nonatomic) ZWTopicVideoView *VideoView;

/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *TopicCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *TopicCommentView;


@end


@implementation ZWTopicCellTableViewCell

+(instancetype)cell{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (ZWTopicPictureVIew *)pictureView{
    if (!_pictureView) {
        
       ZWTopicPictureVIew *pictureView = [ZWTopicPictureVIew PictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ZWTopicVoiceView *)VoiceView{
    if (!_VoiceView) {
        
        ZWTopicVoiceView *VoiceView = [ZWTopicVoiceView VoiceView];
        [self.contentView addSubview:VoiceView];
        _VoiceView = VoiceView;
    }
    return _VoiceView;
}

- (ZWTopicVideoView *)VideoView{
    if (!_VideoView) {
        ZWTopicVideoView *VideoView  = [ZWTopicVideoView VideoView];
        [self.contentView addSubview:VideoView];
        _VideoView = VideoView;
    }
    return _VideoView;
}

- (void)awakeFromNib {
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    // 图片的圆角处理 这种方法不好，容易使得程序变卡顿
//    self.headerImageVIew.layer.cornerRadius = self.headerImageVIew.width * 0.5;
//    self.headerImageVIew.layer.masksToBounds = YES;
}

- (void)setTopic:(ZWTopicModel *)topic{
    _topic = topic;
    
    // 新浪加V
    self.SinaImageView.hidden = !topic.isSina_v;
    
    // 设置其他控件
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultUserIcon"];
    [self.headerImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.headerImageVIew.image = image ? [image cicrleimage] : placeholderImage;
    }];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮的文字
    [self setButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareBtn count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    // 设置文字内容
    self.Text_label.text = topic.text;
    
    // 根据帖子的类型添加相应的Xib文件
    if (topic.type == ZWTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        self.VoiceView.hidden = YES;
        self.VideoView.hidden = YES;
    }else if (topic.type == ZWTopicTypeVoice){
        self.VoiceView.hidden = NO;
        self.VoiceView.topic = topic;
        self.VoiceView.frame = topic.VoiceViewFrame;
        self.pictureView.hidden = YES;
        self.VideoView.hidden= YES;
    }else if (topic.type == ZWTopicTypeVideo){
        self.VideoView.hidden = NO;
        self.VideoView.topic = topic;
        self.VideoView.frame = topic.VideoViewFrame;
        self.pictureView.hidden = YES;
        self.VoiceView.hidden = YES;
    }else{
        self.pictureView.hidden = YES;
        self.VoiceView.hidden = YES;
        self.VideoView.hidden = YES;
    }
    
    // 处理最热评论
    ZWTopicComment *cmt = [topic.top_cmt firstObject];
    
    if (cmt) {
        self.TopicCommentView.hidden = NO;
        self.TopicCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
    }else{
        self.TopicCommentView.hidden = YES;
    }
    
}

- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame{
    
    static NSInteger margin = 10;
    frame.origin.x  = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height = self.topic.cellHeight - margin;
    
    [super setFrame:frame];
}
- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"其它", nil];
   
    [sheet showInView:self.window];
}

@end

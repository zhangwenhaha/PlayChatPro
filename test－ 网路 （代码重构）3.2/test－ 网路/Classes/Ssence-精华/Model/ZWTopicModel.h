//
//  ZWTopicModel.h
//  test－ 网路
//
//  Created by zw on 16/2/24.
//  Copyright © 2016年 zw. All rights reserved.
//  帖子

#import <UIKit/UIKit.h>

@interface ZWTopicModel : NSObject
/** id */
@property (nonatomic,copy) NSString *ID;
/** 名称 */
@property (nonatomic,copy) NSString *name;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic,copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic,copy) NSString *text;
/** 顶的数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic,assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;
/** 图片的宽度*/
@property (nonatomic,assign) CGFloat width;
/** 图片的高度*/
@property (nonatomic,assign) CGFloat height;
/** 图片的URL **/
/** 小图片*/
@property (nonatomic,copy) NSString *small_image;
/** 大图片*/
@property (nonatomic,copy) NSString *large_image;
/** 中图片*/
@property (nonatomic,copy) NSString *middle_image;
/** 段子的类型 */
@property (nonatomic,assign) ZWTopicType type;
/** 音频时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic,assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic,assign) NSInteger playcount;

/** 视频播放的地址 */
@property (nonatomic,copy) NSString *videouri;
/** 视频加载时的图片 */
@property (nonatomic,copy) NSString *cdn_img;

/** 最热评论(这个数组当中就装着ZWTopicCommment模型) */
@property (nonatomic,strong) NSArray *top_cmt;

/** 额外的辅助属性 **/
/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** 图片控件的frame*/
@property (nonatomic,assign) CGRect pictureViewFrame;
/** 图片是否太大 */
@property (nonatomic,assign,getter=isbigPicture) BOOL bigPicture;
/** 进度条 */
@property (nonatomic,assign) CGFloat progress;

/** 音乐图片的frame */
@property (nonatomic,assign) CGRect VoiceViewFrame;

/** 视频图片的frame */
@property (nonatomic,assign) CGRect VideoViewFrame;

@end

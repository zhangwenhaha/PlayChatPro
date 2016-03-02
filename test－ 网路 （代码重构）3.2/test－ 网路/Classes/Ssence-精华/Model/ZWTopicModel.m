//
//  ZWTopicModel.m
//  test－ 网路
//
//  Created by zw on 16/2/24.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWTopicModel.h"
#import "MJExtension.h"
#import "ZWTopicUser.h"
#import "ZWTopicComment.h"
//#import "ZWTopicComment.h"
@implementation ZWTopicModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"ID":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt" : @"ZWTopicComment"};
    //return @{@"top_cmt" : [ZWTopicComment class]};
    // 两种方式都可以
}

- (NSString *)create_time
    {
        // 日期格式化类
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        // 帖子的创建时间
        NSDate *create = [fmt dateFromString:_create_time];
        
        if (create.isThisYear) { // 今年
            if (create.isToday) { // 今天
                NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
                
                if (cmps.hour >= 1) { // 时间差距 >= 1小时
                    return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
                } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                    return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
                } else { // 1分钟 > 时间差距
                    return @"刚刚";
                }
            } else if (create.isYesterday) { // 昨天
                fmt.dateFormat = @"昨天 HH:mm";
                return [fmt stringFromDate:create];
            } else { // 其他
                fmt.dateFormat = @"MM-dd HH:mm";
                return [fmt stringFromDate:create];
            }
        } else { // 非今年
            return _create_time;
        }
        return _create_time;
    }
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        // 文字的Y值
        CGFloat textY = 55;
        CGSize maxsize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        //CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxsize].height;
        CGFloat textH = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        _cellHeight = textY + textH + 10 + 30 ;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == ZWTopicTypePicture) {// 图片贴子
            // 图片显示出来的宽度
            CGFloat imageW = maxsize.width;
            
            // 图片显示出来的高度
            CGFloat imageH = imageW * self.height / self.width;
            
            if (imageH > ZWTopicCellPictureMaxH) {// 图片高度过长
                imageH = ZWTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            
            
            // 计算图片控件的frame
            CGFloat pictureX = 10;
            CGFloat pictureY = textY + textH + 10;
            _pictureViewFrame = CGRectMake(pictureX , pictureY, imageW, imageH);
            _cellHeight += imageH ;
        }else if (self.type == ZWTopicTypeVoice){// 音乐帖子
            
            // 音乐图片显示出来的宽度
            CGFloat VoiceW = maxsize.width;
            
            // 音乐图片显示出来的高度
            CGFloat VocieH = VoiceW * self.height / self.width;
            
            // 计算音乐图片的控件的frame
            CGFloat VoiceX = 10;
            CGFloat VoiceY = textY + textH + 10;
            self.VoiceViewFrame = CGRectMake(VoiceX, VoiceY, VoiceW, VocieH);
            _cellHeight += VocieH + 10;
        }else if (self.type == ZWTopicTypeVideo){
            // 视频图片显示出来的宽度
            CGFloat VideoW = maxsize.width;
            
            // 视频图片显示出来的高度
            CGFloat VideoH = VideoW * self.height / self.width;
            
            // 计算视频图片的控件的frame
            CGFloat VideoX = 10;
            CGFloat VideoY = textY + textH + 10;
            self.VideoViewFrame  = CGRectMake(VideoX, VideoY, VideoW, VideoH);
            _cellHeight += VideoH + 10;

        }
    
        // 当有最热评论文字时，计算其相应的高度
        ZWTopicComment *cmt = [self.top_cmt firstObject];
        
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
            
            CGFloat contentH = [content boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
            
            _cellHeight += 20 + contentH + 10;
        }
        
        _cellHeight += 44;
    }
        return _cellHeight;
}
@end

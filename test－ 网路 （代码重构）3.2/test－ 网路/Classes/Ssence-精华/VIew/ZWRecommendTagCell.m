//
//  ZWRecommendTagCell.m
//  test－ 网路
//
//  Created by zw on 16/2/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWRecommendTagCell.h"
#import "ZWRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface ZWRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imagelistImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumbelLable;

@end

@implementation ZWRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendtag:(ZWRecommendTag *)recommendtag{
    _recommendtag = recommendtag;
    
    [self.imagelistImageView sd_setImageWithURL:[NSURL URLWithString:recommendtag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendtag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendtag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人关注",recommendtag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",recommendtag.sub_number / 10000.0];
    }
    self.subNumbelLable.text = subNumber;
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end

//
//  ZWShowPictureViewController.m
//  test－ 网路
//
//  Created by zw on 16/2/26.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWShowPictureViewController.h"
#import "ZWTopicModel.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"

@interface ZWShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *PictureScrollView;

@property (weak, nonatomic) UIImageView *PictureImageView;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end

@implementation ZWShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImageView *PictureImageView = [[UIImageView alloc]init];
    PictureImageView.userInteractionEnabled = YES;
    
    [PictureImageView  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Back)]];
    
    [self.PictureScrollView addSubview:PictureImageView];
    self.PictureImageView = PictureImageView;
    
//    // 屏幕的高度和宽度
//    CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat ScreenH = [UIScreen mainScreen].bounds.size.height;
    
    // 图片的高度和宽度
    CGFloat PictureW = ZWScreenW;
    CGFloat pictureH = PictureW * self.topic.height / self.topic.width;
    
    if (pictureH > ZWScreenH) {// 图片高度大于屏幕高度
        PictureImageView.frame = CGRectMake(0, 0, PictureW, pictureH);
        self.PictureScrollView.contentSize = CGSizeMake(0, pictureH);
        
    }else{
    
        PictureImageView.size = CGSizeMake(PictureW, PictureW);
        PictureImageView.centerY = ZWScreenH * 0.5;
    }
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:self.topic.progress animated:NO];
    
    // 设置图片
    [PictureImageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        progress = (progress < 0) ? 0 : progress;
        
        [self.progressView setProgress:progress animated:YES];
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)Back{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)Save {
    if (self.PictureImageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载完毕"];
        return;
    }
    // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.PictureImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
    
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

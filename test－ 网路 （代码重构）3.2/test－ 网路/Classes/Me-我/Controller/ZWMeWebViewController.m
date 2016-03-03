//
//  ZWMeWebViewController.m
//  test－ 网路
//
//  Created by zw on 16/3/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ZWMeWebViewController.h"
#import "NJKWebViewProgress.h"

@interface ZWMeWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gobackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goforwardItem;

@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ZWMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc]init];
    
    self.webView.delegate = self.progress;
    
    __weak typeof(self) weakself = self;
    self.progress.progressBlock = ^(float progress) {
        
        weakself.progressView.progress = progress;
        
        weakself.progressView.hidden = (progress == 1.0);
    
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}

// 回退
- (IBAction)goback:(id)sender {
    [self.webView goBack];
}

// 前进
- (IBAction)goforward:(id)sender {
    [self.webView goForward];
}

// 刷新
- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

#pragma mark - webview的代理方法实现

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.gobackItem.enabled = webView.canGoBack;
    
    self.goforwardItem.enabled = webView.canGoForward;
}

@end

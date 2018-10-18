//
//  WebViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/18.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setLoadURL:(NSString *)loadURL{
    _loadURL = loadURL;
    [self.view addSubview:self.webView];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    ZNLog(@"开始加载");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    ZNLog(@"%@",error);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    ZNLog(@"加载完毕");
}

-(UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]];
        _webView.delegate = self;
        [_webView loadRequest:request];
    }
    return _webView;
}


@end

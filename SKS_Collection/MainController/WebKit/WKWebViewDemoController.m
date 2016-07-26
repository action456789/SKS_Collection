//
//  ViewController.m
//  MKMapViewDemo
//
//  Created by KeSen on 16/3/3.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "WKWebViewDemoController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewDemoController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
{
    WKWebView *_webView;
    UIProgressView *_progressView;
}
@end

@implementation WKWebViewDemoController

#pragma mark - lify cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createWebView];
    [self _createProgressView];
    [self _addObserver];
}

- (void)_createWebView
{
    // JS 与 OC 交互，需实现 WKScriptMessageHandler 协议
    // JS 与 OC 交互参见：https://lvwenhan.com/ios/460.html，https://lvwenhan.com/ios/461.html
    
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    [conf.userContentController addScriptMessageHandler:self name:@"OOXX"];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:conf];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    // 打开左划回退功能：
    _webView.allowsBackForwardNavigationGestures =YES;
    
    [self.view addSubview:_webView];
    
    NSString *urlString = @"http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)_createProgressView
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, ScreenWidth, 10);
    _progressView.progress = 0.0f;
    _progressView.progressTintColor = [UIColor clearColor];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView = progressView;
    [self.view addSubview:progressView];
}

- (void)_addObserver
{
    // 加载进度
    [_webView addObserver:self
               forKeyPath:@"estimatedProgress"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progressView.hidden = _webView.estimatedProgress == 1;
        [_progressView setProgress:_webView.estimatedProgress animated:YES];
    }
}

#pragma mark - WKNavigationDelegate

#pragma mark 加载过程追踪
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
    
    [_progressView setProgress:0.0f animated:NO];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s, %@", __func__, error);
}

#pragma mark 页面跳转
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}
    
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s", __func__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%s", __func__);
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKUIDelegate

// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return _webView;
}

// 剩下三个代理方法全都是与界面弹出提示框相关的，针对于web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。下面只举了警告框的例子。
// 可以把javascript的一些alert捕捉到，然后显示自定义的UI
/*
*  web界面中有弹出警告框时调用
*
*  @param webView           实现该代理的webview
*  @param message           警告框中的内容
*  @param frame             主窗口
*  @param completionHandler 警告框消失调用
*/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler
{
    NSLog(@"%s", __func__);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_webView.title
                                                                              message:message
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark - WKScriptMessageHandler

// 这个协议中包含一个必须实现的方法，这个方法是提高App与web端交互的关键，它可以直接将接收到的JS脚本转为OC或Swift对象。
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%s", __func__);
    
    // 接收到 Web 页面JS 代码时执行
    NSLog(@"message.name: %@, description: %@", message.name, [message.body description]);
    
    // 传递 JS 对象到
    if ([message.name isEqual: @"OOXX"]) {
        NSDictionary *dict = message.body;
        NSLog(@"%@, %@", dict[@"className"], dict[@"functionName"]);
    }
}
@end

//
//  ViewController.m
//  MKMapViewDemo
//
//  Created by KeSen on 16/3/3.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "WKWebViewDemoController.h"
#import <WebKit/WebKit.h>
#import "CalledByScriptObject.h"

#define kScriptMessage @"scriptMessage"

@interface WKWebViewDemoController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler/*JS 与 OC 交互，需实现 WKScriptMessageHandler 协议*/>
{
    WKWebView *_webView;
    UIProgressView *_progressView;
}
@end

@implementation WKWebViewDemoController

#pragma mark - lify cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createSubviews];
}

- (void)_createSubviews
{
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    conf.allowsInlineMediaPlayback = YES;
    conf.requiresUserActionForMediaPlayback = NO;
    //处理 JS 消息
    [conf.userContentController addScriptMessageHandler:self name:kScriptMessage];
    
    _webView = ({
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) configuration:conf];
        [self.view addSubview:webView];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.allowsBackForwardNavigationGestures =YES;
        
        NSString *urlString = @"http://www.baidu.com";
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL:url2];
        [webView loadRequest:request2];
        
        // 加载进度
        [webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        
        webView;
    });
    
    _progressView = ({
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, ScreenWidth, 20);
        progressView.progress = 0.0f;
        [self.view addSubview:progressView];
        
        progressView;
    });
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
//    NSLog(@"%s", __func__);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
//    NSLog(@"%s", __func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    NSLog(@"%s", __func__);
    
    [_progressView setProgress:0.0f animated:NO];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s, %@", __func__, error.description);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s, %@", __func__, error.description);
}

#pragma mark 页面跳转
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
//    NSLog(@"%s", __func__);
}
    
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
//    NSLog(@"%s", __func__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    NSLog(@"%s", __func__);
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

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    
}

#pragma mark - WKScriptMessageHandler

// 接收到 Web 页面 JS 代码时执行
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:kScriptMessage]) {
        
        if ([message.body isKindOfClass:[NSString class]]) {
            NSLog(@"message.name: %@, description: %@", message.name, [message.body description]);
        
        } else if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)message.body;
            
            NSString *className = dict[@"className"];
            NSString *functionName = dict[@"functionName"];
            
            NSLog(@"%@, %@", className, functionName);
            
            Class cls = NSClassFromString(className);
            if (cls) {
                id obj = [[cls alloc] init];
                
                SEL selector = NSSelectorFromString(functionName);
                if ([obj respondsToSelector:selector]) {
                    [obj performSelector:selector];
                } else {
                    NSLog(@"方法未找到");
                }
            } else {
                NSLog(@"类未找到");
            }
        }
        
    }
}
@end

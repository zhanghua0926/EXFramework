//
//  EXWKWebViewController.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXWKWebViewController.h"
#import "EXUIScreenDefine.h"
#import "UIView+EX.h"

static void *WebViewGoBackContext = &WebViewGoBackContext;
static void *WebViewProgressingContext = &WebViewProgressingContext;

@interface EXWKWebViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *reloadLabel;@end


@implementation EXWKWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createContentView];
}


- (void)createContentView {
    UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView = contentView;
    [self.view addSubview:_contentView];
    
    [self createWebView];
    
    UILabel *reloadLabel = [[UILabel alloc] init];
    reloadLabel.text = @"点击重新加载";
    CGSize size = [self.view sizeForLabel:reloadLabel];
    reloadLabel.frame = CGRectMake(0, 120, size.width, size.height);
    reloadLabel.userInteractionEnabled = YES;
    reloadLabel.centerX = _contentView.centerX;
    reloadLabel.hidden = YES;
    self.reloadLabel = reloadLabel;
    [self.view addSubview:reloadLabel];
    
    UITapGestureRecognizer *reloadTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadTap:)];
    reloadTap.numberOfTapsRequired = 1;
    reloadTap.numberOfTouchesRequired = 1;
    [self.reloadLabel addGestureRecognizer:reloadTap];
}


- (void)createWebView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    webView.allowsBackForwardNavigationGestures = NO;
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:WebViewGoBackContext];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:WebViewProgressingContext];
    self.webView = webView;
    [self.view addSubview:_webView];
    
    WKWebViewConfiguration *configuration = webView.configuration;
    configuration.mediaPlaybackRequiresUserAction = YES;
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
}


- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
}


- (void)loadURLRequest:(NSString *)urlString {
    _url = urlString;
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url
                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                        timeoutInterval:10.0];
    [_webView loadRequest:request];
}


- (void)reloadTap:(UITapGestureRecognizer *)tap {
    self.reloadLabel.hidden = YES;
    [self loadURLRequest:_url];
}


- (void)reloadURL {
    [self loadURLRequest:_url];
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == WebViewGoBackContext) {
        BOOL can = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        [self showNavBackBtn:can];
    }
    
    if (context == WebViewProgressingContext) {
        NSLog(@"%f", _webView.estimatedProgress);
    }
}


#pragma mark - GoBack
- (void)webViewGoBack {
    if (_webView.canGoBack) {
        [self.webView goBack];
    }
}


- (void)navBack {
    if ([self canGoBack]) {
        [self webViewGoBack];
        
    } else {
        [super navBack];
    }
    
}


- (BOOL)canGoBack {
    return _webView.canGoBack;
}


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        [weakSelf didAlertOK];
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
        [weakSelf didAlertCancel];
    }])];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
        [weakSelf didAlertOK];
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


#pragma mark - AlertTransition
- (void)didAlertOK {
    
}


- (void)didAlertCancel {
    
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // Loading.
    
    [self startProvisionalNavigation:navigation];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // Stop load;
    
    self.reloadLabel.hidden = YES;
    [self finishNavigation:navigation];
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.reloadLabel.hidden = NO;
    
    [self failProvisionalNavigation:navigation];
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // Stop load;
    
    self.reloadLabel.hidden = NO;
    [self failNavigation:navigation];
}


- (void)reloadWebView:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}


#pragma mark - WebViewNavigationTransition
- (void)startProvisionalNavigation:(WKNavigation *)navigation {
    
}


- (void)finishNavigation:(WKNavigation *)navigation {
    
}


- (void)failProvisionalNavigation:(WKNavigation *)navigation {
    
}


- (void)failNavigation:(WKNavigation *)navigation {
    
}


@end

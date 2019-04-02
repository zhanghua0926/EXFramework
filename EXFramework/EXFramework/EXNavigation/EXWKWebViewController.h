//
//  EXWKWebViewController.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXBaseViewController.h"
#import <WebKit/WebKit.h>

typedef enum {
    OK,
    Cancel,
}WebAlertStatus;


@interface EXWKWebViewController : EXBaseViewController

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign, readonly) BOOL canGoBack;

@property (nonatomic, copy, readonly) NSString *url;


- (void)webViewGoBack;

- (void)loadURLRequest:(NSString *)urlString;

- (void)reloadURL;

- (void)didAlertOK;

- (void)didAlertCancel;

- (void)startProvisionalNavigation:(WKNavigation *)navigation;

- (void)finishNavigation:(WKNavigation *)navigation;

- (void)failProvisionalNavigation:(WKNavigation *)navigation;

- (void)failNavigation:(WKNavigation *)navigation;

@end


//
//  PTWKWebViewVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaBaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTWKWebViewVC : PickTaBaseViewController

@property (nonatomic, copy) NSString *htmlStringContent;
@property (nonatomic, copy) NSString *startURL;

// 需要注意的是 ，这个webview使用webviewJSBridge设置了delegate , 所以不能直接设置delegate， 请使用下面的 webViewDelegate属性。
@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic,weak) id<WKNavigationDelegate> webViewDelegate;

+ (instancetype)webViewControllerWithURL:(NSString *)url;
+ (instancetype)webViewControllerWithContent:(NSString *)htmlStringContent;

@end

NS_ASSUME_NONNULL_END

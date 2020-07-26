//
//  PTWKWebViewVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTWKWebViewVC.h"

@interface PTWKWebViewVC () <WKScriptMessageHandler, WKNavigationDelegate>
@property (nonatomic, strong) WKUserContentController *web_userContentController;
@property (nonatomic, copy) NSString *routerURL;
@end
@implementation PTWKWebViewVC

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"title"];
}

+ (instancetype)webViewControllerWithURL:(NSString *)url {
    NSParameterAssert(!url || [url isKindOfClass:[NSString class]]);

    PTWKWebViewVC *controller = [[self alloc] init];
    controller.startURL = url;

    return controller;
}

+ (instancetype)webViewControllerWithContent:(NSString *)htmlStringContent {
    NSParameterAssert(!htmlStringContent || [htmlStringContent isKindOfClass:[NSString class]]);

    PTWKWebViewVC *controller = [[self alloc] init];
    controller.htmlStringContent = htmlStringContent;

    return controller;
}

- (void)loadView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc]init];
    //2.1最小字体大小
    // 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 14.f;
    //2.2是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    //2.3是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;   // 默认为NO
    // 2.4添加
    config.preferences = preference;
    //3、一般配置
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置视频是否需要用户手动播放，设置为NO则会允许自动播放
//    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 （在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称（ iOS9后可用
//    config.applicationNameForUserAgent = @"lyxy_fx_v1.0.0_1";

    NSString *injectionJSString = @"var script = document.createElement('meta');"
        "script.name = 'viewport';"
        "script.content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:injectionJSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    _web_userContentController = [[WKUserContentController alloc] init];
    [_web_userContentController addUserScript:wkUScript];
    [_web_userContentController addScriptMessageHandler:self name:@"lyxyShareAction"];
    [_web_userContentController addScriptMessageHandler:self name:@"lyxySaveAction"];
    [_web_userContentController addScriptMessageHandler:self name:@"lyxyJsToNative"];
    config.userContentController = _web_userContentController;

    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) configuration:config];
    _webView.allowsBackForwardNavigationGestures = YES;
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_startURL) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_startURL]]];
    }

    if (_htmlStringContent) {
           NSString *formatString = @"<span style=\"font-size:14px;color:#666666\">%@</span>";
            NSString *str = [_htmlStringContent stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
           NSString *htmlString = [NSString stringWithFormat:formatString, str];
        
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
//    _bridge = [XSWJVASPTWebViewBridge bridgeWithWKWebView:_webView];
//    _bridge.webviewController = self;
}

- (void)setWebViewDelegate:(id<WKNavigationDelegate>)webViewDelegate {
    _webViewDelegate = webViewDelegate;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - router register

// 加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    WS(weakSelf)
    NSString *injectionJSString = @"var script = document.createElement('meta');"
        "script.name = 'viewport';"
        "script.content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];

    NSString *js = @"var script = document.createElement('script');"
        "script.type = 'text/javascript';"
        "script.text = \"function ResizeImages() { "
        "var myimg,oldwidth;"
        "var maxwidth = %f;"
        "for(i=0;i <document.images.length;i++){"
        "myimg = document.images[i];"
        "if(myimg.width > maxwidth){"
        "oldwidth = myimg.width;"
        "myimg.width = %f;"
        "}"
        "}"
        "}\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 15];
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"ResizeImages();"completionHandler:nil];

    // 设置字体
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='PingFangSC-Regular';";
    [webView evaluateJavaScript:fontFamilyStr completionHandler:nil];
    //设置颜色
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#333333'" completionHandler:nil];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        [webView reload];
//    });
}

#pragma mark - WKDelegate

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSString *url = [message.body stringByRemovingPercentEncoding];
//    NSDictionary *parameter = [url spt_fetchParameterAndRouter];
//
//    if ([message.name isEqualToString:@"lyxySaveAction"]) {
//        // [self.view makeToast:msg duration:1.0f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
//        [self.view makeToastActivity:[NSValue valueWithCGPoint:self.view.center]];
//        UIImageView *_imv = UIImageView.new;
//        [_imv sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
//            [self.view hideToastActivity];
//            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//
//            if (status == PHAuthorizationStatusNotDetermined) {// 2.判断用户的授权状态
//                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {// 如果状态是不确定的话,block中的内容会等到授权完成再调用
//                    if (status == PHAuthorizationStatusAuthorized) {// 授权完成就会调用
//                        dispatch_sync(dispatch_get_main_queue(), ^{//调用存储图片的方法
//                                          // [self cgfv_createImage:YES];
//                                          UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//                                      });
//                    }
//                }];
//                //如果允许访问
//            } else if (status == PHAuthorizationStatusAuthorized) {
//                //调用存储图片的方法
//                // [self cgfv_createImage:YES];
//                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//                //如果权限是拒绝
//            } else {
//                [self.view makeToast:@"进入设置界面->找到当前应用->打开允许访问相册开关" duration:3.0f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
//            }
//        }];
//    } else if ([message.name isEqualToString:@"lyxyShareAction"]) {
//        [self cgfv_wxshare:url];
//    } else if ([message.name isEqualToString:@"lyxyJsToNative"] && parameter.count) {
//        XSWJVASPTData *params = [XSWJVASPTData dataForTransmission];
//
//        if (parameter.count == 1) {
//            params = nil;
//            [[XSWJVASPTRouter sharedRouter] jumpTo:[parameter objectForKey:JUMPE_ROUTER] fromViewController:self withParams:params finishBlock:^(XSWJVASPTData *payload) {}];
//        } else if ([[parameter objectForKey:JUMPE_ROUTER] isEqualToString:@"lyxy://goods/detail"]) {
//            if ([[parameter allKeys] containsObject:@"sku"]) {
//                [params setData:[parameter objectForKey:@"sku"] forKey:@"SKUID"];
//            }
//
//            if ([[parameter allKeys] containsObject:@"spu"]) {
//                [params setData:[parameter objectForKey:@"spu"] forKey:@"SPUID"];
//            }
//
//            [[XSWJVASPTRouter sharedRouter] jumpTo:[parameter objectForKey:JUMPE_ROUTER] fromViewController:self withParams:params finishBlock:^(XSWJVASPTData *payload) {}];
//        } else if ([[parameter objectForKey:JUMPE_ROUTER] isEqualToString:@"lyxy://goods/brand"]) {
//            if ([[parameter allKeys] containsObject:@"brandId"]) {
//                [params setData:[parameter objectForKey:@"brandId"] forKey:@"brandId"];
//            }
//
//            [[XSWJVASPTRouter sharedRouter] jumpTo:[parameter objectForKey:JUMPE_ROUTER] fromViewController:self withParams:params finishBlock:^(XSWJVASPTData *payload) {}];
//        } else if ([[parameter objectForKey:JUMPE_ROUTER] isEqualToString:@"lyxy://share/html"]) {
//            [self spt_addRightBarButtonWithImage:[UIImage imageNamed:@"share_btn"]];
//            self.routerURL = url;
//        }
//    }
}

#pragma mark - Navigation Action

- (void)spt_rightBarButtonAction {
//    NSDictionary *parameter = [self.routerURL spt_fetchParameterAndRouter];
//    [self shareWithHtmlParameter:parameter];
}

#pragma mark - 保存图片回调方法

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil;

    if (error != NULL) {
        msg = @"保存图片失败";
    } else {
        msg = @"保存图片成功，可到相册查看";
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)attributedStringWithHTMLString:(NSString *)htmlString {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding) };
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];

    return string.string;
}

@end

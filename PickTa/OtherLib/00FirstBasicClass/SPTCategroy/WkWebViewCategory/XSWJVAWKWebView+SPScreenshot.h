//
//  WKWebView+SPScreenshot.h
//  shop
//
//  Created by u on 2019/3/19.
//  Copyright © 2019 u. All rights reserved.
//

#import <WebKit/WebKit.h>



@interface WKWebView (SPScreenshot)

- (void)screenShotCompletion:(void (^)(UIImage *image))completion;

@end



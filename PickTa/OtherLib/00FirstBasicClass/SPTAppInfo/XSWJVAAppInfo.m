//
//  XSWJVAAppInfo.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAAppInfo.h"

@implementation XSWJVAAppInfo

// 获取设备系统
+ ( NSUInteger )getDeviceSystemVersion {
    return [[[[[UIDevice currentDevice] systemVersion]
        componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
}

// APP的版本号
+ ( NSString* )appVersion {
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString*     appVersion     = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    return appVersion;
}

+ ( NSString* )appName {
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString*     appName        = [infoDictionary objectForKey:@"CFBundleDisplayName"];

    return appName;
}

+ ( NSString* )appLogo {
    NSDictionary* infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString*     icon      = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];

    return icon;
}

+ ( NSString* )buildVersion {
    NSDictionary* infoPlist    = [[NSBundle mainBundle] infoDictionary];
    NSString*     buildVersion = [infoPlist objectForKey:@"CFBundleVersion"];

    return buildVersion;
}

#pragma mark - FrontWindow

+ (UIWindow *)frontWindow {
    NSEnumerator *enumerator = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    
    for (UIWindow *window in enumerator) {
        BOOL windowOnMainScreen = (window.screen == [UIScreen mainScreen]);
        BOOL windowIsVisible = !window.isHidden && window.alpha > 0;
        
        if (windowOnMainScreen && windowIsVisible && window.isKeyWindow) {
            return window;
        }
    }
    
    UIWindow *applicationWindow = [[UIApplication sharedApplication].delegate window];
    if (!applicationWindow) NSLog(@"**** Window is nil!");
    
    return applicationWindow;
}

@end

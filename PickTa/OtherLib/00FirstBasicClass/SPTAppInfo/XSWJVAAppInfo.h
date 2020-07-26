//
//  XSWJVAAppInfo.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XSWJVAAppInfo : NSObject

// 获取设备系统
+ (NSUInteger)getDeviceSystemVersion;
// APP信息
+ (NSString *)appVersion;
+ (NSString *)appName;
+ (NSString *)appLogo;
+ (NSString *)buildVersion;

+ (UIWindow *)frontWindow;

@end



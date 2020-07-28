//
//  AppDelegate.m
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "AppDelegate.h"
#import "HXLanguageManager.h"
#import "PickTaRootViewController.h"
#import "PickTaMSGTabBarController.h"
#import "PickTaLoginVC.h"
#import "PTMyModel.h"
#import "PTRegister2VC.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [defaults objectForKey:UserLanguage];
    
    if (language.length == 0) {
        [kLanguageManager setUserlanguage:@"zh-Hans-CN"];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginSuccess) name:LoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMSg) name:ChangedMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNeedLogin) name:OutLogin object:nil];
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if(String_IsEmpty([PickTaUserDefaults g_getToken])){
        [self changeNeedLogin];
    }else{
        [self.window setRootViewController:PickTaRootViewController.new];
    }
    [self.window makeKeyAndVisible];
    
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setContainerView:self.window];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    return YES;
}

- (void)changeLoginSuccess{
    NSString *string = [PickTaUserDefaults g_getValueForKey:@"user_info"];

    if (string.length) {
        PTMyModel *myModel = [PTMyModel modelWithJSON:string];

        if (myModel.sex == 0) {
            PTRegister2VC *vc = [[PTRegister2VC alloc] initWithNibName:@"PTRegister2VC" bundle:nil];
            [[XSWJVASPTHelper getCurrentVC].navigationController pushViewController:vc animated:YES];
        } else {
            [self.window setRootViewController:PickTaRootViewController.new];
        }
    } else {
        [self.window setRootViewController:PickTaRootViewController.new];
    }
//    PTMyModel *myModel = [PTMyModel modelWithJSON:obj[@"user"]];
//                   [subscriber sendNext:myModel];
//                   [subscriber sendCompleted];
//                   [PickTaUserDefaults g_setValue:[myModel modelToJSONString]forKey:@"user_info"]
}

- (void)changeMSg{
//    [self.window setRootViewController:PickTaMSGTabBarController.new];
    [SVProgressHUD showInfoWithStatus:@"正在开发中..."];
}

-(void)changeNeedLogin {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"LoginViews" bundle:nil];
    PickTaLoginVC * loginVC = [storyBoard instantiateViewControllerWithIdentifier:@"PickTaLoginVC"];
    UINavigationController *navCtrlr = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.window setRootViewController:navCtrlr];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kAliPayResponseNoti" object:resultDic[@"resultStatus"]];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

@end

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
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if(String_IsEmpty([PickTaUserDefaults g_getToken])){
        [self changeNeedLogin];
    }else{
        [self.window setRootViewController:PickTaRootViewController.new];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)changeLoginSuccess{
    NSString *string = [PickTaUserDefaults g_getValueForKey:@"user_info"];
    
    if (string.length) {
        PTMyModel *myModel = [PTMyModel modelWithJSON:string];
        
        if (myModel.sex == 1) {
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

-(void)changeMSg{
    [self.window setRootViewController:PickTaMSGTabBarController.new];
}

-(void)changeNeedLogin {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"LoginViews" bundle:nil];
    PickTaLoginVC * loginVC = [storyBoard instantiateViewControllerWithIdentifier:@"PickTaLoginVC"];
    UINavigationController *navCtrlr = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.window setRootViewController:navCtrlr];
}



@end

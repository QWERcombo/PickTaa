//
//  PickTaRootViewController.m
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaRootViewController.h"
#import "CYLPlusButtonSubclass.h"
#import "PickTaMSGTabBarController.h"
#import <YYKit/YYKit.h>

@interface PickTaRootViewController ()

@end

@implementation PickTaRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNewTabBar];
}

- (CYLTabBarController *)createNewTabBar {
    [CYLPlusButtonSubclass registerPlusButton];
    return [self createNewTabBarWithContext:nil];
}

- (CYLTabBarController *)createNewTabBarWithContext:(NSString *)context {
    PickTaMainTabBarController *tabBarController = [[PickTaMainTabBarController alloc] initWithContext:context];
    self.viewControllers = @[tabBarController];
    return tabBarController;
}

/**
- (CYLTabBarController *)createMSGTabBarWithContext:(NSString *)context{
    PickTaMSGTabBarController *tabBarController = [[PickTaMSGTabBarController alloc] init];
    self.viewControllers = @[tabBarController];
    return tabBarController;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

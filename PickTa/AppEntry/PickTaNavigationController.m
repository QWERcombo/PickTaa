//
//  PickTaNavigationController.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaNavigationController.h"

@interface PickTaNavigationController ()

@end

@implementation PickTaNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationBar.tintColor = [UIColor redColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor systemGrayColor]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, 0)
    forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    viewController.hidesBottomBarWhenPushed = YES;
    viewController.hidesBottomBarWhenPushed = (self.viewControllers.count > 0);
    [super pushViewController:viewController animated:YES];
}


@end

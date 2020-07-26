//
//  PickTaMSGTabBarController.m
//  PickTa
//
//  Created by Stark on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaMSGTabBarController.h"
#import "PickTaNavigationController.h"
#import "PickTaMeVC.h"
#import "PickTaChatsVC.h"
#import "PickTaContactsVC.h"
#import "PickTaDiscoverVC.h"


@interface PickTaMSGTabBarController ()

@end

@implementation PickTaMSGTabBarController

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                         imageInsets:imageInsets
                                                                             titlePositionAdjustment:titlePositionAdjustment
                                                                                             context:nil
                                             ];
    [self customizeTabBarAppearance];
    
    //    self.navigationController.navigationBar.hidden = YES;
    return (self = (PickTaMSGTabBarController *)tabBarController);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSArray *)viewControllers {
    
    PickTaChatsVC *chatsVC = [PickTaChatsVC new];
    PickTaNavigationController *chatsNaV = [[PickTaNavigationController alloc]initWithRootViewController:chatsVC];
    
    PickTaContactsVC *contactsVC = [PickTaContactsVC new];
    PickTaNavigationController *contactsNAV = [[PickTaNavigationController alloc]initWithRootViewController:contactsVC];
    
    PickTaDiscoverVC *disVC = [PickTaDiscoverVC new];
    PickTaNavigationController *disNAV = [[PickTaNavigationController alloc]initWithRootViewController:disVC];
    
    PickTaMeVC *meVC = [PickTaMeVC new];
    PickTaNavigationController *meNAV = [[PickTaNavigationController alloc]initWithRootViewController:meVC];
    
    NSArray *viewControllers = @[chatsNaV,contactsNAV,disNAV,meNAV];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemImage : @"msg_tab_0_unsel",
        CYLTabBarItemSelectedImage : @"msg_tab_0_sel",
        CYLTabBarItemTitle : @""
    };
    
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemImage : @"msg_tab_1_unsel",
        CYLTabBarItemSelectedImage : @"msg_tab_1_sel",
        CYLTabBarItemTitle : @""
    };
    
    NSDictionary *threeTabBarItemsAttributes = @{
        CYLTabBarItemImage : @"msg_tab_2_unsel",
        CYLTabBarItemSelectedImage : @"msg_tab_2_sel",
        CYLTabBarItemTitle : @""
    };
    
    NSDictionary *fourTabBarItemsAttributes = @{
        CYLTabBarItemImage : @"msg_tab_3_unsel",
        CYLTabBarItemSelectedImage : @"msg_tab_3_sel",
        CYLTabBarItemTitle : @""
    };
    
    
    NSArray *tabBarItemsAttributes = @[
        firstTabBarItemsAttributes,
        secondTabBarItemsAttributes,
        threeTabBarItemsAttributes,
        fourTabBarItemsAttributes
    ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance
{
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor ess_newRed];
//    
//    UITabBarItem *tabBar = [UITabBarItem appearance];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


@end

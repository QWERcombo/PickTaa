//
//  PickTaRootViewController.h
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaMainTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaRootViewController : UINavigationController
- (CYLTabBarController *)createNewTabBarWithContext:(NSString *)context;

@end

NS_ASSUME_NONNULL_END

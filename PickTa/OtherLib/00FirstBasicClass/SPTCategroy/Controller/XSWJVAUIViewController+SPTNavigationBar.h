//
//  UIViewController.h
//  BJEIO
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SPTNavigationBar)

- (void)setStatusBarBackgroundColor:(UIColor *)color;// 状态栏背景颜色
- (void)setNavigationTitle:(NSString *)title;// 设置标题
- (void)setBlackNavigationTitle:(NSString *)title;// 设置黑色标题
- (void)setNavigationTitle:(NSString *)title textColor:(UIColor *)color;// 设置标题及标题颜色

- (void)textFieldDidChange:(UITextField *)textField;

- (void)spt_addLoginLeftButton;
- (void)spt_popViewController;

- (void)spt_addRightBarButtonWithFirstImage:(UIImage *)firstImage;
- (void)spt_addRightBarButtonItemWithTitleSend:(NSString *)itemTitle;
- (void)spt_addRightBarButtonItemWithWhiteTitle:(NSString *)itemTitle;
- (void)spt_addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage;
- (void)spt_addRightTwoBarButtonsWithFirstText:(NSString *)firstTitle secondImage:(UIImage *)secondImage;
- (void)spt_addRightBarButtonWithImage:(UIImage *)infoImage;

- (void)spt_addCommonBackButton;
- (void)spt_addCommonBackButton:(NSString *)imageName;

- (void)spt_rightBarButtonAction;
- (void)spt_secondRightBarButtonAction;
- (void)spt_addLeftBarButtonItemWithTitle:(NSString *)itemTitle;
- (void)spt_longTimePressAction;

@end


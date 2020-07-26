//
//  UIViewController.m
//  BJEIO
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVAUIViewController+SPTNavigationBar.h"

@implementation UIViewController (SPTNavigationBar)

- (void)spt_addCommonBackButton {
    [self spt_addCommonBackButton:@"common_back_bar"];
}

- (void)spt_addCommonBackButton:(NSString *)imageName {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 44, 44);
    [leftBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftBarButton addTarget:self action:@selector(spt_popViewController) forControlEvents:UIControlEventTouchUpInside];
   
    if (IOS_VERSION >= 11.0) {
        [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    }

    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceBarButtonItem, leftBarButtonItem];
}

- (void)spt_addLoginLeftButton {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 44, 44);
    [leftBarButton setImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    [leftBarButton addTarget:self action:@selector(spt_back) forControlEvents:UIControlEventTouchUpInside];
   
    if (IOS_VERSION >= 11.0) {
        [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    }
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceBarButtonItem, leftBarButtonItem];
}

- (void)spt_back {
    if (self.navigationController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)spt_popViewController {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)spt_addRightBarButtonWithFirstImage:(UIImage *)firstImage {
    UIBarButtonItem *rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:firstImage style:UIBarButtonItemStylePlain target:self action:@selector(spt_rightBarButtonAction)];
        item.tintColor = [UIColor whiteColor];
        item;
    });

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = -5;
    self.navigationItem.rightBarButtonItems = @[spaceBarButtonItem, rightBarButtonItem];
}

- (void)spt_addRightBarButtonWithImage:(UIImage *)infoImage {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 44, 44)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(spt_longTimePressAction)];
    longPress.minimumPressDuration = 0.7f; //定义按的时间
    [backBtn addGestureRecognizer:longPress];
    [backBtn addTarget:self action:@selector(spt_rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:infoImage forState:UIControlStateNormal];

    if (IOS_VERSION >= 11.0) {
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
    }
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:backBtn];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    self.navigationItem.rightBarButtonItem = backBarBtn;
}

- (void)spt_addRightBarButtonItemWithTitleSend:(NSString *)itemTitle {
    UIBarButtonItem *rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(spt_rightBarButtonAction)];
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: COLOR_RGB(129, 227, 141)} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor lightGrayColor]} forState:UIControlStateDisabled];
        item;
    });
    
    rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = 8;
    self.navigationItem.rightBarButtonItems = @[spaceBarButtonItem, rightBarButtonItem];
}

- (void)spt_addRightBarButtonItemWithWhiteTitle:(NSString *)itemTitle {
    UIBarButtonItem *rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(spt_rightBarButtonAction)];
        item.tintColor = COLOR_HEX_RGB(0xFC4E3E);
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
        item;
    });
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = 10;
    self.navigationItem.rightBarButtonItems = @[spaceBarButtonItem, rightBarButtonItem];
}


- (void)spt_addLeftBarButtonItemWithTitle:(NSString *)itemTitle {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 44, 44);
    [leftBarButton addTarget:self action:@selector(spt_popViewController) forControlEvents:UIControlEventTouchUpInside];
    [leftBarButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];

    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = -8;
    self.navigationItem.leftBarButtonItems = @[spaceBarButtonItem, leftBarButtonItem];
}

- (void)spt_addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage; {
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(44, 0, 44, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(spt_rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *firstItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];

    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, 44, 44);
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(spt_secondRightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *secondItem = [[UIBarButtonItem alloc] initWithCustomView:secondButton];

    self.navigationItem.rightBarButtonItems = @[firstItem, secondItem];
}

- (void)spt_addRightTwoBarButtonsWithFirstText:(NSString *)firstTitle secondImage:(UIImage *)secondImage {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 108, 44)];
    view.backgroundColor = [UIColor clearColor];

    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(64, 0, 44, 44);
    [firstButton setImage:secondImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(spt_rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:firstButton];

    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, 64, 44);
    [secondButton setTitle:firstTitle forState:UIControlStateNormal];
    secondButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(spt_secondRightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:secondButton];

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButtonItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[spaceBarButtonItem, rightBarButtonItem];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];

    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)setNavigationTitle:(NSString *)title {
    [self setNavigationTitle:title textColor:[UIColor whiteColor]];
}

- (void)setBlackNavigationTitle:(NSString *)title {
    if (LESS_10) {
        self.title = title;
    } else {
        [self setNavigationTitle:title textColor:COLOR_HEX_RGB(0x303030)];
    }
}

- (void)setNavigationTitle:(NSString *)title textColor:(UIColor *)color {
    UILabel *label = UILabel.new;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:18];
    label.text = title;
    
    self.navigationItem.titleView = label;
}

- (void)spt_rightBarButtonAction { }
- (void)spt_secondRightBarButtonAction { }
- (void)spt_longTimePressAction { }

- (void)textFieldDidChange:(UITextField *)textField {
    CGFloat maxLength = textField.tag;
    NSString *toBeString = textField.text;

    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
   
    if (!position || !selectedRange) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:maxLength];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


@end

//
//  NSLayoutConstraint+IBDesignable.m
//  lanJinRong
//
//  Created by xc2 on 2018/4/27.
//  Copyright © 2018年 lanJinRong. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"



#define SUIT_PARAM kScreenWidth / 375


@implementation NSLayoutConstraint (IBDesignable)


- (void)setAdapterScreen:(BOOL)adapterScreen {
    if (adapterScreen) {
        self.constant = self.constant * SUIT_PARAM;
    }
}

- (BOOL)adapterScreen {
    return YES;
}

@end

//
//  CALayer+XibConfiguration.m
//  LanJinRong2
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 Lure. All rights reserved.
//

#import "XSWJVACALayer+XibConfiguration.h"
#import <UIKit/UIKit.h>

@implementation CALayer (XibConfiguration)


- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


@end

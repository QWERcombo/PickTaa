//
//  CALayer+LayerColor.m
//  BHBaiXiang
//
//  //  Created by SOPOCO_ljt on 2017/3/2.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "XSWJVACALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (void)setShadowUIColor:(UIColor *)color {
    self.shadowColor = color.CGColor;
}

- (UIColor *)shadowUIColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end

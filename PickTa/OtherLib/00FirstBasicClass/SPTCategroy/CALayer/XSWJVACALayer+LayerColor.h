//
//  CALayer+LayerColor.h
//  BHBaiXiang
//
//  //  Created by SOPOCO_ljt on 2017/3/2.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color;

- (void)setShadowUIColor:(UIColor *)color;


@end

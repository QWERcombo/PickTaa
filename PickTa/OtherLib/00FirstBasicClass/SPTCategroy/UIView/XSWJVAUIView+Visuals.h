//
//  UIView+Visuals.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/7.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Visuals)

/**
 设置不规则圆角
 @param radius 圆角半径
 */
- (void)spt_setCouponsSepraWithradius:(CGFloat)radius;

/**
 设置聊天气泡形状
 
 @param triH 底部等边三角形高度
 */
- (void)spt_setChatBoubleWith:(CGFloat)triH andXVerExcursion:(CGFloat)xVerExcursion;

/**
 画圆
 
 @param radius 半径
 */
- (void)spt_setCircleWithWith:(CGFloat)radius;

/**
 设置圆角 边线 边线颜色
 
 @param radius 圆角半径
 @param size 边线宽
 @param color 边线颜色
 */
- (void)spt_cornerRadius:(CGFloat)radius
          strokeSize:(CGFloat)size
               color:(UIColor *)color;

/**
 设置圆角
 
 @param corners 圆角位置
 @param radius 圆角半径
 */
- (void)spt_setRoundedCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius;


/**
 设置阴影
 
 @param color 颜色
 @param offset 偏移量
 @param opacity The opacity of the shadow. Defaults to 0. Specifying a value outside the
 * [0,1] range will give undefined results. Animatable.
 @param radius 圆角半径
 */
- (void)spt_shadowWithColor:(UIColor *)color
                 offset:(CGSize)offset
                opacity:(CGFloat)opacity
                 radius:(CGFloat)radius;

/*
 *  Removes from superview with fade
 */
- (void)spt_removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
- (void)spt_addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
- (void)spt_removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
- (void)spt_rotateByAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
          autoreverse:(BOOL)autoreverse
          repeatCount:(CGFloat)repeatCount
       timingFunction:(CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
- (void)spt_moveToPoint:(CGPoint)newPoint
           duration:(NSTimeInterval)duration
        autoreverse:(BOOL)autoreverse
        repeatCount:(CGFloat)repeatCount
     timingFunction:(CAMediaTimingFunction *)timingFunction;

@end

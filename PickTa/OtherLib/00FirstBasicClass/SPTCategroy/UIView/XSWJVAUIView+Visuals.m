//
//  UIView+Visuals.m
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/7.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVAUIView+Visuals.h"
#import "XSWJVAUIBezierPath+SPTUI.h"

#define degToRad(x) (M_PI * (x) / 180.0)

@implementation UIView (Visuals)

- (void)spt_setCircleWithWith:(CGFloat)radius {
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath spt_circleWith:rect];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)spt_setChatBoubleWith:(CGFloat)triH andXVerExcursion:(CGFloat)xVerExcursion {
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath spt_chatBubble:rect andTriHight:triH andXVerExcursion:xVerExcursion];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)spt_setCouponsSepraWithradius:(CGFloat)radius {
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath spt_couponsSepra:rect andRadis:radius];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)spt_cornerRadius:(CGFloat)radius strokeSize:(CGFloat)size color:(UIColor *)color {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = size;
}

- (void)spt_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)spt_shadowWithColor:(UIColor *)color
                 offset:(CGSize)offset
                opacity:(CGFloat)opacity
                 radius:(CGFloat)radius {
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)spt_removeFromSuperviewWithFadeDuration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    self.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)spt_addSubview:(UIView *)subview withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self cache:YES];
    [self addSubview:subview];
    [UIView commitAnimations];
}

- (void)spt_removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self.superview cache:YES];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)spt_rotateByAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
          autoreverse:(BOOL)autoreverse
          repeatCount:(CGFloat)repeatCount
       timingFunction:(CAMediaTimingFunction *)timingFunction {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.toValue = [NSNumber numberWithFloat:degToRad(angle)];
    rotation.duration = duration;
    rotation.repeatCount = repeatCount;
    rotation.autoreverses = autoreverse;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeBoth;
    rotation.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:rotation forKey:@"rotationAnimation"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)spt_moveToPoint:(CGPoint)newPoint
           duration:(NSTimeInterval)duration
        autoreverse:(BOOL)autoreverse
        repeatCount:(CGFloat)repeatCount
     timingFunction:(CAMediaTimingFunction *)timingFunction {
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.toValue = [NSValue valueWithCGPoint:newPoint];
    move.duration = duration;
    move.removedOnCompletion = NO;
    move.repeatCount = repeatCount;
    move.autoreverses = autoreverse;
    move.fillMode = kCAFillModeBoth;
    move.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:move forKey:@"positionAnimation"];
}

@end

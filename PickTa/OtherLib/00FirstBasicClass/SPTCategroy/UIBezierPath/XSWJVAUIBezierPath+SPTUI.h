//
//  UIBezierPath+SPTUI.m
//  Example
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (SPTUI)

+ (UIBezierPath *)spt_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)spt_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)spt_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)spt_chatBubble:(CGRect)originalFrame andTriHight:(CGFloat)triH andXVerExcursion:(CGFloat)xVerExcursion;
+ (UIBezierPath *)spt_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)spt_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;
+ (UIBezierPath *)spt_couponsSepra:(CGRect)originalFrame andRadis:(CGFloat)radis;
+ (UIBezierPath *)spt_insideCorner:(CGRect)originalFrame andRadis:(CGFloat)radis andTop:(BOOL)top;
+ (UIBezierPath *)spt_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)spt_circleWith:(CGRect)originalFrame;

/**
 * 创建一条支持四个角的圆角值不相同的路径
 * @param rect 路径的rect
 * @param cornerRadius 圆角大小的数字，长度必须为4，顺序分别为[左上角、左下角、右下角、右上角]
 * @param lineWidth 描边的大小，如果不需要描边（例如path是用于fill而不是用于stroke），则填0
 */
+ (UIBezierPath *)spt_bezierPathWithRoundedRect:(CGRect)rect cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius lineWidth:(CGFloat)lineWidth;


@end

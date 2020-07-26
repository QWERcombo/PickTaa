//
//  UIView+SDExtension.m
//  SDRefreshView
//
//  Created by aier on 15-2-23.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */


#import "UIView+SDExtension.h"

@implementation UIView (SDExtension)

- (CGFloat)sd_height
{
    return self.frame.size.height;
}

- (void)setSd_height:(CGFloat)sd_height
{
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}

- (CGFloat)sd_width
{
    return self.frame.size.width;
}

- (void)setSd_width:(CGFloat)sd_width
{
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}


- (CGFloat)sd_y
{
    return self.frame.origin.y;
}

- (void)setSd_y:(CGFloat)sd_y
{
    CGRect temp = self.frame;
    temp.origin.y = sd_y;
    self.frame = temp;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = maxY - CGRectGetHeight(self.frame);
    self.frame = tempFrame;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGPoint)toastPoint {
    return CGPointMake(self.centerX, self.bottom-TABBAR_HEIGHT-50);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - CGRectGetWidth(frame);
    self.frame = frame;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - CGRectGetHeight(frame);
    self.frame = frame;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setMaxX:(CGFloat)maxX {
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = maxX - CGRectGetWidth(self.frame);
    self.frame = tempFrame;
}

- (void)setWidthWithNotMoveCenter:(CGFloat)width {
    CGPoint tempCenter = self.center;
    [self setWidth:width];
    self.center = tempCenter;
}

- (void)setHeightWithNotMoveCenter:(CGFloat)height{
    CGPoint tempCenter = self.center;
    [self setHeight:height];
    self.center = tempCenter;
}

- (void)setSizeWithNotMoveCenter:(CGSize)size{
    CGPoint tempCenter = self.center;
    [self setSize:size];
    self.center = tempCenter;
}

@end

//
//  UIView+SDExtension.h
//  SDRefreshView
//
//  Created by aier on 15-2-23.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SDExtension)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)setWidthWithNotMoveCenter:(CGFloat)width;
- (void)setHeightWithNotMoveCenter:(CGFloat)height;
- (void)setSizeWithNotMoveCenter:(CGSize)size;
//- (void)sizeToFitWithNotMoveSide:(kDIRECTION)dir centerRemain:(BOOL)centerRemain;

@property (nonatomic, assign) CGPoint toastPoint;

@end

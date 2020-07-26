//
//  UIView+SPTUI.h
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/3.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (SPTUI)

// view的第一个viewcontroller
- (UIViewController *)spt_parentController;// 获取当前view的控制器

// 添加点击事件
- (void)spt_addTarget:(id)target tapAction:(SEL)action;//添加点击事件

#pragma mark - 分割线

// 自定义分割线View OffY
- (void)spt_addSeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY;
// 自定义底部分割线View
- (void)spt_addBottomSeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;
// 通过view，画任意方向的线
- (void)spt_addDrawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;
// 通过layer，画任意方向的线
- (void)spt_addDrawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

#pragma mark - 分割线 虚线

- (void)spt_addBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor cornerRadii:(CGSize)cornerRadii;
+ (void)spt_drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)spt_drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
- (void)spt_drawDashLineForVerWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

#pragma mark - 圆点

- (void)spt_addCirleViewWithX:(CGFloat)x y:(CGFloat)y;

@end



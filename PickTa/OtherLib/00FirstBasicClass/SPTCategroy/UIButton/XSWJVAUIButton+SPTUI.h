//
//  UIButton+SPTUI.h
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/3.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIButton (SPTUI)

- (void)wbc_changeTitleLeft;
- (void)wbc_changeTitleLeftWithPadding:(CGFloat)padding1;
- (void)wbc_changeTitleBottom;
- (void)wbc_changeTitleBottomWithPadding:(CGFloat)padding1;
- (void)wbc_changeTitleEdge:(UIEdgeInsets)edge;

/**
 倒计时
 
 @param timeLine 倒计时时间
 @param title 正常时显示文字
 @param subTitle 倒计时时显示的文字（不包含秒）
 @param countDoneBlock 倒计时结束时的Block
 @param isInteraction 是否希望倒计时时可交互
 */
- (void)wbc_countDownWithTime:(NSInteger)timeLine
                    withTitle:(NSString *)title
                  normalColor:(UIColor *)normalColor
                 disableColor:(UIColor *)disableColor
                         font:(UIFont *)font
            andCountDownTitle:(NSString *)subTitle
               countDoneBlock:(void (^)(UIButton *button))countDoneBlock
                isInteraction:(BOOL)isInteraction
                   needFormat:(BOOL)needFormat;

@end



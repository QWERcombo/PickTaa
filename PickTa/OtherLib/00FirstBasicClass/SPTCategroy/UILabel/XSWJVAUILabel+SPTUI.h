//
//  UILabel+SPTUI.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/20.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SPTUI)

/**
 文字 字体大小 字体颜色 对其方式
 
 @param frame 大小位置
 @param text 文字
 @param size 字体大小
 @param textColor 字体颜色
 @param align 对齐方式
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                           text:(NSString *)text
                    andFontSize:(CGFloat)size
                   andTextColor:(UIColor *)textColor
                          align:(NSTextAlignment)align;


/**
 文字 字体大小 字体颜色 背景色 边线颜色 边线宽度 对其方式
 
 @param frame 大小位置
 @param text 文字
 @param size 字体大小
 @param textColor 字体颜色
 @param bgColor 背景色
 @param boardColor 边线颜色
 @param width 边线宽度
 @param align 对其方式
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                           text:(NSString *)text
                    andFontSize:(CGFloat)size
                   andTextColor:(UIColor *)textColor
             andBackgroundColor:(UIColor *)bgColor
                  andBoardColor:(UIColor *)boardColor
                  andBoardWidth:(CGFloat)width
                          align:(NSTextAlignment)align;


/**
 label 富文本
 
 @param frame 大小位置
 @param attStr 富文本
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr;

/**
 label 富文本 对齐方式
 
 @param frame 大小位置
 @param attStr 富文本
 @param align 对其方式
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
                          align:(NSTextAlignment)align;

/**
 label 富文本 背景色
 
 @param frame 大小位置
 @param attStr 富文本
 @param bgColor 背景色
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)bgColor;

/**
 label 富文本 背景色 边线宽度默认为1
 
 @param frame 大小位置
 @param attStr 富文本
 @param color 背景色
 @param boardColor 边线颜色
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)color
                  andBoardColor:(UIColor *)boardColor;

/**
 label 富文本 背景色 边线宽度默认为1
 
 @param frame 大小位置
 @param attStr 富文本
 @param bgColor 背景色
 @param boardColor 边线颜色
 @param width 边线宽度
 @return label
 */
+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)bgColor
                  andBoardColor:(UIColor *)boardColor
                  andBoardWidth:(CGFloat)width;

+ (void)wbc_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;// 改变行间距
+ (void)wbc_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;// 改变字间距
+ (void)wbc_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;// 改变行间距和字间距

- (void)spt_setAttributePrice:(NSString *)price priceFuHaoFontSize:(CGFloat)fontSize priceFontSize:(CGFloat)priceFontSize;

@end

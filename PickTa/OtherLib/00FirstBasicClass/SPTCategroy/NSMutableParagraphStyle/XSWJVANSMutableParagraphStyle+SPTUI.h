//
//  NSMutableParagraphStyle+SPTUI.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableParagraphStyle (SPTUI)

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`spt_paragraphStyleWithLineHeight:lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight;

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`spt_paragraphStyleWithLineHeight:lineBreakMode:textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  快速创建一个NSMutableParagraphStyle
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @param  textAlignment   文本对齐方式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment;

@end

//
//  UILabel+SPTUI.m
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/20.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVAUILabel+SPTUI.h"
#import <objc/runtime.h>

@implementation UILabel (SPTUI)

+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                           text:(NSString *)text
                    andFontSize:(CGFloat)size
                   andTextColor:(UIColor *)textColor
                          align:(NSTextAlignment)align {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = textColor;
    label.textAlignment = align;
    return label;
}


+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                           text:(NSString *)text
                    andFontSize:(CGFloat)size
                   andTextColor:(UIColor *)textColor
             andBackgroundColor:(UIColor *)bgColor
                  andBoardColor:(UIColor *)boardColor
                  andBoardWidth:(CGFloat)width
                          align:(NSTextAlignment)align {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.layer.borderWidth = width;
    label.layer.borderColor = boardColor.CGColor;
    label.textAlignment = align;
    return label;
}


+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.attributedText = attStr;
    return label;
}

+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
                          align:(NSTextAlignment)align {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.attributedText = attStr;
    label.textAlignment = align;
    return label;
}

+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.attributedText = attStr;
    label.backgroundColor = bgColor;
    return label;
}

+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)color
                  andBoardColor:(UIColor *)boardColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.attributedText = attStr;
    label.backgroundColor = color;
    label.layer.borderWidth = 1;
    label.layer.borderColor = boardColor.CGColor;
    return label;
}

+ (UILabel *)wbc_labelWithFrame:(CGRect)frame
                      andAttStr:(NSAttributedString *)attStr
             andBackgroundColor:(UIColor *)bgColor
                  andBoardColor:(UIColor *)boardColor
                  andBoardWidth:(CGFloat)width {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.attributedText = attStr;
    label.backgroundColor = bgColor;
    label.layer.borderWidth = width;
    label.layer.borderColor = boardColor.CGColor;

    return label;
}

+ (void)wbc_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)wbc_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName: @(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)wbc_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName: @(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(setText:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(wbc_setText:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)wbc_setText:(NSString *)text {
    if ([text isKindOfClass:[NSNull class]] || text.length == 0 || text == nil || [text isEqualToString:@"(null)"]) {
        [self wbc_setText:@""];

        return;
    }

    [self wbc_setText:text];
}

- (void)spt_setAttributePrice:(NSString *)price priceFuHaoFontSize:(CGFloat)fontSize priceFontSize:(CGFloat)priceFontSize {
    NSString *string = [NSString stringWithFormat:@"¥  %@", price];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Black" size: fontSize], NSForegroundColorAttributeName: [UIColor colorWithRed:227/255.0 green:37/255.0 blue:34/255.0 alpha:1.0]}];
    [attString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Black" size: priceFontSize]} range:NSMakeRange(3, string.length-3)];
    self.attributedText = attString;
}





@end

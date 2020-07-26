//
//  NSMutableParagraphStyle+SPTUI.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSMutableParagraphStyle+SPTUI.h"

@implementation NSMutableParagraphStyle (SPTUI)

+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight {
    return [self spt_paragraphStyleWithLineHeight:lineHeight lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self spt_paragraphStyleWithLineHeight:lineHeight lineBreakMode:lineBreakMode textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)spt_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = textAlignment;
    
    return paragraphStyle;
}

@end

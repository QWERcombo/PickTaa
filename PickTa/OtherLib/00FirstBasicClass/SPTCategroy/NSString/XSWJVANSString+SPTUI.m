//
//  NSString+SPTUI.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSString+SPTUI.h"

@implementation NSString (SPTUI)

- (NSString *)spt_stringMatchedByPattern:(NSString *)pattern {
    NSRange range = [self rangeOfString:pattern options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound) {
        return [self substringWithRange:range];
    }
    
    return nil;
}

+ (NSString *)spt_hexStringWithInteger:(NSInteger)integer {
    NSString *hexString = @"";
    NSInteger remainder = 0;
    
    for (NSInteger i = 0; i < 9; i++) {
        remainder = integer % 16;
        integer = integer / 16;
        NSString *letter = [self hexLetterStringWithInteger:remainder];
        hexString = [letter stringByAppendingString:hexString];
        
        if (integer == 0) {
            break;
        }
    }
    
    return hexString;
}

+ (NSString *)hexLetterStringWithInteger:(NSInteger)integer {
    NSAssert(integer < 16, @"要转换的数必须是16进制里的个位数，也即小于16，但你传给我是%@", @(integer));
    
    NSString *letter = nil;
    switch (integer) {
        case 10:
            letter = @"A";
            break;
        case 11:
            letter = @"B";
            break;
        case 12:
            letter = @"C";
            break;
        case 13:
            letter = @"D";
            break;
        case 14:
            letter = @"E";
            break;
        case 15:
            letter = @"F";
            break;
        default:
            letter = [[NSString alloc]initWithFormat:@"%@", @(integer)];
            break;
    }
    
    return letter;
}

@end

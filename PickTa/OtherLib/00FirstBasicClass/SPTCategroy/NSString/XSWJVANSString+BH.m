//
//  NSString+BH.m
//  bankHuiClient
//
//  Created by 王帅广 on 16/3/17.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "XSWJVANSString+BH.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BH)

- (NSString *)md5HexDigest {
    const char *original_str = [self UTF8String];

    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, (CC_LONG) strlen(original_str), result);

    NSMutableString *hash = [NSMutableString string];

    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }

    return [hash lowercaseString];
}

+ (NSString *)makemd5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result); // This is the md5 call
    return [[NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ] lowercaseString];
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)insertSpaceForntAndBack {

    return [NSString stringWithFormat:@"  %@  ", self];
}

#pragma mark 清空字符串中的空白字符

- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串

- (BOOL)isEmptyString {
    return (self.length == 0);
}

- (BOOL)isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([self isEqualToString:@"NULL"] || [self isEqualToString:@"nil"] || [self isEqualToString:@"null"] || [self isEqualToString:@"Null"] || [self isEqualToString:@"(null)"]) {
        return YES;
    }

    return NO;
}

- (NSString *)removeTheZero {
    NSArray *strings = [self componentsSeparatedByString:@"."];

    if (strings.count > 1) {
        NSString *suffix = strings[1];

        if ([[suffix substringToIndex:1] isEqualToString:@"0"]) {
            return strings[0];
        } else if ([[suffix substringFromIndex:1] isEqualToString:@"0"]) {
            return [self substringWithRange:NSMakeRange(0, self.length - 1)];
        }
    }

    return self;
}

- (NSString *)removeTheZeroSuffixLength:(void (^)(NSInteger))suffixLength {
    NSArray *strings = [self componentsSeparatedByString:@"."];

    if (strings.count > 1) {
        NSString *suffix = strings[1];

        if ([suffix isEqualToString:@"00"]) {
            suffixLength(0);
            return strings[0];
        } else if ([[suffix substringFromIndex:1] isEqualToString:@"0"]) {
            suffixLength(1);
            return [self substringWithRange:NSMakeRange(0, self.length - 1)];
        }
    }

    suffixLength(2);
    return self;
}

#pragma mark - 验证是否是手机号

+ (BOOL)checkTel:(NSString *)str {
    //1[0-9]{10}

    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$

    //    NSString *regex = @"[0-9]{11}";

    if ([str trimString].length != 11) {
        return NO;
    }

    return YES;

//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//
//    BOOL isMatch = [pred evaluateWithObject:str];
//
//    return isMatch;
}

+ (BOOL)checkNum:(NSString *)str {
    NSString *regex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:str];

    return isMatch;
}

+ (BOOL)checkPassWordIsCorrect:(NSString *)password {
    NSString *regex = @"(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,16}$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:password];

    return isMatch;
}

/**
 验证六位数字的正则表达式

 @param str 输入内容
 @return YES 表示是六位数字 反之不是
 */
+ (BOOL)checkSixNum:(NSString *)str {
    NSString *regex = @"^[0-9]{6}$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:str];

    return isMatch;
}

+ (BOOL)checkIDNumberIsCorrect:(NSString *)num {
    NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:num];

    return isMatch;
}

+ (NSString *)translation:(NSString *)arebic {
    NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    NSArray *chinese_numerals = @[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"零"];
    NSArray *digits = @[@"个", @"十", @"百", @"千", @"万", @"十", @"百", @"千", @"亿", @"十", @"百", @"千", @"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];

    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length - i - 1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]]) {
            if ([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]) {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]]) {
                    [sums removeLastObject];
                }
            } else {
                sum = chinese_numerals[9];
            }

            if ([[sums lastObject] isEqualToString:sum]) {
                continue;
            }
        }

        [sums addObject:sum];
    }

    NSString *sumStr = [sums componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length - 1];

    return chinese;
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];

        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (NSString *)changeTimeString:(NSString *)string {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];

    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [[NSDate alloc] init];
    date1 = [formatter2 dateFromString:string];

    NSDateFormatter *formatter22 = [[NSDateFormatter alloc] init];
    [formatter22 setDateFormat:@"yyyy-MM-dd"];

    NSString *time = [formatter22 stringFromDate:date1];

    return time;
}

#pragma mark - 截取字符串或者double小数点后几位

/*
+ (NSString *)jiequStringWithNum:(NSInteger)num string:(NSString *)string
{
    NSString *str ;

    switch (num) {
        case 0:
            str = [NSString stringWithFormat:@"%.0f",[string doubleValue] - 0.50000000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0";
            }

            break;

        case 1:
            str = [NSString stringWithFormat:@"%.1f",[string doubleValue] - 0.0500000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0.0";
            }

            break;

        case 2:
            str = [NSString stringWithFormat:@"%.2f",[string doubleValue] - 0.005000000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0.00";
            }

            break;

        case 3:
            str = [NSString stringWithFormat:@"%.3f",[string doubleValue] - 0.00050000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0.000";
            }

            break;

        case 4:
            str = [NSString stringWithFormat:@"%.4f",[string doubleValue] - 0.00005000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0.0000";
            }

            break;

        case 5:
            str = [NSString stringWithFormat:@"%.5f",[string doubleValue] - 0.000005000000 + 0.00000001];

            if ([string doubleValue] == 0 || !string) {
                str = @"0.00000";
            }

            break;

        default:
            break;
    }

    return str;
}

+ (NSString *)jiequdoubleWithNum:(NSInteger)num data:(double )data
{
    NSString *str ;

    switch (num) {
        case 0:
            str = [NSString stringWithFormat:@"%.0f",data - 0.5 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0";
            }

            break;

        case 1:
            str = [NSString stringWithFormat:@"%.1f",data - 0.05 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0.0";
            }

            break;

        case 2:
            str = [NSString stringWithFormat:@"%.2f",data - 0.005 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0.00";
            }

            break;

        case 3:
            str = [NSString stringWithFormat:@"%.3f",data - 0.0005 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0.000";
            }

            break;

        case 4:
            str = [NSString stringWithFormat:@"%.4f",data - 0.00005 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0.0000";
            }

            break;

        case 5:
            str = [NSString stringWithFormat:@"%.5f",data - 0.000005 + 0.00000001];

            if (data == 0 || !data) {
                str = @"0.00000";
            }

            break;

        default:
            break;
    }

    return str;
}
*/
+ (NSString *)jiequStringWithNum:(NSInteger)num string:(NSString *)string {
    if (!string) {
        string = @"0";
    }

    double valu = [string doubleValue] + 0.00000000001;

    string = [NSString stringWithFormat:@"%f", valu];

    NSString *str;

    if ([string rangeOfString:@"."].location != NSNotFound) {//_roaldSearchText
        str = [string stringByAppendingString:@"00000000000000"];

        NSRange range;
        range = [str rangeOfString:@"."];

        if (num == 0) {
            return [str substringToIndex:range.location];
        }
        if (num > 0) {
            return [str substringToIndex:range.location + num + 1];
        }
    } else {
        switch (num) {
            case 0:
                str = [NSString stringWithFormat:@"%@", string];
                break;

            case 1:
                str = [NSString stringWithFormat:@"%@.0", string];
                break;

            case 2:
                str = [NSString stringWithFormat:@"%@.00", string];
                break;

            case 3:
                str = [NSString stringWithFormat:@"%@.000", string];
                break;

            case 4:
                str = [NSString stringWithFormat:@"%@.0000", string];
                break;

            case 5:
                str = [NSString stringWithFormat:@"%@.00000", string];
                break;

            case 6:
                str = [NSString stringWithFormat:@"%@.000000", string];
                break;

            case 7:
                str = [NSString stringWithFormat:@"%@.0000000", string];
                break;

            case 8:
                str = [NSString stringWithFormat:@"%@.00000000", string];
                break;

            case 9:
                str = [NSString stringWithFormat:@"%@.000000000", string];
                break;

            case 10:
                str = [NSString stringWithFormat:@"%@.0000000000", string];
                break;

            default:
                break;
        }

        return str;
    }

    return str;
}

+ (NSString *)jiequdoubleWithNum:(NSInteger)num data:(double)data {
    NSString *dataString = [NSString stringWithFormat:@"%f", data];

    return [self jiequStringWithNum:num string:dataString];
}

//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*
 判断输入的是否是全为空格

 @param str 字符
 @return
 */
+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (NSString *)filterZhushi:(NSString *)zhushi {
    NSScanner *scanner = [NSScanner scannerWithString:zhushi];

    NSString *text = nil;

    while ([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<!--" intoString:nil];//“	&ldquo;”	&rdquo;

        //找到标签的结束位置
        [scanner scanUpToString:@"-->" intoString:&text];

        //替换字符
        zhushi = [zhushi stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@-->", text] withString:@""];
    }
    return zhushi;
}

+ (NSString *)filterstyle:(NSString *)style {
    NSScanner *scanner = [NSScanner scannerWithString:style];

    NSString *text = nil;

    while ([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<style>" intoString:nil];//“	&ldquo;”	&rdquo;

        //找到标签的结束位置
        [scanner scanUpToString:@"</style>" intoString:&text];

        //替换字符
        style = [style stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@</style>", text] withString:@""];
    }
    return style;
}

+ (NSString *)filterHtml:(NSString *)html {
    NSScanner *scanner = [NSScanner scannerWithString:html];

    NSString *text = nil;

    while ([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"&" intoString:nil];//“	&ldquo;”	&rdquo;

        //找到标签的结束位置
        [scanner scanUpToString:@";" intoString:&text];

        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;", text] withString:@""];
    }

    NSString *regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+ (NSString *)filterHTMLwithtitle:(NSString *)html {
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    NSString *regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];

                    [params setValue:items forKey:key];
                } else {
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];

        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+ (NSString *)MobilePhoneNumberDesensitization:(NSString *)mobilePhoneNumber {
    NSString *piefix = [mobilePhoneNumber substringWithRange:NSMakeRange(0, 3)];
    NSString *suffix = [mobilePhoneNumber substringWithRange:NSMakeRange(mobilePhoneNumber.length - 4, 4)];
    NSString *phoneNum = [NSString stringWithFormat:@"%@****%@", piefix, suffix];
    return phoneNum;
}


- (NSString *)getRealPriceByPriceString {
    NSArray *stringArray = [self componentsSeparatedByString:@"."];

    if (stringArray.count > 1) {
        NSString *suffix = stringArray[1];

        if ([suffix isEqualToString:@"00"] || [suffix isEqualToString:@"0"]) {
            return stringArray[0];
        } else {
            if (suffix.length > 2) {
                NSString *subString = [suffix substringWithRange:NSMakeRange(0, 2)];
                NSString *string = [NSString stringWithFormat:@"%@.%@", stringArray[0], subString];

                return string;
            }
        }
    }

    return self;
}

@end

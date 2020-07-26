//
//  NSString+LK.m
//  Categorys
//
//  Created by 陈中宝 on 15/7/9.
//  Copyright (c) 2015年 陈中宝. All rights reserved.
//

#import "XSWJVANSString+LK.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LKSize)

#pragma mark 计算文字以某种 font 在某容器范围内的size   本方法就是为了计算文字所占区域的

- (CGSize)sizeWithFont:(UIFont *)font inSize:(CGSize)container {
    if (font == nil) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *attrs = @{
            NSFontAttributeName: font
    };
    CGRect rect = [self boundingRectWithSize:container options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil];

    return rect.size;
}

- (CGSize)sizeInSingleLineWithFont:(UIFont *)font {
    if (font == nil) {
        return CGSizeZero;
    }
    NSDictionary *attrs = @{
            NSFontAttributeName: font
    };
    return [self sizeWithAttributes:attrs];
}

@end

@implementation NSString (LKEncryption)

+ (NSString *)md5HexDigest:(NSString *)password {
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG) strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

+ (NSString *)sha1:(NSString *)str {
    const char *cstr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end

@implementation NSString (LKSpecial)
#pragma mark 替换特殊字符 - 单引号

+ (NSString *)replaceSpecialChars:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
}

#pragma mark 替换特殊字符

+ (NSString *)replaceSpecialChars:(NSString *)str from:(NSString *)fromStr to:(NSString *)toStr {
    return [str stringByReplacingOccurrencesOfString:fromStr withString:toStr];
}

//#define xCoefficient
//#define yCoefficient
+ (float)xCoefficient {
    float str = 0.0;
    if (375 == [UIScreen mainScreen].bounds.size.width) {
        str = 1.0;
    } else if (320 == [UIScreen mainScreen].bounds.size.width) {
        str = 320.0 / 375.0;
    } else if (414 == [UIScreen mainScreen].bounds.size.width) {
        str = 414.0 / 375.0;
    }
    return str;
}

+ (float)yCoefficient {
    float str = 0.0;
    if (480 == [UIScreen mainScreen].bounds.size.height) {
        //6
        str = 480.0 / 667.0;
    } else if (568 == [UIScreen mainScreen].bounds.size.height) {
        str = 568.0 / 667.0;
    } else if (667 == [UIScreen mainScreen].bounds.size.height) {
        str = 1.0;
    } else if (736 == [UIScreen mainScreen].bounds.size.height) {
        str = 736.0 / 667.0;
    }
    return str;
}

+ (float)fontC {
    float str = 0.0;
    if (480 == [UIScreen mainScreen].bounds.size.height) {
        //4s
        str = 1.0;
    } else if (568 == [UIScreen mainScreen].bounds.size.height) {
        //5s
        str = 1.0;
    } else if (667 == [UIScreen mainScreen].bounds.size.height) {
        //6
        str = 1.0;
    } else if (736 == [UIScreen mainScreen].bounds.size.height) {
        //6P
        str = 1.5;
    }
    return str;
}

#pragma mask 数据加密

- (NSString *)md5String {
    const char *string = self.UTF8String;
    int length = (int) strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String {
    const char *string = self.UTF8String;
    int length = (int) strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    const char *string = self.UTF8String;
    int length = (int) strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    const char *string = self.UTF8String;
    int length = (int) strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

//- (NSString *)hmacSHA1StringWithKey:(NSString *)key
//{
//    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
//    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
//}
//
//- (NSString *)hmacSHA256StringWithKey:(NSString *)key
//{
//    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
//    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
//}
//
//- (NSString *)hmacSHA512StringWithKey:(NSString *)key
//{
//    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
//    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
//}

#pragma mark - Helpers

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
    return [NSString stringWithString:mutableString];
}

#pragma mask

/**
 *  MD5($pass.$salt)
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
+ (NSString *)MD5:(NSString *)text {
    return [text md5String];
}

+ (NSData *)md5DataDigest:(NSString *)str {
    const char *string = str.UTF8String;
    int length = (int) strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSData dataWithBytes:bytes length:length];
}

/**
 *  MD5($pass.$salt)
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
+ (NSString *)MD5Salt:(NSString *)text {
    // 撒盐：随机地往明文中插入任意字符串
    NSString *salt = [text stringByAppendingString:@"aaa"];
    NSLog(@"%@", salt);
    return [salt md5String];
}

/**
 *  MD5(MD5($pass))
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)doubleMD5:(NSString *)text {
    return [[text md5String] md5String];
}

/**
 *  先加密，后乱序
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)MD5Reorder:(NSString *)text {
    NSString *pwd = [text md5String];
    // 加密后pwd == ]853778a951fd2cdf34dfd16504c5d8
    NSString *prefix = [pwd substringFromIndex:2];
    NSString *subfix = [pwd substringToIndex:2];
    // 乱序后 result == 853778a951fd2cdf34dfd16504c5d83f
    NSString *result = [prefix stringByAppendingString:subfix];

    return result;
}

//格式化，每三位逗号分割
+ (NSString *)strFormat:(NSString *)strs {
    NSArray *list = [strs componentsSeparatedByString:@"."];
    NSMutableString *str = list[0];
    if (str.length <= 3) {
        str = [[str stringByAppendingString:@".00"] mutableCopy];
    } else {
        NSMutableString *strF = NSMutableString.new;
        for (int i = 0; i < str.length; i++) {
            NSMutableString *ss = [[str substringWithRange:NSMakeRange(str.length - i - 1, 1)] mutableCopy];
            strF = [[strF stringByAppendingString:ss] mutableCopy];
        }
        NSInteger size = (str.length / 3);
        NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
        for (int n = 0; n < size; n++) { //str.length
            [tmpStrArr addObject:[strF substringWithRange:NSMakeRange(n * 3, 3)]];
        }
        [tmpStrArr addObject:[strF substringWithRange:NSMakeRange(size * 3, (str.length % 3))]];
        strF = [[tmpStrArr componentsJoinedByString:@","] mutableCopy];
        if ([[strF substringFromIndex:strF.length - 1] isEqualToString:@","]) {
            strF = [[strF substringToIndex:strF.length - 1] mutableCopy];
        }

        NSMutableString *strZ = NSMutableString.new;
        for (int i = 0; i < strF.length; i++) {
            NSMutableString *sss = [[strF substringWithRange:NSMakeRange(strF.length - i - 1, 1)] mutableCopy];
            strZ = [[strZ stringByAppendingString:sss] mutableCopy];
        }

        if (list.count == 2) {
            strZ = [[strZ stringByAppendingFormat:@"%@%@", @".", list[1]] mutableCopy];
        } else {
            strZ = [[strZ stringByAppendingString:@".00"] mutableCopy];
        }
        str = strZ;
    }
    return str;
}

+ (NSString *)formatIDCardNo:(NSString *)cardNo {
    return @"";
}

@end

@implementation NSString (Bank)

static const int _partWidth = 4;

+ (NSString *)formatBankCardNo:(NSString *)cardNo {
    if (!cardNo || [@"" isEqualToString:cardNo]) {
        return @"";
    }
    NSUInteger length = [cardNo length];
    NSUInteger num = length % _partWidth == 0 ? length / _partWidth : (length / _partWidth) + 1;
    NSMutableString *cardNoTemp = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        if (i < _partWidth) {
            [cardNoTemp appendString:[cardNo substringWithRange:NSMakeRange(i, 1)]];
        } else if (i >= _partWidth * (num - 1)) {
            [cardNoTemp appendString:[cardNo substringWithRange:NSMakeRange(i, 1)]];
        } else {
            [cardNoTemp appendString:@"*"];
        }
        if ((i + 1) % _partWidth == 0) {
            [cardNoTemp appendString:@" "];
        }
    }
    return cardNoTemp;
}

+ (NSString *)compareCurrentTimeByJobDetail:(NSString *)str {
    NSDate *date = [NSDate date]; // 获得时间对象

    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss aa"];

    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];

    [formatter2 setDateStyle:NSDateFormatterMediumStyle];

    [formatter2 setTimeStyle:NSDateFormatterShortStyle];

    [formatter2 setDateFormat:@"YYYY/MM/dd HH:mm:ss"];

    NSDate *dddata = [formatter2 dateFromString:str];

    NSString *DateTime2 = [formatter stringFromDate:dddata];

    NSString *result;

    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;

    if ([date timeIntervalSince1970] - [dddata timeIntervalSince1970] < 24 * 60 * 60) {
        result = [DateTime2 substringToIndex:16];
        result = [result substringFromIndex:11];
        if (hasAMPM && [DateTime2 length] >= 20) {
            result = [NSString stringWithFormat:@"%@ %@", result, [DateTime2 substringFromIndex:20]];
        } else {
            result = [NSString stringWithFormat:@"%@", result];
        }
    } else {
        result = @"";
    }

    return result;
}

+ (NSString *)compareCurrentTime:(NSString *)str {
    NSDate *date = [NSDate date]; // 获得时间对象

    //    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    //
    //    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    //
    //    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间

    //NSDate *date = [NSDate date];

    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];

    NSString *result;

    if ([str length] > 16) {
        if ([[str substringToIndex:10] isEqualToString:[DateTime substringToIndex:10]]) {
            result = [str substringToIndex:16];
            result = [result substringFromIndex:11];
        } else {
            result = [str substringToIndex:10];
            result = [result substringFromIndex:5];
        }
    } else {
        result = @"";
    }

    return result;
    //把字符串转为NSdate
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *timeDate = [dateFormatter dateFromString:str];
//
//    //得到与当前时间差
//    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval - 8*60*60;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [str substringFromIndex:11];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [str substringFromIndex:11];    }
//
//    else if((temp = temp/60) <24){
//        result = [str substringFromIndex:11];    }
//
//    else if((temp = temp/24) <30){
//        result = [str substringToIndex:10];
//    }
//
//    else if((temp = temp/30) <12){
//        result = [str substringToIndex:10];
//    }
//    else{
//        temp = temp/12;
//        result = [str substringToIndex:10];
//    }
//
//    return  result;
}

+ (NSString *)compareCurrentTimeByNew:(NSString *)str {
    NSDate *date = [NSDate date]; // 获得时间对象

    //    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    //
    //    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    //
    //    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间

    //NSDate *date = [NSDate date];

    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];

    NSString *result;

    if ([[str substringToIndex:10] isEqualToString:[DateTime substringToIndex:10]]) {
        result = [str substringToIndex:16];
        result = [result substringFromIndex:11];
    } else {
        result = [str substringToIndex:16];
        result = [result substringFromIndex:5];
    }
    return result;
}

//
+ (NSString *)compareCurrentTimeCrea:(NSString *)str {
    NSDate *date = [NSDate date]; // 获得时间对象

    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];

    NSString *result;

    if ([[str substringToIndex:10] isEqualToString:[DateTime substringToIndex:10]]) {
        result = [str substringToIndex:16];
        result = [result substringFromIndex:11];
    } else {
        result = [str substringToIndex:16];
        result = [result substringFromIndex:5];
    }
    return result;
}

+ (BOOL)compareCurrentTimeCreaBool:(NSString *)str {
    NSDate *date = [NSDate date]; // 获得时间对象

    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];

    if ([[str substringToIndex:10] isEqualToString:[DateTime substringToIndex:10]]) {
        return YES;
    } else {
        return NO;
    }

    //return  result;
}

+ (BOOL)compareCurrentTimeCreaByOf7DayBool:(NSString *)str {
    NSDate *nowDate = [NSDate date];

    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    // 截止时间字符串格式
    //NSString *expireDateStr = status.expireDatetime;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:str];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
            | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:expireDate toDate:nowDate options:0];

    if (dateCom.day >= 3 || dateCom.month >= 1 || dateCom.year >= 1) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)compareCurrentTimeCreaByOf1DayBool:(NSString *)str andByTimeToDay:(NSString *)tostr {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    // 截止时间字符串格式
    //NSString *expireDateStr = status.expireDatetime;

    // 截止时间data格式
    NSDate *expireDateTo = [dateFomatter dateFromString:tostr];
    // 当前时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:str];

    UInt64 recordTime = [expireDate timeIntervalSince1970] * 1000;

    UInt64 recordTimeTo = [expireDateTo timeIntervalSince1970] * 1000;

    if (recordTime > recordTimeTo) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)compareCurrentTimeCreaByOf1DayBoolByOneTime:(NSString *)str andByTimeToDay:(NSString *)tostr {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    // 截止时间字符串格式
    //NSString *expireDateStr = status.expireDatetime;

    // 截止时间data格式
    NSDate *expireDateTo = [dateFomatter dateFromString:tostr];
    // 当前时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:str];

    UInt64 recordTime = [expireDate timeIntervalSince1970] * 1000 + 2000;

    UInt64 recordTimeTo = [expireDateTo timeIntervalSince1970] * 1000;

    if (recordTime < recordTimeTo) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)compareCurrentQQLiaoTianTimeCrea:(NSString *)newstr andOldByData:(NSString *)oldstr {
    //NSString *dateString = @"2015-06-26 08:08:08";

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    //[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];

    NSDate *date = [formatter dateFromString:newstr];

    NSTimeZone *zone = [NSTimeZone systemTimeZone];

    NSInteger interval = [zone secondsFromGMTForDate:date];

    NSDate *localeDate = [date dateByAddingTimeInterval:interval];

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long) [localeDate timeIntervalSince1970]];

    NSDate *date2 = [formatter dateFromString:oldstr];

    NSInteger interval2 = [zone secondsFromGMTForDate:date2];

    NSDate *localeDate2 = [date2 dateByAddingTimeInterval:interval2];

    NSString *timeSp2 = [NSString stringWithFormat:@"%ld", (long) [localeDate2 timeIntervalSince1970]];

    if ([timeSp integerValue] - [timeSp2 integerValue] > 300) {
        return [self compareCurrentTimeByNew:newstr];
    } else {
        return nil;
    }
}

@end

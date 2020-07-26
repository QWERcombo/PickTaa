//
//  XSWJVADateToolsUtils.m
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/11.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVADateToolsUtils.h"

@implementation XSWJVADateToolsUtils

+ (int)getTimestamp {
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    int timeStamp = [timeSp intValue];
    
    return timeStamp;
}

+ (int)getTimestampFromDate:(NSDate *)date {
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    int timeStamp = [timeSp intValue];
    
    return timeStamp;
}

//精确到毫秒,13位
+ (NSString *)getTimestampString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", interval];
    
    return timeSp;
}

//世界标准时间UTC /GMT 转为当前系统时区对应的时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

//通过自带的日历得到年月日、时间、以及星期
+ (void)getCalendarNow {
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    NSDate *now;
    //    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    //    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //
    //    now = [NSDate date];
    //    comps = [calendar components:unitFlags fromDate:now];
    //
    //    long year = [comps year];
    //    long month = [comps month];
    //    long day = [comps day];
    //    long week = [comps weekday];
    //    long hour = [comps hour];
    //    long min = [comps minute];
    //    long sec = [comps second];
}

//NSString格式转化为NSDate
+ (NSDate *)stringToDate:(NSString *)strdate format:(NSString *)format {
    if (strdate.length <= 0) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];// NSString的时间格式
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    
    return retdate;
}

+ (NSString *)getDateForTimeStamp:(NSInteger)sw {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:sw];
    NSString *confromTimespStr = [XSWJVADateToolsUtils dateToString:confromTimesp format:@"yyyy-MM-dd"];
    
    return confromTimespStr;
}

//NSDate转化为NSString
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];//yyyy-MM-dd HH:mm:ss @"yyyy-MM-dd"
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}


//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
}

+ (NSString *)getDateFormat:(NSDate *)timeDate{
    if (timeDate == nil) {
        return @"";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:timeDate];
}

+ (NSString *)getDateAndTimeFormat:(NSDate *)timeDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:timeDate];
}

+ (NSDate *)getDateWithDistance:(NSInteger)dis {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay = 24 * 60 * 60 * 1;//1天的长度
    
    return [nowDate initWithTimeIntervalSinceNow:-oneDay * dis];
}

//将秒数转换为字符串格式
+ (NSString *)cgfv_timeWithSecond:(NSInteger)secondNum {
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", (long)secondNum/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)(secondNum%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)secondNum%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    
    return format_time;
}

//将秒数转换为字符串格式
+ (NSString *)cgfv_timeCountDownWithSecond:(NSInteger)secondNum {
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", (long)secondNum/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)(secondNum%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)secondNum%60];
    NSString *format_time = nil;
    
    if ([str_hour integerValue] > 0) {
        format_time = [NSString stringWithFormat:@"%@时%@分%@秒", str_hour, str_minute, str_second];
    } else if ([str_minute integerValue] > 0) {
        format_time = [NSString stringWithFormat:@"%@分%@秒", str_minute, str_second];
    } else {
        format_time = [NSString stringWithFormat:@"%@秒", str_second];
    }
    
    return format_time;
}

@end

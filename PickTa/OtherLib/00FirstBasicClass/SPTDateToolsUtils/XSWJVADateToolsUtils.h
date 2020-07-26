//
//  XSWJVADateToolsUtils.h
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/11.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XSWJVADateToolsUtils : NSObject

+ (int)getTimestamp;
+ (NSString *)getTimestampString;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;//世界标准时间UTC /GMT 转为当前系统时区对应的时间
+ (void)getCalendarNow;//通过自带的日历得到年月日、时间、以及星期
+ (NSDate *)stringToDate:(NSString *)strdate format:(NSString *)format;//NSString格式转化为NSDate
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format;//NSDate转化为NSString
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate;//将本地日期字符串转为UTC日期字符串
//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getDateFormat:(NSDate *)timeDate;//format: 20114-01-12
+ (NSString *)getDateAndTimeFormat:(NSDate *)timeDate;//format: 2014-01-12 02:30:30
+ (NSDate *)getDateWithDistance:(NSInteger)dis;//当前时间的前N天;distance表示间隔天数
+ (NSString *)getDateForTimeStamp:(NSInteger)sw;
+ (int)getTimestampFromDate:(NSDate *)date;

+ (NSString *)cgfv_timeWithSecond:(NSInteger)secondNum;
+ (NSString *)cgfv_timeCountDownWithSecond:(NSInteger)secondNum;

@end



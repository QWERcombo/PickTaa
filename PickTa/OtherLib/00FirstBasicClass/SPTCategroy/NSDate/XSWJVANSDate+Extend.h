//
//  NSDate+Extend.h
//  BCMSystem
//
//  Created by ccg on 14-4-18.
//  Copyright (c) 2014年 mobisoft. All rights reserved.
//  NSDate分类扩展方法

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

#pragma mark - Custom Method

/*
 *  @brief  获取年月日字符串
 *

 *
 *  @return NSString 比如19871127
 */
- (NSString *)getFormatYearMonthDay;

/*
 *  @brief  该日期是该年的第几周
 *

 *
 *  @return
 */
- (int)getWeekOfYear;

/*
 *  @brief  两个日期之间的天数
 *
  startDay 开始时间
  endDay   结束时间
 *
 *  @return
 */
+ (NSUInteger)dateStartDay:(NSDate *)startDay endDay:(NSDate *)endDay;

/*
 *  @brief  计算两个日期相隔秒数
 *
  startDay 开始时间
  endDay   结束时间
 *
 *  @return
 */
+ (NSUInteger)secondStartDay:(NSDate *)startDay endDay:(NSDate *)endDay;

/*
 *  @brief  返回day天后的日期
 *
  day 天数
 *
 *  @return
 */
- (NSDate *)dateAfterDay:(int)day;

/*
 *  返回day天之前的日期
 *
 day 天数
 *
 *  @return NSDate
 */
- (NSDate *)dateBeforeDay:(int)day;

/**
 *  返回week周之前的日期
 *
 week 周数
 *
 *  @return NSDate
 */
- (NSDate *)dateBeforeWeek:(int)week;

/*
 *  返回month月之前的日期
 *
 month 月数
 *
 *  @return NSDate
 */
- (NSDate *)dateBeforeMonth:(int)month;


/*
 *  返回month月的最后一天
 *
 month 月数
 *
 *  @return NSDate
 */
+ (NSDate *)date1stDayOfBeforeMonth:(int)month;


/*
 *  返回month月的最后一天
 *
 month 月数
 *
 *  @return NSDate
 */
+ (NSDate *)dateLastDayOfBeforeMonth:(int)month;


/*
 *  @brief  month个月后的日期
 *
  month 月数
 *
 *  @return
 */
- (NSDate *)dateafterMonth:(int)month;

/*
 *  @brief  获取日
 *

 *
 *  @return
 */
- (NSUInteger)getDay;

/*
 *  @brief  获取月
 *

 *
 *  @return
 */
- (NSUInteger)getMonth;

/*
 *  @brief  获取年
 *

 *
 *  @return
 */
- (NSUInteger)getYear;

/*
 *  @brief  获取小时
 *

 *
 *  @return
 */
- (int)getHour;

/*
 *  @brief  获取分钟
 *

 *
 *  @return
 */
- (int)getMinute;

/*
 *  @brief  在当前日期前几天
 *

 *
 *  @return
 */
- (NSUInteger)daysAgo;

/*
 *  @brief  午夜时间距今几天
 *

 *
 *  @return
 */
- (NSUInteger)daysAgoAgainstMidnight;

/*
 *  @brief  获取距现在几天的字符串
 *

 *
 *  @return NSString Today、Yesterday等
 */
- (NSString *)stringDaysAgo;

/*
 *  @brief  返回一周的第几天(周末为第一天)
 *

 *
 *  @return
 */
- (NSUInteger)getWeekday;

/*
 *  @brief  返回星期几的字符串
 *

 *
 *  @return
 */
- (NSString *)getWeekString;

/*
 *  @brief  返回周日的的开始时间
 *

 *
 *  @return
 */
- (NSDate *)beginningOfWeek;

/*
 *  @brief  返回该天的开始时间
 *

 *
 *  @return
 */
- (NSDate *)beginningOfDay;

/*
 *  @brief  返回该月的第一天
 *

 *
 *  @return
 */
- (NSDate *)beginningOfMonth;

/*
 *  @brief  返回该月的最后一天
 *

 *
 *  @return
 */
- (NSDate *)endOfMonth;

/*
 *  @brief  返回该周的周末
 *

 *
 *  @return
 */
- (NSDate *)endOfWeek;

#pragma mark - NSDate Format

/*
 *  @brief  将字符串转换成时间
 *
  string 时间的字符串(默认为timestamp格式)
 *
 *  @return
 */
+ (NSDate *)dateFromString:(NSString *)string;

/*
 *  @brief  根据时间格式将字符串转换成时间
 *
  string 时间的字符串
  format 时间格式的字符串
 *
 *  @return
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

/*
 *  @brief  根据时间格式将时间转换成字符串（类方法）
 *
  date   时间
  format 时间格式的字符串
 *
 *  @return
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/*
 *  @brief  将时间转换成字符串（类方法）
 *
  date 时间(默认为timestamp格式)
 *
 *  @return
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/*
 *  @brief  将时间转换成外国时间字符串
 *
  date     时间
  prefixed 是否有前缀
 *
 *  @return
 */
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;

/*
 *  @brief  将时间转换成外国时间字符串
 *
  date     时间(没有前缀)
 *
 *  @return
 */
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;

/*
 *  @brief  根据时间格式将时间转换成字符串(对象方法)
 *
  format 时间格式
 *
 *  @return
 */
- (NSString *)stringWithFormat:(NSString *)format;

/*
 *  @brief  将时间转成字符串(对象方法，默认为timestamp格式)
 *

 *
 *  @return
 */
- (NSString *)string;

/*
 *  @brief  将时间转成字符串(对象方法)
 *
  dateStyle 时间格式的枚举
  timeStyle 时间格式的枚举
 *
 *  @return
 */
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

/**
 *  @brief  返回日期格式的字符串
 *

 *
 *  @return NSString yyyy-MM-dd
 */
+ (NSString *)dateFormatString;

/**
 *  @brief  返回时间格式的字符串
 *

 *
 *  @return NSString HH:mm:ss
 */
+ (NSString *)timeFormatString;

/**
 *  @brief  返回时间戳格式的字符串
 *

 *
 *  @return NSString yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timestampFormatString;

/**
 *  @brief  获取当前时间的费用月份(类方法)
 *

 *
 *  @return NSString yyyy年MM月
 */
+ (NSString *)getMonthString;

/**
 *  @brief  获取指定时间的费用月份(对象方法)
 *

 *
 *  @return NSString yyyy年MM月
 */
- (NSString *)getMonthString;


/**
 *  @brief  获取指定时间的费用月份(对象方法)
 *

 *
 *  @return NSString yyyyMM
 */
- (NSString *)getDateString;

/**
 *  @brief  获取指定时间的年月日(对象方法)
 *
 *
 *  @return NSString yyyy年MM月dd日
 */
- (NSString *)getYearMonthDayInChineseString;

/**
 *  @brief  获取指定时间的年月日(对象方法)
 *
 *
 *  @return NSString yyyy-MM-dd
 */
- (NSString *)getYearMonthDay;

/**
 *  @brief  根据月份获取当前年月(对象方法)
 *
 *
 *  @return NSString yyyyMM
 */
//+ (NSString *)getSelectMonthWithIndex:(int)index;

/**
 *  @brief 某时间前4个季度
 *
 date 时间
 *
 *  @return 季度列表 201401
 */
//+ (NSArray *)getLast4QuaterWithDate:(NSDate *)date;


/**
 *  @brief 某时间前4个季度
 *
 date 时间
 *
 *  @return 季度列表 2014年第1季度
 */
//+ (NSArray *)getLast4QuaterInChineseWithDate:(NSDate *)date;


/**
 *  @brief 根据时间取当前季度
*
 *  @return 1,2,3,4 季度
 */
- (NSUInteger)getQuater;


/**
 *  @brief 根据某个时间点获取该时间点在当天的详细日期
 *
 time 时间点
 *
 *  @return 日期格式 yyyy-MM-dd HH:mm:ss
 */
+ (NSDate *)getTodayTimeWithATime:(NSString *)time;

/**
 *  @brief 根据某个时间获取该时间的时分秒
 *
 time 时间点
 *
 *  @return 日期格式 HH:mm:ss
 */
+ (NSDate *)todayTimeWithDate:(NSDate *)date;

/**
 *  @brief 根据时间戳和格式获取时间字符串
 *
 timeString 时间戳
 format 时间字符串格式非必填
 *
 *  @return 日期字符串
 */
+ (NSString *)timeWithTimeIntervalString:(CGFloat)timeString format:(NSString *)format;



// timeString的格式2019-03-03 返回day
+ (NSString *)getEnDayWithTimeString:(NSString *)timeString;

// timeString的格式2019-03-03 返回中文月份
+ (NSString *)getZhMonthWithTimeString:(NSString *)timeString;

@end

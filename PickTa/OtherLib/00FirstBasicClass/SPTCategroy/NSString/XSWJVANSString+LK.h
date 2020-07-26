//
//  NSString+LK.h
//  Categorys
//
//  Created by 陈中宝 on 15/7/9.
//  Copyright (c) 2015年 陈中宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LKSize)

/**
 计算文字以某种 font 在某容器范围内的size
 本方法就是为了计算文字所占区域的
 */
- (CGSize)sizeWithFont:(UIFont *)font inSize:(CGSize)container;

/**
 *  获得文字的行高
 *
 *  @param font 字体
 *
 *  @return 一行的size
 */
- (CGSize)sizeInSingleLineWithFont:(UIFont *)font;

@end

@interface NSString (LKEncryption)

/**
 *  MD5 加密
 */
+ (NSString *)md5HexDigest:(NSString *)str;

/**
 *  SHA1 加密
 */
+ (NSString *)sha1:(NSString *)str;

@end

@interface NSString (LKSpecial)

/**
 *  替换特殊字符 - 单引号
 */
+ (NSString *)replaceSpecialChars:(NSString *)str;

/**
 *  替换特殊字符
 *
 *  @param str     待修改的字符串
 *  @param fromStr 要替换的
 *  @param toStr   替换的
 *
 *  @return  str
 */
+ (NSString *)replaceSpecialChars:(NSString *)str from:(NSString *)fromStr to:(NSString *)toStr;

+ (float)xCoefficient;

+ (float)yCoefficient;

//md5加密
+ (NSString *)MD5:(NSString *)text;

+ (NSData *)md5DataDigest:(NSString *)str;

//md5加密 撒盐
+ (NSString *)MD5Salt:(NSString *)text;

//格式化，每三位逗号分割
+ (NSString *)strFormat:(NSString *)str;

/**
 *  格式化银行卡号 中间的位数以型号代替
 *
 *  @param  cardNo 卡号
 *
 *  @return 格式化
 */
+ (NSString *)formatIDCardNo:(NSString *)cardNo;
@end

/**
 *  银行相关
 */
@interface NSString (Bank)

/**
 *  格式化银行卡号 中间的位数以型号代替
 *
 *  @param cardNo 卡号
 *
 *  @return  格式化
 */
+ (NSString *)formatBankCardNo:(NSString *)cardNo;

//格式时间  聊天
+ (NSString *)compareCurrentTime:(NSString *)str;

+ (NSString *)compareCurrentTimeByJobDetail:(NSString *)str;

//格式时间  详情
+ (NSString *)compareCurrentTimeCrea:(NSString *)str;

+ (BOOL)compareCurrentTimeCreaBool:(NSString *)str;

//7天内
+ (BOOL)compareCurrentTimeCreaByOf7DayBool:(NSString *)str;

/**
 时间比较

 @param str 雇员时间
 @param tostr 刷新时间
 @return yes
 */
+ (BOOL)compareCurrentTimeCreaByOf1DayBool:(NSString *)str andByTimeToDay:(NSString *)tostr;

+ (BOOL)compareCurrentTimeCreaByOf1DayBoolByOneTime:(NSString *)str andByTimeToDay:(NSString *)tostr;

+ (NSString *)compareCurrentQQLiaoTianTimeCrea:(NSString *)newstr andOldByData:(NSString *)oldstr;

@end

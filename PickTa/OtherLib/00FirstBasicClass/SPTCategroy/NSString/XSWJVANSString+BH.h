//
//  NSString+BH.h
//  bankHuiClient
//
//  Created by 王帅广 on 16/3/17.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (BH)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

- (NSString *)md5HexDigest;

- (NSString *)removeTheZero;

- (NSString *)removeTheZeroSuffixLength:(void (^)(NSInteger length))suffixLength;

+ (NSString *)makemd5:(NSString *)str;

- (NSString *)insertSpaceForntAndBack;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 判断字符串是否为空

 @return 返回判断结果 YES 表示是空字符串  NO 表示不是
 */
- (BOOL)isBlankString;

/*
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/*
 *  正则表达式，是否为手机号格式
 *
 *  @param str 手机号
 *
 *  @return BOOL
 */
+ (BOOL)checkTel:(NSString *)str;

/*
 *  判断是否为数字
 *
 *  @param NSString 输入的内容
 *
 *  @return 返回是否为数字的BOOL
 */
+ (BOOL)checkNum:(NSString *)str;

///*
// *  验证六位数字密码
// *
// *  @param NSString 输入的内容
// *
// *  @return 返回是否为数字的BOOL
// */
+ (BOOL)checkSixNum:(NSString *)str;

/*
 *  密码规则的正则表达式
 *
 *  @param NSString 要验证的密码
 *
 *  @return 返回是否符合规则
 */
+ (BOOL)checkPassWordIsCorrect:(NSString *)password;

/*
 *  检验身份证号码格式是否正确
 *
 *  @param NSString num身份证号码
 *
 *  @return YES 表示符合身份证号码规则
 */
+ (BOOL)checkIDNumberIsCorrect:(NSString *)num;

#pragma mark - 数字转换成汉字

+ (NSString *)translation:(NSString *)arebic;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

+ (NSString *)changeTimeString:(NSString *)string;

//截取字符串
+ (NSString *)jiequStringWithNum:(NSInteger)num string:(NSString *)string;

+ (NSString *)jiequdoubleWithNum:(NSInteger)num data:(double)data;

//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email;

/*
 判断输入的是否全为空格
 @param str
 @return
 */
+ (BOOL)isEmpty:(NSString *)str;

+ (NSString *)filterZhushi:(NSString *)zhushi;

+ (NSString *)filterstyle:(NSString *)style;

+ (NSString *)filterHtml:(NSString *)html;

+ (NSString *)filterHTMLwithtitle:(NSString *)html;

/*
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

+ (NSString *)MobilePhoneNumberDesensitization:(NSString *)mobilePhoneNumber;

- (NSString *)getRealPriceByPriceString;

@end

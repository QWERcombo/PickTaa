//
//  PickTaUserDefaults.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickTaUserDefaults : NSObject
///token
+(NSString *)g_getToken;
+(void)g_setToken:(NSString*)token;
+(void)g_cleanToken;

///用户名 密码
+(void)g_setPhoneNum:(NSString*)phoneNum;
+(NSString *)g_getPhoneNum;
+(void)g_setPSW:(NSString*)psw;
+(NSString *)g_getPSW;

//other
+(void)g_setValue:(NSString*)value forKey:(NSString*)key;
+(NSString *)g_getValueForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END

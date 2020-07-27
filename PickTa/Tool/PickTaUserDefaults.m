//
//  PickTaUserDefaults.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaUserDefaults.h"

@implementation PickTaUserDefaults

+(void)g_setToken:(NSString *)token{
    if (token.length == 0) {
           return;
       }
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"g_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)g_getToken{
    if(String_IsEmpty([[NSUserDefaults standardUserDefaults] stringForKey:@"g_token"])){
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"g_token"];
    }
//    return @"3O7K8uPvtWUo0yNAUQgsnyM62DBlMPki";
}
+ (void)g_cleanToken{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"g_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)g_setPhoneNum:(NSString *)phoneNum{
    if(phoneNum.length == 0){
        return;
    }
    [[NSUserDefaults standardUserDefaults]setObject:phoneNum forKey:@"g_phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)g_getPhoneNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"g_phone"];
}

+ (void)g_setPSW:(NSString *)psw{
    [[NSUserDefaults standardUserDefaults]setObject:psw forKey:@"g_psw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)g_getPSW{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"g_psw"];
}

+(void)g_setValue:(NSString *)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)g_getValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end

//
//  NSString+Security.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Security)

- (NSString *)md5String;

- (NSString *)MD5ForLower32Bate;

- (NSString *)MD5ForUpper32Bate;// 32位大写
- (NSString *)MD5ForUpper32BateSalt:(NSString *)salt;

- (NSString *)MD5ForUpper16Bate;// 16为大写
- (NSString *)MD5ForLower16Bate;// 16位小写
- (NSString *)base64EncodeString;//对一个字符串进行base64编码
- (NSString *)base64decodeString;//对一个字符串进行base解码
- (NSString *)sha1;

@end

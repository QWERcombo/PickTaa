//
//  NSString+Security.m
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVANSString+Security.h"
#import "XSWJVANSData+SPTMd5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Security)

- (NSString *)md5String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *md5 = [data spt_md5];

    return [md5 lowercaseString];
}

- (NSString *)MD5ForLower32Bate {
    const char *input = [self UTF8String];//要进行UTF8的转码
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG) strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }

    return digest;
}

- (NSString *)MD5ForUpper32Bate {
    const char *input = [self UTF8String];//要进行UTF8的转码
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG) strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }

    return digest;
}

- (NSString *)MD5ForUpper32BateSalt:(NSString *)salt {
    const char *input = [[self stringByAppendingString:salt] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG) strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }

    return digest;
}

- (NSString *)MD5ForUpper16Bate {
    NSString *md5Str = [self MD5ForUpper32Bate];
    NSString *string;

    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }

    return string;
}

- (NSString *)MD5ForLower16Bate {
    NSString *md5Str = [self MD5ForLower32Bate];
    NSString *string;

    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }

    return string;
}

//对一个字符串进行base64编码
- (NSString *)base64EncodeString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return [data base64EncodedStringWithOptions:0];
}

//对一个字符串进行base解码
- (NSString *)base64decodeString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int) data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}


@end

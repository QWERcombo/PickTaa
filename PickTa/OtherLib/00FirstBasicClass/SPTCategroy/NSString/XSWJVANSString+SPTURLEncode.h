//
//  NSString+SPTURLEncode.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (SPTURLEncode)

+ (NSString *)spt_encodeString:(NSString *)uncodeString;
+ (NSString *)spt_decodeString:(NSString *)decodeString;
- (NSString *)spt_URLEncode;
- (NSString *)spt_URLEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)spt_URLDecode;
- (NSString *)spt_URLDecodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)attributedStringWithHTMLString;

@end



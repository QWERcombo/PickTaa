//
//  NSString+SPTURLEncode.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSString+SPTURLEncode.h"

@implementation NSString (SPTURLEncode)

//编码
+ (NSString *)spt_encodeString:(NSString *)uncodeString {
    return (NSString *) CFBridgingRelease((__bridge CFTypeRef _Nullable) ([[uncodeString description] stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet]]));
}

//解码
+ (NSString *)spt_decodeString:(NSString *)decodeString {
    return (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef) decodeString, CFSTR("")));
}

- (NSString *)spt_URLEncode {
    return [self spt_URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)spt_URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *) CFBridgingRelease((__bridge CFTypeRef _Nullable) ([[self description] stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet]]));
}

- (NSString *)spt_URLDecode {
    return [self spt_URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)spt_URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef) self, CFSTR("")));
}

- (NSString *)attributedStringWithHTMLString {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute :NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];

    return string.string;
}

@end


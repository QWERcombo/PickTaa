//
//  NSObject+SPNotNull.m
//  shop
//
//  Created by u on 2019/3/27.
//  Copyright © 2019 u. All rights reserved.
//

#import "XSWJVANSObject+SPNotNull.h"

@implementation NSObject (SPNotNull)

- (BOOL)isBlankString:(NSString *)str {
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([str isEqualToString:@"NULL"] || [str isEqualToString:@"nil"] || [str isEqualToString:@"null"] || [str isEqualToString:@"Null"] || [str isEqualToString:@"(null)"]) {
        return YES;
    }

    return NO;
}

@end

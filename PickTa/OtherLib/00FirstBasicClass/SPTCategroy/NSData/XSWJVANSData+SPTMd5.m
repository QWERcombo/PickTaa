//
//  NSData+Md5.m
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVANSData+SPTMd5.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (SPTMd5)

- (NSString *)spt_md5 {
    unsigned char result[16];
    CC_MD5(self.bytes, (CC_LONG) self.length, result);

    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}

@end

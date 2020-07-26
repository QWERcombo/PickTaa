//
//  NSString+XSWJVASPTRouter.m
//  BFZLShopMall-Test
//
//  Created by SOPOCO_ljt on 2019/5/13.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSString+SPTRouter.h"

@implementation NSString (XSWJVASPTRouter)

- (NSDictionary *)spt_fetchParameterAndRouter {
    NSMutableDictionary *parameter = NSMutableDictionary.new;
    NSString *urlString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([urlString containsString:@"/lyxy/"]) {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"/lyxy/" withString:@"lyxy://"];
    } else {
        urlString = [urlString copy];
    }
    
    if ([urlString containsString:@"lyxy://"]) {
        // 解析url解析
        NSURLComponents *urlComponets = [NSURLComponents componentsWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSString *protocol = urlComponets.scheme;
        NSString *host = urlComponets.host;
        NSString *path = urlComponets.path;
        NSString *query = urlComponets.query;

        if (!protocol) {
            // AXELogWarn(@"AXERouterRequest 检测失败 ,URL : %@有误！！", self);
            return nil;
        } else if (!host) {
            // AXELogWarn(@"AXERouterRequest 检测失败 ,host : %@有误！！", self);
            return nil;
        } else {
            [parameter setObject:[NSString stringWithFormat:@"%@://%@%@", protocol, host, path] forKey:JUMPE_ROUTER];
        }

        if (query) {// 解析URL中的参数.
            for (NSURLQueryItem *item in urlComponets.queryItems) {
                [parameter setObject:item.value forKey:item.name];
            }
        }
    }

    return [parameter copy];
//    if ([urlString containsString:@"lyxy://"]) {
//        if ([urlString containsString:@"?"]) {
//            NSRange range = [urlString rangeOfString:@"?"];
//            NSString *hostUrl = nil;
//            NSString *parameterUrl = nil;
//
//            if (range.location) {
//                hostUrl = [urlString substringWithRange:NSMakeRange(0, range.location)];
//                parameterUrl = [urlString substringFromIndex:(range.location+1)];
//            }
//
//            if (hostUrl.length && parameterUrl.length) {
//                [parameter setObject:hostUrl forKey:JUMPE_ROUTER];
//
//                NSString *parameterString = parameterUrl;
//                NSArray *parameterStringArray = nil;
//
//                if ([parameterString containsString:@"&"]) {
//                    parameterStringArray = [parameterString componentsSeparatedByString:@"&"];
//                } else {
//                    parameterStringArray = @[parameterString];
//                }
//
//                if (parameterString.length && parameterStringArray.count) {
//                    for (NSString *keyValueString in parameterStringArray) {// p = spu=1231
//                        NSRange range1 = [keyValueString rangeOfString:@"="];
//                        NSString *key = nil;
//                        NSString *value = nil;
//
//                        if (range1.location) {
//                            key = [keyValueString substringWithRange:NSMakeRange(0, range1.location)];
//                            value = [keyValueString substringFromIndex:(range1.location+1)];
//                        }
//
//                        if (key.length && value.length) {
//                            [parameter setObject:value forKey:key];
//                        }
//                    }
//                }
//            }
//        } else {
//            [parameter setObject:urlString forKey:JUMPE_ROUTER];
//        }
//    }
//
//    return [parameter copy];
}

@end

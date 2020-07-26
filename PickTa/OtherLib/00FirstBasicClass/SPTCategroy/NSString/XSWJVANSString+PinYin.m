//
//  NSString+PinYin.m
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/8.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVANSString+PinYin.h"

@implementation NSString (PinYin)

- (NSString *)spt_getFirstLetter {
    NSString *words = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (words.length == 0) {
        return nil;
    }


    NSMutableString *str = [NSMutableString stringWithString:words];

    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);//转换为带声调的拼音
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformStripDiacritics, NO);//转换为不带声调的拼音
    NSString *pinYin = [str capitalizedString];// 转化为大写拼音

    return [pinYin substringToIndex:1];//获取并返回首字母
}

@end

@implementation NSArray (PinYin)

- (NSArray *)spt_arrayWithPinYinFirstLetterFormat {
    if (![self count]) {
        return [NSMutableArray array];
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSMutableArray array] forKey:@"#"];

    for (int i = 'A'; i <= 'Z'; i++) {
        [dict setObject:[NSMutableArray array] forKey:[NSString stringWithUTF8String:(const char *) &i]];
    }

    for (NSString *words in self) {
        NSString *firstLetter = [words spt_getFirstLetter];
        NSMutableArray *array = dict[firstLetter];
        [array addObject:words];
    }

    NSMutableArray *resultArray = [NSMutableArray array];

    for (int i = 'A'; i <= 'Z'; i++) {
        NSString *firstLetter = [NSString stringWithUTF8String:(const char *) &i];
        NSMutableArray *array = dict[firstLetter];

        if ([array count]) {
            [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSString *word1 = obj1;
                NSString *word2 = obj2;
                return [word1 localizedCompare:word2];
            }];

            NSDictionary *resultDict = @{@"firstLetter": firstLetter, @"content": array};
            [resultArray addObject:resultDict];
        }
    }

    if ([dict[@"#"] count]) {
        NSMutableArray *array = dict[@"#"];
        [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *word1 = obj1;
            NSString *word2 = obj2;
            return [word1 localizedCompare:word2];
        }];

        NSDictionary *resultDict = @{@"firstLetter": @"#", @"content": array};
        [resultArray addObject:resultDict];
    }

    return resultArray;
}

@end

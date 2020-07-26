//
//  UIImage+SPTUI.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/9/4.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#import "XSWJVAWBCUnicode.h"
#import <objc/runtime.h>

static inline void wbc_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
   
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (XSWJVAWBCUnicode)

- (NSString *)wbc_stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
   
    return convertedString;
}

@end

@implementation NSArray (XSWJVAWBCUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        wbc_swizzleSelector(class, @selector(description), @selector(wbc_description));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(wbc_descriptionWithLocale:));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(wbc_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得 
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */
- (NSString *)wbc_description {
    return [[self wbc_description] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale {
    return [[self wbc_descriptionWithLocale:locale] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self wbc_descriptionWithLocale:locale indent:level] wbc_stringByReplaceUnicode];
}

@end

@implementation NSDictionary (XSWJVAWBCUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        wbc_swizzleSelector(class, @selector(description), @selector(wbc_description));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(wbc_descriptionWithLocale:));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(wbc_descriptionWithLocale:indent:));
    });
}

- (NSString *)wbc_description {
    return [[self wbc_description] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale {
    return [[self wbc_descriptionWithLocale:locale] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self wbc_descriptionWithLocale:locale indent:level] wbc_stringByReplaceUnicode];
}

@end

@implementation NSSet (XSWJVAWBCUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        wbc_swizzleSelector(class, @selector(description), @selector(wbc_description));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(wbc_descriptionWithLocale:));
        wbc_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(wbc_descriptionWithLocale:indent:));
    });
}

- (NSString *)wbc_description {
    return [[self wbc_description] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale {
    return [[self wbc_descriptionWithLocale:locale] wbc_stringByReplaceUnicode];
}

- (NSString *)wbc_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self wbc_descriptionWithLocale:locale indent:level] wbc_stringByReplaceUnicode];
}

@end

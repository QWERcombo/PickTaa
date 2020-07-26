//
//  UIFont+SPTAdapt.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAUIFont+SPTAdapt.h"
#import <objc/runtime.h>

#define MyUIScreen  375

@implementation UIFont (SPTAdapt)

+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(spt_adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)spt_adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont spt_adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width / MyUIScreen];
    
    return newFont;
}

@end

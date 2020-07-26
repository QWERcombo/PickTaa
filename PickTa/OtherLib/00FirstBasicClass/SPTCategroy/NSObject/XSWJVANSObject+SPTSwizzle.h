//
//  NSObject+SPTSwizzle.h
//  BFZLShopMall
//
//  Created by SOPOCO_ljt on 2019/4/19.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (SPTSwizzle)

/**
 对类方法进行拦截并替换
 @param originalSelector 类的原类方法
 @param replaceSelector 替代方法
 */
+ (void)spt_classSwizzleMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

/**
 对对象的实例方法进行拦截并替换
 @param originalSelector 对象的原实例方法
 @param replaceSelector 替代方法
 */
- (void)spt_instanceSwizzleMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

#pragma mark - 在进行方法swizzing时候，一定要注意类簇 ，比如 NSArray NSDictionary 等。

/**
 对类方法进行拦截并替换
 @param klass 被拦截的具体类
 @param originalSelector 类的原类方法
 @param replaceSelector 替代方法
 */
+ (void)spt_classSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

/**
 对对象的实例方法进行拦截并替换
 @param klass 被拦截的具体类
 @param originalSelector 对象的原实例方法
 @param replaceSelector 替代方法
 */
+ (void)spt_instanceSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

//拦截不替换
+ (BOOL)spt_swizzleMethod:(SEL _Nullable)origSel_ withMethod:(SEL _Nullable)altSel_ error:(NSError *_Nonnull *_Nullable)error_;

+ (BOOL)spt_swizzleClassMethod:(SEL _Nullable)origSel_ withClassMethod:(SEL _Nullable)altSel_ error:(NSError *_Nonnull *_Nonnull)error_;

+ (NSInvocation *_Nullable)spt_swizzleMethod:(SEL _Nullable)origSel withBlock:(id _Nullable)block error:(NSError *_Nullable *_Nonnull)error;

+ (NSInvocation *_Nullable)spt_swizzleClassMethod:(SEL _Nullable)origSel withBlock:(id _Nullable)block error:(NSError *_Nullable *_Nullable)error;


@end

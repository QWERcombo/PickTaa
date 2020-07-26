//
//  NSObject+SPTSwizzle.m
//  BFZLShopMall
//
//  Created by SOPOCO_ljt on 2019/4/19.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSObject+SPTSwizzle.h"

#if TARGET_OS_IPHONE

#import <objc/runtime.h>
#import <objc/message.h>

#else
#import <objc/objc-class.h>
#endif
#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT, ...)    \
if (ERROR_VAR) {    \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1    \
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT, ...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)
#define GetClass(obj)    object_getClass(obj)

/**
 struct objc_method {
 SEL method_name;        // 方法名称
 charchar *method_typesE;    // 参数和返回类型的描述字串
 IMP method_imp;         // 方法的具体的实现的指针，保存了方法地址
 }
 */

@implementation NSObject (SPTSwizzle)

//TODO: 拦截并替换方法
+ (void)spt_classSwizzleMethod:(SEL)originalSelector replaceMethod:(SEL)replaceSelector {
    [NSObject spt_classSwizzleMethodWithClass:[self class] orginalMethod:originalSelector replaceMethod:replaceSelector];
}

+ (void)spt_classSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector {
    Method origMethod = class_getClassMethod(klass, originalSelector);
    Method replaceMeathod = class_getClassMethod(klass, replaceSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(klass).UTF8String);

    // class_addMethod:如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
    BOOL didAddMethod = class_addMethod(metaKlass,
            originalSelector,
            method_getImplementation(replaceMeathod),
            method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        // 原方法未实现，则替换原方法防止crash
        class_replaceMethod(metaKlass,
                replaceSelector,
                method_getImplementation(origMethod),
                method_getTypeEncoding(origMethod));
    } else {
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

- (void)spt_instanceSwizzleMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector {
    [NSObject spt_instanceSwizzleMethodWithClass:[self class] orginalMethod:originalSelector replaceMethod:replaceSelector];
}

+ (void)spt_instanceSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector {
    Method origMethod = class_getInstanceMethod(klass, originalSelector);
    Method replaceMeathod = class_getInstanceMethod(klass, replaceSelector);

    BOOL didAddMethod = class_addMethod(klass,
            originalSelector,
            method_getImplementation(replaceMeathod),
            method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        class_replaceMethod(klass,
                replaceSelector,
                method_getImplementation(origMethod),
                method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

//TODO: 拦截不替换方法
+ (BOOL)spt_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_ {
    Method origMethod = class_getInstanceMethod(self, origSel_);

    if (!origMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
#else
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self className]);
#endif
        return NO;
    }

    Method altMethod = class_getInstanceMethod(self, altSel_);

    if (!altMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
#else
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self className]);
#endif
        return NO;
    }

    class_addMethod(self,
            origSel_,
            class_getMethodImplementation(self, origSel_),
            method_getTypeEncoding(origMethod));
    class_addMethod(self,
            altSel_,
            class_getMethodImplementation(self, altSel_),
            method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));

    return YES;
}

+ (BOOL)spt_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_ {
    return [GetClass((id) self) spt_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

+ (NSInvocation *)spt_swizzleMethod:(SEL)origSel withBlock:(id)block error:(NSError **)error {
    IMP blockIMP = imp_implementationWithBlock(block);
    NSString *blockSelectorString = [NSString stringWithFormat:@"_spt_block_%@_%p", NSStringFromSelector(origSel), block];
    SEL blockSel = sel_registerName([blockSelectorString cStringUsingEncoding:NSUTF8StringEncoding]);
    Method origSelMethod = class_getInstanceMethod(self, origSel);
    const char *origSelMethodArgs = method_getTypeEncoding(origSelMethod);
    class_addMethod(self, blockSel, blockIMP, origSelMethodArgs);
    NSMethodSignature *origSig = [NSMethodSignature signatureWithObjCTypes:origSelMethodArgs];
    NSInvocation *origInvocation = [NSInvocation invocationWithMethodSignature:origSig];
    origInvocation.selector = blockSel;

    [self spt_swizzleMethod:origSel withMethod:blockSel error:nil];

    return origInvocation;
}

+ (NSInvocation *)spt_swizzleClassMethod:(SEL)origSel withBlock:(id)block error:(NSError **)error {
    NSInvocation *invocation = [GetClass((id) self) spt_swizzleMethod:origSel withBlock:block error:error];
    invocation.target = self;

    return invocation;
}


@end

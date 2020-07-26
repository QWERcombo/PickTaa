//
//  NSObject+UI.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSObject+SPTUI.h"
#import "XSWJVASPTWeakObjectContainer.h"
#import <objc/message.h>

@implementation NSObject (SPTUI)

- (BOOL)spt_hasOverrideMethod:(SEL)selector ofSuperclass:(Class)superclass {
    return [NSObject spt_hasOverrideMethod:selector forClass:self.class ofSuperclass:superclass];
}

+ (BOOL)spt_hasOverrideMethod:(SEL)selector forClass:(Class)aClass ofSuperclass:(Class)superclass {
    if (![aClass isSubclassOfClass:superclass]) {
        return NO;
    }
    
    if (![superclass instancesRespondToSelector:selector]) {
        return NO;
    }
    
    Method superclassMethod = class_getInstanceMethod(superclass, selector);
    Method instanceMethod = class_getInstanceMethod(aClass, selector);
    if (!instanceMethod || instanceMethod == superclassMethod) {
        return NO;
    }
    return YES;
}

- (id)spt_performSelectorToSuperclass:(SEL)aSelector {
    struct objc_super mySuper;
    mySuper.receiver = self;
    mySuper.super_class = class_getSuperclass(object_getClass(self));
    
    id (*objc_superAllocTyped)(struct objc_super *, SEL) = (void *)&objc_msgSendSuper;
    return (*objc_superAllocTyped)(&mySuper, aSelector);
}

- (id)spt_performSelectorToSuperclass:(SEL)aSelector withObject:(id)object {
    struct objc_super mySuper;
    mySuper.receiver = self;
    mySuper.super_class = class_getSuperclass(object_getClass(self));
    
    id (*objc_superAllocTyped)(struct objc_super *, SEL, ...) = (void *)&objc_msgSendSuper;
    return (*objc_superAllocTyped)(&mySuper, aSelector, object);
}

- (void)spt_performSelector:(SEL)selector {
    [self spt_performSelector:selector withReturnValue:NULL arguments:NULL];
}

- (void)spt_performSelector:(SEL)selector withArguments:(void *)firstArgument, ... {
    [self spt_performSelector:selector withReturnValue:NULL arguments:firstArgument, NULL];
}

- (void)spt_performSelector:(SEL)selector withReturnValue:(void *)returnValue {
    [self spt_performSelector:selector withReturnValue:returnValue arguments:NULL];
}

- (void)spt_performSelector:(SEL)selector withReturnValue:(void *)returnValue arguments:(void *)firstArgument, ... {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    if (firstArgument) {
        [invocation setArgument:firstArgument atIndex:2];
        
        va_list args;
        va_start(args, firstArgument);
        void *currentArgument;
        NSInteger index = 3;
        while ((currentArgument = va_arg(args, void *))) {
            [invocation setArgument:currentArgument atIndex:index];
            index++;
        }
        va_end(args);
    }
    
    [invocation invoke];
    
    if (returnValue) {
        [invocation getReturnValue:returnValue];
    }
}

- (void)spt_enumrateIvarsUsingBlock:(void (^)(Ivar ivar, NSString *ivarName))block {
    [NSObject spt_enumrateIvarsOfClass:self.class includingInherited:NO usingBlock:block];
}

+ (void)spt_enumrateIvarsOfClass:(Class)aClass includingInherited:(BOOL)includingInherited usingBlock:(void (^)(Ivar, NSString *))block {
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(aClass, &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        if (block) block(ivar, [NSString stringWithFormat:@"%s", ivar_getName(ivar)]);
    }
    free(ivars);
    
    if (includingInherited) {
        Class superclass = class_getSuperclass(aClass);
        if (superclass) {
            [NSObject spt_enumrateIvarsOfClass:superclass includingInherited:includingInherited usingBlock:block];
        }
    }
}

- (void)spt_enumratePropertiesUsingBlock:(void (^)(objc_property_t property, NSString *propertyName))block {
    [NSObject spt_enumratePropertiesOfClass:self.class includingInherited:NO usingBlock:block];
}

+ (void)spt_enumratePropertiesOfClass:(Class)aClass includingInherited:(BOOL)includingInherited usingBlock:(void (^)(objc_property_t, NSString *))block {
    unsigned int propertiesCount = 0;
    objc_property_t *properties = class_copyPropertyList(aClass, &propertiesCount);
    
    for (unsigned int i = 0; i < propertiesCount; i++) {
        objc_property_t property = properties[i];
        if (block) block(property, [NSString stringWithFormat:@"%s", property_getName(property)]);
    }
    
    free(properties);
    
    if (includingInherited) {
        Class superclass = class_getSuperclass(aClass);
        if (superclass) {
            [NSObject spt_enumratePropertiesOfClass:superclass includingInherited:includingInherited usingBlock:block];
        }
    }
}

- (void)spt_enumrateInstanceMethodsUsingBlock:(void (^)(Method, SEL))block {
    [NSObject spt_enumrateInstanceMethodsOfClass:self.class includingInherited:NO usingBlock:block];
}

+ (void)spt_enumrateInstanceMethodsOfClass:(Class)aClass includingInherited:(BOOL)includingInherited usingBlock:(void (^)(Method, SEL))block {
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(aClass, &methodCount);
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        if (block) block(method, selector);
    }
    
    free(methods);
    
    if (includingInherited) {
        Class superclass = class_getSuperclass(aClass);
        if (superclass) {
            [NSObject spt_enumrateInstanceMethodsOfClass:superclass includingInherited:includingInherited usingBlock:block];
        }
    }
}

+ (void)spt_enumerateProtocolMethods:(Protocol *)protocol usingBlock:(void (^)(SEL))block {
    unsigned int methodCount = 0;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol, NO, YES, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        struct objc_method_description methodDescription = methods[i];
        if (block) {
            block(methodDescription.name);
        }
    }
    free(methods);
}

@end


@implementation NSObject (spt_DataBind)

static char kAssociatedObjectKey_QMUIAllBoundObjects;
- (NSMutableDictionary<id, id> *)spt_allBoundObjects {
    NSMutableDictionary<id, id> *dict = objc_getAssociatedObject(self, &kAssociatedObjectKey_QMUIAllBoundObjects);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &kAssociatedObjectKey_QMUIAllBoundObjects, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (void)spt_bindObject:(id)object forKey:(NSString *)key {
    if (!key.length) {
        NSAssert(NO, @"");
        return;
    }
    if (object) {
        [[self spt_allBoundObjects] setObject:object forKey:key];
    } else {
        [[self spt_allBoundObjects] removeObjectForKey:key];
    }
}

- (void)spt_bindObjectWeakly:(id)object forKey:(NSString *)key {
    if (!key.length) {
        NSAssert(NO, @"");
        return;
    }
    if (object) {
        XSWJVASPTWeakObjectContainer *container = [[XSWJVASPTWeakObjectContainer alloc] initWithObject:object];
        [self spt_bindObject:container forKey:key];
    } else {
        [[self spt_allBoundObjects] removeObjectForKey:key];
    }
}

- (id)spt_getBoundObjectForKey:(NSString *)key {
    if (!key.length) {
        NSAssert(NO, @"");
        return nil;
    }
    id storedObj = [[self spt_allBoundObjects] objectForKey:key];
    if ([storedObj isKindOfClass:[XSWJVASPTWeakObjectContainer class]]) {
        storedObj = [(XSWJVASPTWeakObjectContainer *)storedObj object];
    }
    return storedObj;
}

- (void)spt_bindDouble:(double)doubleValue forKey:(NSString *)key {
    [self spt_bindObject:@(doubleValue) forKey:key];
}

- (double)spt_getBoundDoubleForKey:(NSString *)key {
    id object = [self spt_getBoundObjectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        double doubleValue = [(NSNumber *)object doubleValue];
        return doubleValue;
        
    } else {
        return 0.0;
    }
}

- (void)spt_bindBOOL:(BOOL)boolValue forKey:(NSString *)key {
    [self spt_bindObject:@(boolValue) forKey:key];
}

- (BOOL)spt_getBoundBOOLForKey:(NSString *)key {
    id object = [self spt_getBoundObjectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        BOOL boolValue = [(NSNumber *)object boolValue];
        return boolValue;
        
    } else {
        return NO;
    }
}

- (void)spt_bindLong:(long)longValue forKey:(NSString *)key {
    [self spt_bindObject:@(longValue) forKey:key];
}

- (long)spt_getBoundLongForKey:(NSString *)key {
    id object = [self spt_getBoundObjectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        long longValue = [(NSNumber *)object longValue];
        return longValue;
        
    } else {
        return 0;
    }
}

- (void)spt_clearBindingForKey:(NSString *)key {
    [self spt_bindObject:nil forKey:key];
}

- (void)spt_clearAllBinding {
    [[self spt_allBoundObjects] removeAllObjects];
}

- (NSArray<NSString *> *)spt_allBindingKeys {
    NSArray<NSString *> *allKeys = [[self spt_allBoundObjects] allKeys];
    return allKeys;
}

- (BOOL)spt_hasBindingKey:(NSString *)key {
    return [[self spt_allBindingKeys] containsObject:key];
}

@end

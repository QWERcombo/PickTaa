//
//  SPTLab.h
//  BFZLShopMall
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#ifndef SPTLab_h
#define SPTLab_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "XSWJVASPTWeakObjectContainer.h"

/**
 以下系列宏用于在 Category 里添加 property 时，可以在 @implementation 里一句代码完成 getter/setter 的声明。暂不支持在getter/setter里添加自定义的逻辑，需要自定义的情况请继续使用 Code Snippet 生成的代码。
 使用方式：
 @code
 @interface NSObject (CategoryName)
 @property(nonatomic, strong) type *strongObj;
 @property(nonatomic, weak) type *weakObj;
 @property(nonatomic, assign) CGRect rectValue;
 @end
 
 @implementation NSObject (CategoryName)
 
 // 注意 setter 不需要带冒号
 SPTSynthesizeIdStrongProperty(strongObj, setStrongObj)
 SPTSynthesizeIdWeakProperty(weakObj, setWeakObj)
 SPTSynthesizeCGRectProperty(rectValue, setRectValue)
 
 @end
 @endcode
 */

#pragma mark - Meta Marcos

#define _SPTSynthesizeId(_getterName, _setterName, _policy) \
_Pragma("clang diagnostic push") _Pragma(ClangWarningConcat("-Wmismatched-parameter-types")) _Pragma(ClangWarningConcat("-Wmismatched-return-types"))\
static char kAssociatedObjectKey_##_getterName;\
- (void)_setterName:(id)_getterName {\
objc_setAssociatedObject(self, &kAssociatedObjectKey_##_getterName, _getterName, OBJC_ASSOCIATION_##_policy##_NONATOMIC);\
}\
\
- (id)_getterName {\
return objc_getAssociatedObject(self, &kAssociatedObjectKey_##_getterName);\
}\
_Pragma("clang diagnostic pop")

#define _SPTSynthesizeWeakId(_getterName, _setterName) \
_Pragma("clang diagnostic push") _Pragma(ClangWarningConcat("-Wmismatched-parameter-types")) _Pragma(ClangWarningConcat("-Wmismatched-return-types"))\
static char kAssociatedObjectKey_##_getterName;\
- (void)_setterName:(id)_getterName {\
objc_setAssociatedObject(self, &kAssociatedObjectKey_##_getterName, [[XSWJVASPTWeakObjectContainer alloc] initWithObject:_getterName], OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}\
\
- (id)_getterName {\
return ((XSWJVASPTWeakObjectContainer *)objc_getAssociatedObject(self, &kAssociatedObjectKey_##_getterName)).object;\
}\
_Pragma("clang diagnostic pop")

#define _SPTSynthesizeNonObject(_getterName, _setterName, _type, valueInitializer, valueGetter) \
_Pragma("clang diagnostic push") _Pragma(ClangWarningConcat("-Wmismatched-parameter-types")) _Pragma(ClangWarningConcat("-Wmismatched-return-types"))\
static char kAssociatedObjectKey_##_getterName;\
- (void)_setterName:(_type)_getterName {\
objc_setAssociatedObject(self, &kAssociatedObjectKey_##_getterName, [NSNumber valueInitializer:_getterName], OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}\
\
- (_type)_getterName {\
return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_##_getterName)) valueGetter];\
}
_Pragma("clang diagnostic pop")




#pragma mark - Object Marcos

/// @property(nonatomic, strong) id xxx
#define SPTSynthesizeIdStrongProperty(_getterName, _setterName) _SPTSynthesizeId(_getterName, _setterName, RETAIN)

/// @property(nonatomic, weak) id xxx
#define SPTSynthesizeIdWeakProperty(_getterName, _setterName) _SPTSynthesizeWeakId(_getterName, _setterName)

/// @property(nonatomic, copy) id xxx
#define SPTSynthesizeIdCopyProperty(_getterName, _setterName) _SPTSynthesizeId(_getterName, _setterName, COPY)



#pragma mark - NonObject Marcos

/// @property(nonatomic, assign) Int xxx
#define SPTSynthesizeIntProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, int, numberWithInt, intValue)

/// @property(nonatomic, assign) unsigned int xxx
#define SPTSynthesizeUnsignedIntProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, unsigned int, numberWithUnsignedInt, unsignedIntValue)

/// @property(nonatomic, assign) float xxx
#define SPTSynthesizeFloatProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, float, numberWithFloat, floatValue)

/// @property(nonatomic, assign) double xxx
#define SPTSynthesizeDoubleProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, double, numberWithDouble, doubleValue)

/// @property(nonatomic, assign) BOOL xxx
#define SPTSynthesizeBOOLProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, BOOL, numberWithBool, boolValue)

/// @property(nonatomic, assign) NSInteger xxx
#define SPTSynthesizeNSIntegerProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, NSInteger, numberWithInteger, integerValue)

/// @property(nonatomic, assign) NSUInteger xxx
#define SPTSynthesizeNSUIntegerProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, NSUInteger, numberWithUnsignedInteger, unsignedIntegerValue)

/// @property(nonatomic, assign) CGFloat xxx
#define SPTSynthesizeCGFloatProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGFloat, numberWithDouble, spt_CGFloatValue)

/// @property(nonatomic, assign) CGPoint xxx
#define SPTSynthesizeCGPointProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGPoint, valueWithCGPoint, CGPointValue)

/// @property(nonatomic, assign) CGSize xxx
#define SPTSynthesizeCGSizeProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGSize, valueWithCGSize, CGSizeValue)

/// @property(nonatomic, assign) CGRect xxx
#define SPTSynthesizeCGRectProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGRect, valueWithCGRect, CGRectValue)

/// @property(nonatomic, assign) UIEdgeInsets xxx
#define SPTSynthesizeUIEdgeInsetsProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, UIEdgeInsets, valueWithUIEdgeInsets, UIEdgeInsetsValue)

/// @property(nonatomic, assign) CGVector xxx
#define SPTSynthesizeCGVectorProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGVector, valueWithCGVector, CGVectorValue)

/// @property(nonatomic, assign) CGAffineTransform xxx
#define SPTSynthesizeCGAffineTransformProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, CGAffineTransform, valueWithCGAffineTransform, CGAffineTransformValue)

/// @property(nonatomic, assign) NSDirectionalEdgeInsets xxx
#define SPTSynthesizeNSDirectionalEdgeInsetsProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, NSDirectionalEdgeInsets, valueWithDirectionalEdgeInsets, NSDirectionalEdgeInsetsValue)

/// @property(nonatomic, assign) UIOffset xxx
#define SPTSynthesizeUIOffsetProperty(_getterName, _setterName) _SPTSynthesizeNonObject(_getterName, _setterName, UIOffset, valueWithUIOffset, UIOffsetValue)



#endif /* SPTLab_h */

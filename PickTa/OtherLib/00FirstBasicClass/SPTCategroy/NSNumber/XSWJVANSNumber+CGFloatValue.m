//
//  CGFloatValue.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVANSNumber+CGFloatValue.h"

@implementation NSNumber (CGFloatValue)

- (CGFloat)spt_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return self.doubleValue;
#else
    return self.floatValue;
#endif
}

@end

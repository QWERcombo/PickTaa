//
//  XSWJVASPTWeakObjectContainer.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVASPTWeakObjectContainer.h"

@implementation XSWJVASPTWeakObjectContainer

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        _object = object;
    }
    
    return self;
}

@end

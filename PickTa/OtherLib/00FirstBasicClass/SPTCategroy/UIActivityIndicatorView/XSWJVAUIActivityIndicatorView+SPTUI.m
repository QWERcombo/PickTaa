//
//  UIActivityIndicatorView+SPTUI.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAUIActivityIndicatorView+SPTUI.h"

@implementation UIActivityIndicatorView (SPTUI)

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style size:(CGSize)size {
    if (self = [self initWithActivityIndicatorStyle:style]) {
        CGSize initialSize = self.bounds.size;
        CGFloat scale = size.width / initialSize.width;
        self.transform = CGAffineTransformMakeScale(scale, scale);
    }
 
    return self;
}

@end

//
//  UIActivityIndicatorView+SPTUI.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIActivityIndicatorView (SPTUI)

/**
 * 创建一个指定大小的UIActivityIndicatorView
 *
 * 系统的UIActivityIndicatorView尺寸是由UIActivityIndicatorViewStyle决定的，固定不变。因此创建后通过CGAffineTransformMakeScale将其缩放到指定大小。self.frame获取的值也是缩放后的值，不影响布局。
 *
 * @param style UIActivityIndicatorViewStyle
 * @param size  UIActivityIndicatorView的大小
 *
 * @return UIActivityIndicatorView对象
 */
- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style size:(CGSize)size;

@end


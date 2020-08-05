//
//  UIImage+SPTExtension.h
//  ZYGShopMall
//
//  Created by Sanpintian on 2019/12/25.
//  Copyright © 2019 CodeBuild Tech. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImage (SPTExtension)

//修改头像大小
- (UIImage *)rotatedImageWithtransform:(CGAffineTransform)rotation
                         croppedToRect:(CGRect)rect;
// 修正或者更改图片方向
- (UIImage *)fixOrientation:(UIImageOrientation)orientation;

+ (UIImage *)changeColorFromImage:(UIImage *)image
                          toColor:(UIColor *)toColor
                             alpa:(CGFloat)alpa;
@end



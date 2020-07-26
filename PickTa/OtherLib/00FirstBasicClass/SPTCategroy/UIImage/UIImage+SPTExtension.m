//
//  UIImage+SPTExtension.m
//  ZYGShopMall
//
//  Created by Sanpintian on 2019/12/25.
//  Copyright © 2019 CodeBuild Tech. All rights reserved.
//

#import "UIImage+SPTExtension.h"
//#import <obj c/runtime.h>

@implementation UIImage (SPTExtension)

//+(void)load{
//    Method imageNamed = class_getClassMethod(self,@selector(imageNamed:));
//    Method looha_ImageNamed = class_getClassMethod(self,@selector(looha_none_imageNamed:));
//    method_exchangeImplementations(imageNamed, looha_ImageNamed);
//}
//
//+(instancetype)looha_none_imageNamed:(NSString *)name{
//    if (String_IsEmpty(name)) {//判断是否为空的方法，不提供，自行搞定
//      return  [self looha_none_imageNamed:name];
//    } else {
//        return nil;
//    }
//}

- (UIImage *)rotatedImageWithtransform:(CGAffineTransform)rotation
                         croppedToRect:(CGRect)rect {
    UIImage *rotatedImage = [self pe_rotatedImageWithtransform:rotation];
    
    CGFloat scale = rotatedImage.scale;
    CGRect cropRect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(scale, scale));
    
    CGImageRef croppedImage = CGImageCreateWithImageInRect(rotatedImage.CGImage, cropRect);
    UIImage *image = [UIImage imageWithCGImage:croppedImage scale:self.scale orientation:rotatedImage.imageOrientation];
    CGImageRelease(croppedImage);
    
    return image;
}

- (UIImage *)pe_rotatedImageWithtransform:(CGAffineTransform)transform {
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size,
                                           YES,                     // Opaque
                                           self.scale);             // Use image scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, size.width / 2, size.height / 2);
    CGContextConcatCTM(context, transform);
    CGContextTranslateCTM(context, size.width / -2, size.height / -2);
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

- (UIImage *)fixOrientation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft: {
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
        } break;
        case UIImageOrientationRight: {
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
        } break;
        case UIImageOrientationDown: {
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
        } break;
        default: {
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
        } break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end

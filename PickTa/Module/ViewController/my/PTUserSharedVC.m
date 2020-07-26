//
//  PTUserSharedVC.m
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTUserSharedVC.h"

@interface PTUserSharedVC ()

@end

@implementation PTUserSharedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindViewModel{
   
}

- (void)setupUI{
    self.sharedCode.text = @" ";
    self.sharedCodeCopy.layer.cornerRadius = 19;
    self.sharedCodeCopy.layer.masksToBounds = YES;
}

- (void)createVM{
    
}

-(void)requestData{
    WeakSelf(self)
    [[PickHttpManager shared]requestGET:API_UserSHared withParam:@{} withSuccess:^(id  _Nonnull obj) {
        NSString *message = obj;
        self.sharedImg.image=[self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:message] withSize:148];
        NSRange range = [message rangeOfString:@"="];
        self.sharedCode.text = [message substringFromIndex:range.location+1];
        
        [[self.sharedCodeCopy rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            board.string = self.sharedCode.text;
            [weakself.view makeToast:@"复制成功" duration:1.f position:[NSValue valueWithCGPoint:weakself.view.toastPoint]];
        }];
        
    } withFailure:^(NSError * _Nonnull err) {
        
    }];
}

- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end

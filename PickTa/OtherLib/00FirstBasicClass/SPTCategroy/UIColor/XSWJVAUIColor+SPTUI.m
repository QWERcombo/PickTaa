//
//  UIColor+SPTUI.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAUIColor+SPTUI.h"
//#import "QMUICore.h"
#import "XSWJVANSString+SPTUI.h"
#import "XSWJVASPTRuntime.h"

@implementation UIColor (SPTUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 使用 [UIColor colorWithRed:green:blue:alpha:] 或 [UIColor colorWithHue:saturation:brightness:alpha:] 方法创建的颜色是 UIDeviceRGBColor 类型的而不是 UIColor 类型的
        ExchangeImplementations([UIColor colorWithRed:1 green:1 blue:1 alpha:1].class, @selector(description), @selector(spt_colorDescription));
    });
}

- (NSString *)spt_colorDescription {
    NSInteger red = self.spt_red * 255;
    NSInteger green = self.spt_green * 255;
    NSInteger blue = self.spt_blue * 255;
    CGFloat alpha = self.spt_alpha;
    NSString *description = [NSString stringWithFormat:@"%@, RGBA(%@, %@, %@, %.2f), %@", [self spt_colorDescription], @(red), @(green), @(blue), alpha, [self spt_hexString]];
   
    return description;
}

+ (UIColor *)spt_colorWithHexString:(NSString *)hexString {
    if (hexString.length <= 0) return nil;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default: {
            NSAssert(NO, @"Color value %@ is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString);
            return nil;
        }
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (NSString *)spt_hexString {
    NSInteger alpha = self.spt_alpha * 255;
    NSInteger red = self.spt_red * 255;
    NSInteger green = self.spt_green * 255;
    NSInteger blue = self.spt_blue * 255;
    return [[NSString stringWithFormat:@"#%@%@%@%@",
             [self alignColorHexStringLength:[NSString spt_hexStringWithInteger:alpha]],
             [self alignColorHexStringLength:[NSString spt_hexStringWithInteger:red]],
             [self alignColorHexStringLength:[NSString spt_hexStringWithInteger:green]],
             [self alignColorHexStringLength:[NSString spt_hexStringWithInteger:blue]]] lowercaseString];
}

// 对于色值只有单位数的，在前面补一个0，例如“F”会补齐为“0F”
- (NSString *)alignColorHexStringLength:(NSString *)hexString {
    return hexString.length < 2 ? [@"0" stringByAppendingString:hexString] : hexString;
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (CGFloat)spt_red {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0;
}

- (CGFloat)spt_green {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0;
}

- (CGFloat)spt_blue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (CGFloat)spt_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

- (CGFloat)spt_hue {
    CGFloat h;
    if ([self getHue:&h saturation:0 brightness:0 alpha:0]) {
        return h;
    }
    return 0;
}

- (CGFloat)spt_saturation {
    CGFloat s;
    if ([self getHue:0 saturation:&s brightness:0 alpha:0]) {
        return s;
    }
    return 0;
}

- (CGFloat)spt_brightness {
    CGFloat b;
    if ([self getHue:0 saturation:0 brightness:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (UIColor *)spt_colorWithoutAlpha {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    if ([self getRed:&r green:&g blue:&b alpha:0]) {
        return [UIColor colorWithRed:r green:g blue:b alpha:1];
    } else {
        return nil;
    }
}

- (UIColor *)spt_colorWithAlpha:(CGFloat)alpha backgroundColor:(UIColor *)backgroundColor {
    return [UIColor spt_colorWithBackendColor:backgroundColor frontColor:[self colorWithAlphaComponent:alpha]];
    
}

- (UIColor *)spt_colorWithAlphaAddedToWhite:(CGFloat)alpha {
    return [self spt_colorWithAlpha:alpha backgroundColor:COLOR_WHITE];
}

- (UIColor *)spt_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor spt_colorFromColor:self toColor:toColor progress:progress];
}

- (BOOL)spt_colorIsDark {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        float referenceValue = 0.411;
        float colorDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
        
        return 1.0 - colorDelta > referenceValue;
    }
    return YES;
}

- (UIColor *)spt_inverseColor {
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

- (BOOL)spt_isSystemTintColor {
    return [self isEqual:[UIColor spt_systemTintColor]];
}

+ (UIColor *)spt_systemTintColor {
    static UIColor *systemTintColor = nil;
    if (!systemTintColor) {
        UIView *view = [[UIView alloc] init];
        systemTintColor = view.tintColor;
    }
    return systemTintColor;
}

+ (UIColor *)spt_colorWithBackendColor:(UIColor *)backendColor frontColor:(UIColor *)frontColor {
    CGFloat bgAlpha = [backendColor spt_alpha];
    CGFloat bgRed = [backendColor spt_red];
    CGFloat bgGreen = [backendColor spt_green];
    CGFloat bgBlue = [backendColor spt_blue];
    
    CGFloat frAlpha = [frontColor spt_alpha];
    CGFloat frRed = [frontColor spt_red];
    CGFloat frGreen = [frontColor spt_green];
    CGFloat frBlue = [frontColor spt_blue];
    
    CGFloat resultAlpha = frAlpha + bgAlpha * (1 - frAlpha);
    CGFloat resultRed = (frRed * frAlpha + bgRed * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultGreen = (frGreen * frAlpha + bgGreen * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultBlue = (frBlue * frAlpha + bgBlue * bgAlpha * (1 - frAlpha)) / resultAlpha;
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:resultAlpha];
}

+ (UIColor *)spt_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    CGFloat fromRed = fromColor.spt_red;
    CGFloat fromGreen = fromColor.spt_green;
    CGFloat fromBlue = fromColor.spt_blue;
    CGFloat fromAlpha = fromColor.spt_alpha;
    
    CGFloat toRed = toColor.spt_red;
    CGFloat toGreen = toColor.spt_green;
    CGFloat toBlue = toColor.spt_blue;
    CGFloat toAlpha = toColor.spt_alpha;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}

+ (UIColor *)spt_randomColor {
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr {
    // CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    // 创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id) [UIColor spt_colorWithHexString:fromHexColorStr].CGColor, (__bridge id) [UIColor spt_colorWithHexString:toHexColorStr].CGColor];
    
    // 设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    // 设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0, @1];
    
    return gradientLayer;
}

@end

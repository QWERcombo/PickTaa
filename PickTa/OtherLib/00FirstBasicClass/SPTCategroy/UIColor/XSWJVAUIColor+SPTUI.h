//
//  UIColor+SPTUI.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorMakeWithHex(hex) [UIColor spt_colorWithHexString:hex]



@interface UIColor (SPTUI)
NS_ASSUME_NONNULL_BEGIN

/**
 *  使用HEX命名方式的颜色字符串生成一个UIColor对象
 *
 *  @param hexString
 *      #RGB        例如#f0f，等同于#ffff00ff，RGBA(255, 0, 255, 1)
 *      #ARGB       例如#0f0f，等同于#00ff00ff，RGBA(255, 0, 255, 0)
 *      #RRGGBB     例如#ff00ff，等同于#ffff00ff，RGBA(255, 0, 255, 1)
 *      #AARRGGBB   例如#00ff00ff，等同于RGBA(255, 0, 255, 0)
 *
 * @return UIColor对象
 */
+ (nullable UIColor *)spt_colorWithHexString:(nullable NSString *)hexString;

/**
 *  将当前色值转换为hex字符串，通道排序是AARRGGBB（与Android保持一致）
 */
- (nullable NSString *)spt_hexString;

/**
 *  获取当前UIColor对象里的红色色值
 *
 *  @return 红色通道的色值，值范围为0.0-1.0
 */
- (CGFloat)spt_red;

/**
 *  获取当前UIColor对象里的绿色色值
 *
 *  @return 绿色通道的色值，值范围为0.0-1.0
 */
- (CGFloat)spt_green;

/**
 *  获取当前UIColor对象里的蓝色色值
 *
 *  @return 蓝色通道的色值，值范围为0.0-1.0
 */
- (CGFloat)spt_blue;

/**
 *  获取当前UIColor对象里的透明色值
 *
 *  @return 透明通道的色值，值范围为0.0-1.0
 */
- (CGFloat)spt_alpha;

/**
 *  获取当前UIColor对象里的hue（色相）
 */
- (CGFloat)spt_hue;

/**
 *  获取当前UIColor对象里的saturation（饱和度）
 */
- (CGFloat)spt_saturation;

/**
 *  获取当前UIColor对象里的brightness（亮度）
 */
- (CGFloat)spt_brightness;

/**
 *  将当前UIColor对象剥离掉alpha通道后得到的色值。相当于把当前颜色的半透明值强制设为1.0后返回
 *
 *  @return alpha通道为1.0，其他rgb通道与原UIColor对象一致的新UIColor对象
 */
- (nullable UIColor *)spt_colorWithoutAlpha;

/**
 *  计算当前color叠加了alpha之后放在指定颜色的背景上的色值
 */
- (nullable UIColor *)spt_colorWithAlpha:(CGFloat)alpha backgroundColor:(nullable UIColor *)backgroundColor;

/**
 *  计算当前color叠加了alpha之后放在白色背景上的色值
 */
- (nonnull UIColor *)spt_colorWithAlphaAddedToWhite:(CGFloat)alpha;

/**
 *  将自身变化到某个目标颜色，可通过参数progress控制变化的程度，最终得到一个纯色
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
- (nonnull UIColor *)spt_transitionToColor:(nullable UIColor *)toColor progress:(CGFloat)progress;

/**
 *  判断当前颜色是否为深色，可用于根据不同色调动态设置不同文字颜色的场景。
 *
 *  @link http://stackoverflow.com/questions/19456288/text-color-based-on-background-image @/link
 *
 *  @return 若为深色则返回“YES”，浅色则返回“NO”
 */
- (BOOL)spt_colorIsDark;

/**
 *  当前颜色的反色
 *
 */
- (nonnull UIColor *)spt_inverseColor;

/**
 *  判断当前颜色是否等于系统默认的 tintColor 颜色。
 *  背景：如果将一个 UIView.tintColor 设置为 nil，表示这个 view 的 tintColor 希望跟随 superview.tintColor 变化而变化，所以设置完再获取 view.tintColor，得到的并非 nil，而是 superview.tintColor 的值，而如果整棵 view 层级树里的 view 都没有设置自己的 tintColor，则会返回系统默认的 tintColor（也即 [UIColor spt_systemTintColor]），所以才提供这个方法用于代替判断 tintColor == nil 的作用。
 */
- (BOOL)spt_isSystemTintColor;

/**
 *  获取当前系统的默认 tintColor 色值
 */
+ (nullable UIColor *)spt_systemTintColor;

/**
 *  计算两个颜色叠加之后的最终色（注意区分前景色后景色的顺序）<br/>
 */
+ (nullable UIColor *)spt_colorWithBackendColor:(nonnull UIColor *)backendColor frontColor:(nonnull UIColor *)frontColor;

/**
 *  将颜色A变化到颜色B，可通过progress控制变化的程度
 *  @param fromColor 起始颜色
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
+ (nonnull UIColor *)spt_colorFromColor:(nonnull UIColor *)fromColor toColor:(nonnull UIColor *)toColor progress:(CGFloat)progress;

/**
 *  产生一个随机色，大部分情况下用于测试
 */
+ (nonnull UIColor *)spt_randomColor;

/**
 *  产生渐变色
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
NS_ASSUME_NONNULL_END

@end



//
//  Macro.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/8/22.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#import <Foundation/Foundation.h>

#define TEST_IS_SPT 1

//数组是否为空
#define Array_IsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define Dict_IsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//字符串是否为空
#define String_IsEmpty(str) (str == nil || [str isKindOfClass:[NSNull class]] || str.length == 0 )

//图片缩放比例
#define SCALE_IMAGE  ([UIScreen mainScreen].bounds.size.width)/375


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



//=========================================通用宏==============================================
#define IS_Pad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) //判断是否是ipad
#define IS_iPhoneX_Or_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)//判断是否iPhone X/Xs
#define IS_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)//判断iPHoneXr
#define IS_iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)//判断iPhoneXs Max
#define IS_X_Series (IS_iPhoneX_Or_Xs || IS_iPhoneXr || IS_iPhoneXs_Max) //判断是否为带刘海的iPhone

#define kAppStatusBarHeight ((IS_iPhoneX_Or_Xs || IS_iPhoneXr || IS_iPhoneXs_Max) ? 44.f : 20.f) //状态栏高度
#define kAppTabbarHeight ((IS_iPhoneX_Or_Xs || IS_iPhoneXr || IS_iPhoneXs_Max) ? (49.f+34.f) : 49.f)// Tabbar 高度.
#define kAppTabbarSafeBottomMargin ((IS_iPhoneX_Or_Xs || IS_iPhoneXr || IS_iPhoneXs_Max) ? 34.f : 0.f)// Tabbar 底部安全高度.
#define kAppStatusBarAndNavigationBarHeight ((IS_iPhoneX_Or_Xs || IS_iPhoneXr || IS_iPhoneXs_Max) ? 88.f : 64.f)// 状态栏和导航栏总高度.

#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"AssetPicker" ofType:@"bundle"]] pathForResource:[NSString stringWithFormat:@"%@@%dx",_pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"]]
//#define ImageWithFile(_pointer) ((UIImage *)[UIImage imageWithContentsOfFile:([[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@@%dx",_pointer,(int)[UIScreen mainScreen].nativeScale]ofType:@"png"])])

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



//DEBUG  模式下打印日志,当前行   //它会输出纯净的内容 // sanpintian-test
//#if (DEBUG || TEST || PRERELEASE)
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(...)
//#endif
#ifdef DEBUG
//#define NSLog(FORMAT, ...) nil
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//内联函数的预编译指令
//在inline加上static修饰符，只是为了表明该函数只在该文件中可见！也就是说，在同一个工程中，就算在其他文件中也出现同名、同参数的函数也不会引起函数重复定义的错误！
//#define CG_INLINE static inline

#define WEAKINSTANCE(weakInstance,instance) __weak typeof(instance) weakInstance = instance;
#define WS(weakSelf) WEAKINSTANCE(weakSelf,self)
#define WEAK_SELF(type)  __weak typeof(type) weak##type = type;
#define STRONG_SELF(type)  __strong typeof(type) type = weak##type;

#pragma mark - Color

#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define COLOR_RGB(r,g,b) COLOR_RGBA(r,g,b,1)
#define COLOR_RANDOM [UIColor colorWithRed:(arc4random_uniform(255))/255.0 green:(arc4random_uniform(255))/255.0 blue:(arc4random_uniform(255))/255.0 alpha:1.0]
// RGB颜色转换（16进制->10进制）
#define COLOR_HEX_RGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#define COLOR_HEX_RGBA(rgbValue, a)\
\
([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:(a)])

//自定义颜色
#define COLOR_WHITE UIColor.whiteColor
#define BACKGROUND_COLOR COLOR_HEX_RGB(0xF2F5F5)
#define COLOR_333333 COLOR_HEX_RGB(0x333333)
#define COLOR_555555 COLOR_HEX_RGB(0x555555)
#define COLOR_666666 COLOR_HEX_RGB(0x666666)
#define COLOR_999999 COLOR_HEX_RGB(0x999999)
#define COLOR_E8726A COLOR_HEX_RGB(0xe8726a)
#define COLOR_F66D66 COLOR_HEX_RGB(0xf66d66)
#define COLOR_F2F5F5 COLOR_HEX_RGB(0xF2F5F5)
#define COLOR_F7F8FA COLOR_HEX_RGB(0xF7F8FA)
#define COLOR_F5F5F5 COLOR_HEX_RGB(0xF5F5F5)
#define COLOR_FFFFFF COLOR_HEX_RGB(0xFFFFFF)
#define COLOR_E32522 COLOR_HEX_RGB(0xE32522)
#define COLOR_E54242 COLOR_HEX_RGB(0xE54242)
//#define COLOR_THMTE COLOR_HEX_RGB(0x0DAFC6)
#define COLOR_THMTE COLOR_HEX_RGB(0x04B1C7)
#define COLOR_NAVBG COLOR_HEX_RGB(0x04B1C7)
#define COLOR_DEDEDE COLOR_HEX_RGB(0xDEDEDE)
#define COLOR_DE3333 COLOR_HEX_RGB(0xDE3333)
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_F4F9FD COLOR_HEX_RGB(0xF4F9FD)
#define COLOR_F0F0F0 COLOR_HEX_RGB(0xF0F0F0)
#define COLOR_34D8ED COLOR_HEX_RGB(0x34D8ED)
#define COLOR_E73D3D COLOR_HEX_RGB(0xE73D3D)
#define COLOR_CCCCCC COLOR_HEX_RGB(0xCCCCCC)
#define COLOR_DDDDDD COLOR_HEX_RGB(0xDDDDDD)

#pragma mark - Font

/***常用的常量定义***/
#define BFZLSysFont  @"PingFangSC-Regular"// 系统默认字体
#define BFZLThinFont  @"PingFangSC-Light"// 细字体
#define BFZLMediumFont @"PingFangSC-Medium"// 中字体

#define FONT_SIZE_15 [UIFont systemFontOfSize:15]
#define FONT_SIZE_14 [UIFont systemFontOfSize:14]
#define FONT_SIZE_13 [UIFont systemFontOfSize:13]
#define FONT_SIZE_12 [UIFont systemFontOfSize:12]

#pragma mark - SDK Allowed

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
/// 当前编译使用的 Base SDK 版本为 iOS 9.0 及以上
#define IOS9_SDK_ALLOWED YES
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
/// 当前编译使用的 Base SDK 版本为 iOS 10.0 及以上
#define IOS10_SDK_ALLOWED YES
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
/// 当前编译使用的 Base SDK 版本为 iOS 11.0 及以上
#define IOS11_SDK_ALLOWED YES
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120000
/// 当前编译使用的 Base SDK 版本为 iOS 12.0 及以上
#define IOS12_SDK_ALLOWED YES
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
/// 当前编译使用的 Base SDK 版本为 iOS 12.0 及以上
#define IOS13_SDK_ALLOWED YES
#endif

#pragma mark - Clang

#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)

/// 参数可直接传入 clang 的 warning 名，warning 列表参考：https://clang.llvm.org/docs/DiagnosticsReference.html
#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning

#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning

#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

#pragma mark - 变量-设备相关

/// 设备类型
#define IS_IPAD [XSWJVASPTHelper isIPad]
#define IS_IPOD [XSWJVASPTHelper isIPod]
#define IS_IPHONE [XSWJVASPTHelper isIPhone]
#define IS_SIMULATOR [XSWJVASPTHelper isSimulator]

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define LESS_10 ((IOS_VERSION < 11)?YES:NO)

/// 数字形式的操作系统版本号，可直接用于大小比较；如 110205 代表 11.2.5 版本；根据 iOS 规范，版本号最多可能有3位
#define IOS_VERSION_NUMBER [XSWJVASPTHelper numbericOSVersion]

/// 是否横竖屏
/// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
/// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

/// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

/// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

/// 是否全面屏设备
#define IS_NOTCHED_SCREEN [XSWJVASPTHelper isNotchedScreen]
#define IS_65INCH_SCREEN [XSWJVASPTHelper is65InchScreen]/// iPhone XS Max
#define IS_61INCH_SCREEN [XSWJVASPTHelper is61InchScreen]/// iPhone XR
#define IS_58INCH_SCREEN [XSWJVASPTHelper is58InchScreen]/// iPhone X/XS
#define IS_55INCH_SCREEN [XSWJVASPTHelper is55InchScreen]/// iPhone 6/7/8 Plus
#define IS_47INCH_SCREEN [XSWJVASPTHelper is47InchScreen]/// iPhone 6/7/8
#define IS_40INCH_SCREEN [XSWJVASPTHelper is40InchScreen]/// iPhone 5/5S/SE
#define IS_35INCH_SCREEN [XSWJVASPTHelper is35InchScreen]/// iPhone 4/4S
#define IS_320WIDTH_SCREEN (IS_35INCH_SCREEN || IS_40INCH_SCREEN)/// iPhone 4/4S/5/5S/SE

/// 是否Retina
#define IS_RETINASCREEN ([[UIScreen mainScreen] scale] >= 2.0)

/// 是否放大模式（iPhone 6及以上的设备支持放大模式，iPhone X 除外）
#define IS_ZOOMEDMODE [XSWJVASPTHelper isZoomedMode]

#pragma mark - iOS设备
#define kDevice_Is_iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXMAX (CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896, 414), [UIScreen mainScreen].bounds.size))
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen]currentMode].size) : NO)
#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone X的一些适配

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
//'UI_USER_INTERFACE_IDIOM' is deprecated: first deprecated in iOS 13.0 - Use -[UIDevice userInterfaceIdiom] directly.
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
#define IS_IPHONE1 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#else
#define IS_IPHONE1 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#endif
#pragma clang diagnostic pop

#define IS_IPHONE_X (IS_IPHONE1 && SCREEN_HEIGHT >= 812.0)
#define NAV_HEIGHT (IS_IPHONE_X ? 88 : 64)
#define TABBAR_HEIGHT (IS_IPHONE_X ? 83 : 49)
#define BOTTOM_HEIGHT (IS_IPHONE_X ? 34 : 0)
#define TOP_HEIGHT (IS_IPHONE_X ? 44 : 0)
#define STATUSBAR_HEIGHT (IS_IPHONE_X ? 44 : 20)
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//物理屏幕高度
#define ScreenHeight (IS_IPHONE_X?(SCREEN_HEIGHT-BOTTOM_HEIGHT):SCREEN_HEIGHT)

//适配参数
#define SUIT_PARAM (kDevice_Is_iPhone6Plus ?1.12:(kDevice_Is_iPhone6?1.0:(kDevice_Is_iPhoneX ?1.01:(kDevice_Is_iPhoneXMAX?1.15:(kDevice_Is_iPhoneXR?1.05:0.85))))) //以6为基准图
#define SUIT_PARAM_IPHONEX (kDevice_Is_iPhone6Plus ?1.12:(kDevice_Is_iPhone6?1.0:(kDevice_Is_iPhoneX ?1.01:(kDevice_Is_iPhoneXMAX?1.15:(kDevice_Is_iPhoneXR?1.0:0.85))))) //以6为基准图


// frame
#define kLeftRightMargin 12.5
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]


#pragma mark - 变量-布局相关

/// 获取一个像素
#define PixelOne [XSWJVASPTHelper pixelOne]

/// bounds && nativeBounds / scale && nativeScale
#define ScreenBoundsSize ([[UIScreen mainScreen] bounds].size)
#define ScreenNativeBoundsSize ([[UIScreen mainScreen] nativeBounds].size)
#define ScreenScale ([[UIScreen mainScreen] scale])
#define ScreenNativeScale ([[UIScreen mainScreen] nativeScale])

/// toolBar相关frame
#define ToolBarHeight (IS_IPAD ? (IS_NOTCHED_SCREEN ? 65 : 50) : (IS_LANDSCAPE ? PreferredValueForVisualDevice(44, 32) : 44) + PreferredValueForNotchedDevice(39, 0))

/// tabBar相关frame
#define TabBarHeight (IS_IPAD ? (IS_NOTCHED_SCREEN ? 65 : 50) : PreferredValueForNotchedDevice(IS_LANDSCAPE ? 32 : 49, 49) + SafeAreaInsetsConstantForDeviceWithNotch.bottom)

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
#define StatusBarHeight ([UIApplication sharedApplication].statusBarHidden ? 0 : [[UIApplication sharedApplication] statusBarFrame].size.height)

/// 状态栏高度(如果状态栏不可见，也会返回一个普通状态下可见的高度)
#define StatusBarHeightConstant ([UIApplication sharedApplication].statusBarHidden ? (IS_IPAD ? (IS_NOTCHED_SCREEN ? 24 : 20) : PreferredValueForNotchedDevice(IS_LANDSCAPE ? 0 : 44, 20)) : [[UIApplication sharedApplication] statusBarFrame].size.height)

/// navigationBar 的静态高度
#define NavigationBarHeight (IS_LANDSCAPE ? PreferredValueForVisualDevice(44, 32) : 44)
#define LL_iPhoneX (kDevice_Is_iPhoneX || kDevice_Is_iPhoneXR || kDevice_Is_iPhoneXMAX)
#define LL_TabbarSafeBottomMargin (LL_iPhoneX ? 34.f : 0.f)// Tabbar safe bottom margin.

/// 代表(导航栏+状态栏)，这里用于获取其高度
/// @warn 如果是用于 viewController，请使用 UIViewController(QMUI) spt_navigationBarMaxYInViewCoordinator 代替
#define NavigationContentTop (StatusBarHeight + NavigationBarHeight)

/// 同上，这里用于获取它的静态常量值
#define NavigationContentTopConstant (StatusBarHeightConstant + NavigationBarHeight)

/// iPhoneX 系列全面屏手机的安全区域的静态值
#define SafeAreaInsetsConstantForDeviceWithNotch [XSWJVASPTHelper safeAreaInsetsForDeviceWithNotch]

/// 按屏幕宽度来区分不同 iPhone 尺寸，iPhone XS Max/XR/Plus 归为一类，iPhone X/8/7/6 归为一类。
/// iPad 也会视为最大的屏幕宽度来处理
#define PreferredValueForiPhone(_65or61or55inch, _47or58inch, _40inch, _35inch) PreferredValueForDeviceIncludingiPad(_65or61or55inch, _65or61or55inch, _47or58inch, _40inch, _35inch)

/// 同上，单独将 iPad 区分对待
#define PreferredValueForDeviceIncludingiPad(_iPad, _65or61or55inch, _47or58inch, _40inch, _35inch) PreferredValueForAll(_iPad, _65or61or55inch, _65or61or55inch, _47or58inch, _65or61or55inch, _47or58inch, _40inch, _35inch)

/// 区分全面屏（iPhone X 系列）和非全面屏
#define PreferredValueForNotchedDevice(_notchedDevice, _otherDevice) ([XSWJVASPTHelper isNotchedScreen] ? _notchedDevice : _otherDevice)

/// 将所有屏幕按照宽松/紧凑分类，其中 iPad、iPhone XS Max/XR/Plus 均为宽松屏幕，但开启了放大模式的设备均会视为紧凑屏幕
#define PreferredValueForVisualDevice(_regular, _compact) ([XSWJVASPTHelper isRegularScreen] ? _regular : _compact)

/// 区分全部的设备类型
#define PreferredValueForAll(_iPad, _65inch, _61inch, _58inch, _55inch, _47inch, _40inch, _35inch) (IS_IPAD ? _iPad : (IS_35INCH_SCREEN ? _35inch : (IS_40INCH_SCREEN ? _40inch : ((IS_47INCH_SCREEN || (IS_55INCH_SCREEN && IS_ZOOMEDMODE)) ? _47inch : (IS_55INCH_SCREEN ? _55inch : ((IS_58INCH_SCREEN || ((IS_61INCH_SCREEN || IS_65INCH_SCREEN) && IS_ZOOMEDMODE)) ? _58inch : (IS_61INCH_SCREEN ? _61inch : _65inch)))))))

#define CGSizeMax CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)

#pragma mark - 数学计算

#define AngleWithDegrees(deg) (M_PI * (deg) / 180.0)

#pragma mark - 动画

#define SPTViewAnimationOptionsCurveOut (7<<16)
#define SPTViewAnimationOptionsCurveIn (8<<16)

//#pragma mark - 其他
#define StringFromBOOL(_flag) (_flag ? @"YES" : @"NO")


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kMainCellColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1]
#define kInputViewHeight 50
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define QM_IS_IPHONEX ((kStatusBarHeight == 44)?YES:NO)
#define kScreenHeight (QM_IS_IPHONEX ? ([[UIScreen mainScreen] bounds].size.height - 34) : ([[UIScreen mainScreen] bounds].size.height))

#endif /* Macro_h */

//
//  XSWJVASPTHelper.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVASPTHelper.h"
#import "SPTLab.h"
#import "XSWJVASPTValue.h"
#import "XSWJVANSNumber+CGFloatValue.h"
#import "XSWJVANSObject+SPTUI.h"
#import "XSWJVANSString+SPTUI.h"
#import <math.h>
#import <sys/utsname.h>
//#import "ZYGUserModelManager.h"

NSString *const SPT_ResourcesMainBundleName = @"Resources.bundle";

@implementation XSWJVASPTHelper (Bundle)

+ (NSBundle *)resourcesBundle {
    return [XSWJVASPTHelper resourcesBundleWithName:SPT_ResourcesMainBundleName];
}

+ (NSBundle *)resourcesBundleWithName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];

    if (!bundle) {
        // 动态framework的bundle资源是打包在framework里面的，所以无法通过mainBundle拿到资源，只能通过其他方法来获取bundle资源。
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
        NSDictionary *bundleData = [self parseBundleName:bundleName];

        if (bundleData) {
            bundle = [NSBundle bundleWithPath:[frameworkBundle pathForResource:[bundleData objectForKey:@"name"] ofType:[bundleData objectForKey:@"type"]]];
        }
    }

    return bundle;
}

+ (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [XSWJVASPTHelper resourcesBundle];
    return [XSWJVASPTHelper imageInBundle:bundle withName:name];
}

+ (UIImage *)imageInBundle:(NSBundle *)bundle withName:(NSString *)name {
    if (bundle && name) {
        if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
            return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
        } else {
            NSString *imagePath = [[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
            return [UIImage imageWithContentsOfFile:imagePath];
        }
    }

    return nil;
}

+ (NSDictionary *)parseBundleName:(NSString *)bundleName {
    NSArray *bundleData = [bundleName componentsSeparatedByString:@"."];

    if (bundleData.count == 2) {
        return @{ @"name": bundleData[0], @"type": bundleData[1] };
    }

    return nil;
}

@end

@implementation XSWJVASPTHelper (DynamicType)

+ (NSNumber *)preferredContentSizeLevel {
    NSNumber *index = nil;

    if ([UIApplication instancesRespondToSelector:@selector(preferredContentSizeCategory)]) {
        NSString *contentSizeCategory = [[UIApplication sharedApplication] preferredContentSizeCategory];
        if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraSmall]) {
            index = [NSNumber numberWithInt:0];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategorySmall]) {
            index = [NSNumber numberWithInt:1];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryMedium]) {
            index = [NSNumber numberWithInt:2];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryLarge]) {
            index = [NSNumber numberWithInt:3];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraLarge]) {
            index = [NSNumber numberWithInt:4];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
            index = [NSNumber numberWithInt:5];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityMedium]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else {
            index = [NSNumber numberWithInt:6];
        }
    } else {
        index = [NSNumber numberWithInt:3];
    }

    return index;
}

+ (CGFloat)heightForDynamicTypeCell:(NSArray *)heights {
    NSNumber *index = [XSWJVASPTHelper preferredContentSizeLevel];
    return [((NSNumber *)[heights objectAtIndex:[index intValue]]) spt_CGFloatValue];
}

@end

@implementation XSWJVASPTHelper (Keyboard)
//@property(nonatomic, assign) BOOL keyboardVisible;
//@property(nonatomic, assign) CGFloat lastKeyboardHeight;
SPTSynthesizeBOOLProperty(keyboardVisible, setKeyboardVisible)
SPTSynthesizeCGFloatProperty(lastKeyboardHeight, setLastKeyboardHeight)

- (void)handleKeyboardWillShow:(NSNotification *)notification {
    self.keyboardVisible = YES;
    self.lastKeyboardHeight = [XSWJVASPTHelper keyboardHeightWithNotification:notification];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    self.keyboardVisible = NO;
}

+ (BOOL)isKeyboardVisible {
    BOOL visible = [XSWJVASPTHelper sharedInstance].keyboardVisible;
    return visible;
}

+ (CGFloat)lastKeyboardHeightInApplicationWindowWhenVisible {
    return [XSWJVASPTHelper sharedInstance].lastKeyboardHeight;
}

+ (CGRect)keyboardRectWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 注意iOS8以下的系统在横屏时得到的rect，宽度和高度相反了，所以不建议直接通过这个方法获取高度，而是使用<code>keyboardHeightWithNotification:inView:</code>，因为在后者的实现里会将键盘的rect转换坐标系，转换过程就会处理横竖屏旋转问题。
    return keyboardRect;
}

+ (CGFloat)keyboardHeightWithNotification:(NSNotification *)notification {
    return [XSWJVASPTHelper keyboardHeightWithNotification:notification inView:nil];
}

+ (CGFloat)keyboardHeightWithNotification:(nullable NSNotification *)notification inView:(nullable UIView *)view {
    CGRect keyboardRect = [self keyboardRectWithNotification:notification];
    if (!view) {
        return CGRectGetHeight(keyboardRect);
    }
    CGRect keyboardRectInView = [view convertRect:keyboardRect fromView:view.window];
    CGRect keyboardVisibleRectInView = CGRectIntersection(view.bounds, keyboardRectInView);
    CGFloat resultHeight = CGRectIsValidated(keyboardVisibleRectInView) ? CGRectGetHeight(keyboardVisibleRectInView) : 0;
    return resultHeight;
}

+ (NSTimeInterval)keyboardAnimationDurationWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    return animationDuration;
}

+ (UIViewAnimationCurve)keyboardAnimationCurveWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    return curve;
}

+ (UIViewAnimationOptions)keyboardAnimationOptionsWithNotification:(NSNotification *)notification {
    UIViewAnimationOptions options = [XSWJVASPTHelper keyboardAnimationCurveWithNotification:notification] << 16;
    return options;
}

@end

@implementation XSWJVASPTHelper (UIGraphic)

static CGFloat pixelOne = -1.0f;
+ (CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / [[UIScreen mainScreen] scale];
    }
    return pixelOne;
}

+ (void)inspectContextSize:(CGSize)size {
    if (!CGSizeIsValidated(size)) {
        NSAssert(NO, @"CGPostError, %@:%d %s, 非法的size：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, NSStringFromCGSize(size), [NSThread callStackSymbols]);
    }
}

+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef)context {
    if (!context) {
        // crash了就找zhoon或者molice
        NSAssert(NO, @"CGPostError, %@:%d %s, 非法的context：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, context, [NSThread callStackSymbols]);
    }
}

+ (BOOL)inspectContextIfInvalidatedInReleaseMode:(CGContextRef)context {
    if (context) {
        return YES;
    }
    return NO;
}

@end

@implementation XSWJVASPTHelper (Device)

+ (NSString *)deviceModel {
    if (IS_SIMULATOR) {
        // Simulator doesn't return the identifier for the actual physical model, but returns it as an environment variable
        // 模拟器不返回物理机器信息，但会通过环境变量的方式返回
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }

    // See https://www.theiphonewiki.com/wiki/Models for identifiers
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        isIPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
        #else
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
        #endif
    }
    return isIPad > 0;
}

static NSInteger isIPod = -1;
+ (BOOL)isIPod {
    if (isIPod < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPod = [string rangeOfString:@"iPod touch"].location != NSNotFound ? 1 : 0;
    }
    return isIPod > 0;
}

static NSInteger isIPhone = -1;
+ (BOOL)isIPhone {
    if (isIPhone < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPhone = [string rangeOfString:@"iPhone"].location != NSNotFound ? 1 : 0;
    }
    return isIPhone > 0;
}

static NSInteger isSimulator = -1;

+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}

static NSInteger isNotchedScreen = -1;

+ (BOOL)isNotchedScreen {
    if (@available(iOS 11, *)) {
        if (isNotchedScreen < 0) {
            if (@available(iOS 12.0, *)) {
                /*
                 检测方式解释/测试要点：
                 1. iOS 11 与 iOS 12 可能行为不同，所以要分别测试。
                 2. 与触发 [XSWJVASPTHelper isNotchedScreen] 方法时的进程有关，[NSObject performSelectorOnMainThread:withObject:waitUntilDone:NO] 就会导致较多的异常。
                 3. iOS 12 下，在非第2点里提到的情况下，iPhone、iPad 均可通过 UIScreen -_peripheryInsets 方法的返回值区分，但如果满足了第2点，则 iPad 无法使用这个方法，这种情况下要依赖第4点。
                 4. iOS 12 下，不管是否满足第2点，不管是什么设备类型，均可以通过一个满屏的 UIWindow 的 rootViewController.view.frame.origin.y 的值来区分，如果是非全面屏，这个值必定为20，如果是全面屏，则可能是24或44等不同的值。但由于创建 UIWindow、UIViewController 等均属于较大消耗，所以只在前面的步骤无法区分的情况下才会使用第4点。
                 5. 对于第4点，经测试与当前设备的方向、是否有勾选 project 里的 General - Hide status bar、当前是否处于来电模式的状态栏这些都没关系。
                 */
                SEL peripheryInsetsSelector = NSSelectorFromString([NSString stringWithFormat:@"_%@%@", @"periphery", @"Insets"]);
                UIEdgeInsets peripheryInsets = UIEdgeInsetsZero;
                [[UIScreen mainScreen] spt_performSelector:peripheryInsetsSelector withReturnValue:&peripheryInsets];

                if (peripheryInsets.bottom <= 0) {
                    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
                    peripheryInsets = window.safeAreaInsets;

                    if (peripheryInsets.bottom <= 0) {
                        UIViewController *viewController = [UIViewController new];
                        [viewController loadViewIfNeeded];
                        window.rootViewController = viewController;
                        if (CGRectGetMinY(viewController.view.frame) > 20) {
                            peripheryInsets.bottom = 1;
                        }
                    }
                }

                isNotchedScreen = peripheryInsets.bottom > 0 ? 1 : 0;
            } else {
                isNotchedScreen = [XSWJVASPTHelper is58InchScreen] ? 1 : 0;
            }
        }
    } else {
        isNotchedScreen = 0;
    }

    return isNotchedScreen > 0;
}

+ (BOOL)isRegularScreen {
    return [self isIPad] || (!IS_ZOOMEDMODE && ([self is65InchScreen] || [self is61InchScreen] || [self is55InchScreen]));
}

static NSInteger is65InchScreen = -1;
+ (BOOL)is65InchScreen {
    if (is65InchScreen < 0) {
        // Since iPhone XS Max and iPhone XR share the same resolution, we have to distinguish them using the model identifiers
        // 由于 iPhone XS Max 和 iPhone XR 的屏幕宽高是一致的，我们通过机器 Identifier 加以区别
        is65InchScreen = (DEVICE_WIDTH == self.screenSizeFor65Inch.width && DEVICE_HEIGHT == self.screenSizeFor65Inch.height && ([[XSWJVASPTHelper deviceModel] isEqualToString:@"iPhone11,4"] || [[XSWJVASPTHelper deviceModel] isEqualToString:@"iPhone11,6"])) ? 1 : 0;
    }
    return is65InchScreen > 0;
}

static NSInteger is61InchScreen = -1;
+ (BOOL)is61InchScreen {
    if (is61InchScreen < 0) {
        is61InchScreen = (DEVICE_WIDTH == self.screenSizeFor61Inch.width && DEVICE_HEIGHT == self.screenSizeFor61Inch.height && [[XSWJVASPTHelper deviceModel] isEqualToString:@"iPhone11,8"]) ? 1 : 0;
    }
    return is61InchScreen > 0;
}

static NSInteger is58InchScreen = -1;
+ (BOOL)is58InchScreen {
    if (is58InchScreen < 0) {
        // Both iPhone XS and iPhone X share the same actual screen sizes, so no need to compare identifiers
        // iPhone XS 和 iPhone X 的物理尺寸是一致的，因此无需比较机器 Identifier
        is58InchScreen = (DEVICE_WIDTH == self.screenSizeFor58Inch.width && DEVICE_HEIGHT == self.screenSizeFor58Inch.height) ? 1 : 0;
    }
    return is58InchScreen > 0;
}

static NSInteger is55InchScreen = -1;
+ (BOOL)is55InchScreen {
    if (is55InchScreen < 0) {
        is55InchScreen = (DEVICE_WIDTH == self.screenSizeFor55Inch.width && DEVICE_HEIGHT == self.screenSizeFor55Inch.height) ? 1 : 0;
    }
    return is55InchScreen > 0;
}

static NSInteger is47InchScreen = -1;
+ (BOOL)is47InchScreen {
    if (is47InchScreen < 0) {
        is47InchScreen = (DEVICE_WIDTH == self.screenSizeFor47Inch.width && DEVICE_HEIGHT == self.screenSizeFor47Inch.height) ? 1 : 0;
    }
    return is47InchScreen > 0;
}

static NSInteger is40InchScreen = -1;
+ (BOOL)is40InchScreen {
    if (is40InchScreen < 0) {
        is40InchScreen = (DEVICE_WIDTH == self.screenSizeFor40Inch.width && DEVICE_HEIGHT == self.screenSizeFor40Inch.height) ? 1 : 0;
    }
    return is40InchScreen > 0;
}

static NSInteger is35InchScreen = -1;
+ (BOOL)is35InchScreen {
    if (is35InchScreen < 0) {
        is35InchScreen = (DEVICE_WIDTH == self.screenSizeFor35Inch.width && DEVICE_HEIGHT == self.screenSizeFor35Inch.height) ? 1 : 0;
    }
    return is35InchScreen > 0;
}

+ (CGSize)screenSizeFor65Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor61Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor58Inch {
    return CGSizeMake(375, 812);
}

+ (CGSize)screenSizeFor55Inch {
    return CGSizeMake(414, 736);
}

+ (CGSize)screenSizeFor47Inch {
    return CGSizeMake(375, 667);
}

+ (CGSize)screenSizeFor40Inch {
    return CGSizeMake(320, 568);
}

+ (CGSize)screenSizeFor35Inch {
    return CGSizeMake(320, 480);
}

static CGFloat preferredLayoutWidth = -1;
+ (CGFloat)preferredLayoutAsSimilarScreenWidthForIPad {
    if (preferredLayoutWidth < 0) {
        NSArray<NSNumber *> *widths = @[@([self screenSizeFor65Inch].width),
                                        @([self screenSizeFor58Inch].width),
                                        @([self screenSizeFor40Inch].width)];
        preferredLayoutWidth = SCREEN_WIDTH;
        UIWindow *window = [UIApplication sharedApplication].delegate.window ? : [[UIWindow alloc] init];// iOS 9 及以上的系统，新 init 出来的 window 自动被设置为当前 App 的宽度
        CGFloat windowWidth = CGRectGetWidth(window.bounds);
        for (NSInteger i = 0; i < widths.count; i++) {
            if (windowWidth <= widths[i].spt_CGFloatValue) {
                preferredLayoutWidth = widths[i].spt_CGFloatValue;
                continue;
            }
        }
    }
    return preferredLayoutWidth;
}

+ (UIEdgeInsets)safeAreaInsetsForDeviceWithNotch {
    if (![self isNotchedScreen]) {
        return UIEdgeInsetsZero;
    }

    if ([self isIPad]) {
        return UIEdgeInsetsMake(0, 0, 20, 0);
    }

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return UIEdgeInsetsMake(44, 0, 34, 0);

        case UIInterfaceOrientationPortraitUpsideDown:
            return UIEdgeInsetsMake(34, 0, 44, 0);

        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return UIEdgeInsetsMake(0, 44, 21, 44);

        case UIInterfaceOrientationUnknown:
        default:
            return UIEdgeInsetsMake(44, 0, 34, 0);
    }
}

static NSInteger isHighPerformanceDevice = -1;
+ (BOOL)isHighPerformanceDevice {
    if (isHighPerformanceDevice < 0) {
        NSString *model = [XSWJVASPTHelper deviceModel];
        NSString *identifier = [model spt_stringMatchedByPattern:@"\\d+"];
        NSInteger version = identifier.integerValue;
        if (IS_IPAD) {
            isHighPerformanceDevice = version >= 5 ? 1 : 0;// iPad Air 2
        } else {
            isHighPerformanceDevice = version >= 10 ? 1 : 0;// iPhone 8
        }
    }
    return isHighPerformanceDevice > 0;
}

+ (BOOL)isZoomedMode {
    if (!IS_IPHONE) {
        return NO;
    }

    CGFloat nativeScale = UIScreen.mainScreen.nativeScale;
    CGFloat scale = UIScreen.mainScreen.scale;

    // 对于所有的 Plus 系列 iPhone，屏幕物理像素低于软件层面的渲染像素，不管标准模式还是放大模式，nativeScale 均小于 scale，所以需要特殊处理才能准确区分放大模式
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    BOOL shouldBeDownsampledDevice = CGSizeEqualToSize(UIScreen.mainScreen.nativeBounds.size, CGSizeMake(1080, 1920));
    if (shouldBeDownsampledDevice) {
        scale /= 1.15;
    }

    return nativeScale > scale;
}

- (void)handleAppSizeWillChange:(NSNotification *)notification {
    preferredLayoutWidth = -1;
}

@end

@implementation XSWJVASPTHelper (UIApplication)

+ (void)renderStatusBarStyleDark {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

+ (void)renderStatusBarStyleLight {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)dimmedApplicationWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [window tintColorDidChange];
}

+ (void)resetDimmedApplicationWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    [window tintColorDidChange];
}

+ (BOOL)isLogin {
//    NSString *userSession = [[NSUserDefaults standardUserDefaults] stringForKey:kAuthSessionKey];
//
//    if (String_IsEmpty(userSession)) {
//        return NO;
//    }
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    ZYGUserDetailInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:kAuthUserDetailModelKey]];
//
//    if (!model) {
//        [ZYGUserModelManager fetchUserDetailInfoWithCompletion:^(NSString *_Nonnull msg, ZYGUserDetailInfoModel *_Nonnull model, NSError *_Nonnull error) {
//            if (!error) {
//                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:kAuthUserDetailModelKey];
//                [[NSUserDefaults standardUserDefaults] setObject:model.userid forKey:kAuthSessionKey];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//        }];
//    }
//
//    return YES;
    return YES;
}

@end

@implementation XSWJVASPTHelper (Animation)

+ (void)executeAnimationBlock:(__attribute__((noescape)) void (^)(void))animationBlock completionBlock:(__attribute__((noescape)) void (^)(void))completionBlock {
    if (!animationBlock) return;
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionBlock];
    animationBlock();
    [CATransaction commit];
}

@end

@implementation XSWJVASPTHelper (SystemVersion)

+ (NSInteger)numbericOSVersion {
    NSString *OSVersion = [[UIDevice currentDevice] systemVersion];
    NSArray *OSVersionArr = [OSVersion componentsSeparatedByString:@"."];

    NSInteger numbericOSVersion = 0;
    NSInteger pos = 0;

    while ([OSVersionArr count] > pos && pos < 3) {
        numbericOSVersion += ([[OSVersionArr objectAtIndex:pos] integerValue] * pow(10, (4 - pos * 2)));
        pos++;
    }

    return numbericOSVersion;
}

+ (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion {
    NSArray *currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
    NSArray *targetVersionArr = [targetVersion componentsSeparatedByString:@"."];

    NSInteger pos = 0;

    while ([currentVersionArr count] > pos || [targetVersionArr count] > pos) {
        NSInteger v1 = [currentVersionArr count] > pos ? [[currentVersionArr objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [targetVersionArr count] > pos ? [[targetVersionArr objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            return NSOrderedAscending;
        } else if (v1 > v2) {
            return NSOrderedDescending;
        }
        pos++;
    }

    return NSOrderedSame;
}

+ (BOOL)isCurrentSystemAtLeastVersion:(NSString *)targetVersion {
    return [XSWJVASPTHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedSame || [XSWJVASPTHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedDescending;
}

+ (BOOL)isCurrentSystemLowerThanVersion:(NSString *)targetVersion {
    return [XSWJVASPTHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedAscending;
}

@end

@implementation XSWJVASPTHelper (Controller)

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
 
    return currentVC;
}
 
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
 
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];// 视图是被presented出来的
    }
 
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];// 根视图为UITabBarController
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]]; // 根视图为UINavigationController
    } else {
        currentVC = rootVC; // 根视图为非导航类
    }
 
    return currentVC;
}

+ (UIViewController *)findCurrentShowingViewController {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}
 
//注意考虑几种特殊情况：①A present B, B present C，参数vc为A时候的情况
/* 完整的描述请参见文件头部 */
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc {
    //方法1：递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) { //注要优先判断vc是否有弹出其他视图，如有则当前显示的视图肯定是在那上面
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    
    return currentShowingVC;
}

@end

@implementation XSWJVASPTHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static XSWJVASPTHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
        // 先设置默认值，不然可能变量的指针地址错误
        instance.keyboardVisible = NO;
        instance.lastKeyboardHeight = 0;
        //instance.orientationBeforeChangingByHelper = UIDeviceOrientationUnknown;

        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleAppSizeWillChange:) name:SPTAppSizeWillChangeNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleDeviceOrientationNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    });

    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (void)dealloc {
    // XSWJVASPTHelper 若干个分类里有用到消息监听，所以在 dealloc 的时候注销一下
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

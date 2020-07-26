//
//  PickTaMainTabBarController.m
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaMainTabBarController.h"
#import "PickTaBaseViewController.h"
#import "PickTaNavigationController.h"
#import "PickTaHomeVC.h"
#import "PickTaTaskVC.h"
#import "PickTaCallVC.h"
#import "PickTaMyVC.h"

static CGFloat const CYLTabBarControllerHeight = 40.f;

#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]

@interface PickTaMainTabBarController ()
@property (nonatomic, weak) UIButton *selectedCover;

@end

@implementation PickTaMainTabBarController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self = [self initWithContext:@""];
//    }
//    return self;
//}



- (instancetype)initWithContext:(NSString *)context {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:context
                ]) {
        [self customizeTabBarAppearanceWithTitlePositionAdjustment:titlePositionAdjustment];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (NSArray *)viewControllersForTabBar {
    PickTaBaseViewController *firstViewController = [[PickTaHomeVC alloc] init];
    PickTaNavigationController *firstNavigationController = [[PickTaNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    // [firstViewController cyl_setNavigationBarHidden:YES];
    PickTaBaseViewController *secondViewController = [[PickTaCallVC alloc] init];
    PickTaNavigationController *secondNavigationController = [[PickTaNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    // [secondViewController cyl_setNavigationBarHidden:YES];

    PickTaBaseViewController *thirdViewController = [[PickTaTaskVC alloc] init];
    PickTaNavigationController *thirdNavigationController = [[PickTaNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"MyViews" bundle:nil];
    PickTaMyVC * fourthViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PickTaMyVC"];
    

    PickTaNavigationController *fourthNavigationController = [[PickTaNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [fourthNavigationController cyl_setHideNavigationBarSeparator:YES];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    // lottie动画的json文件来自于NorthSea, respect!
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"home_unsel"],  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"home_sel",  /* NSString and UIImage are supported*/
//
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                 };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"computer_unsel"],
                                                  CYLTabBarItemSelectedImage : @"computer_sel",
                                                  CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)],

//                                                  CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(33, 33)]
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"task_unsel"],
                                                 CYLTabBarItemSelectedImage : @"task_sel",
                                                
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(44, 44)]
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"",
                                                  CYLTabBarItemImage :[UIImage imageNamed:@"my_unsel"],
                                                  CYLTabBarItemSelectedImage : @"my_sel",
//                                                  CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearanceWithTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor cyl_systemGrayColor];
    //normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor cyl_labelColor];
    //selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];

    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        // fix https://github.com/ChenYilong/CYLTabBarController/issues/456
        inlineLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment;

        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = [UIColor cyl_systemBackgroundColor];
        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
        standardAppearance.shadowColor = [UIColor systemGray5Color];
        // standardAppearance.shadowImage = [[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:[UIColor systemGray5Color] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    }
    
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = self.tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor whiteColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image {
    CGFloat halfWidth = image.size.width/2;
    CGFloat halfHeight = image.size.height/2;
    UIImage *secondStrechImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    return secondStrechImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"");
}

- (UIButton *)selectedCover {
    if (_selectedCover) {
        return _selectedCover;
    }
    UIButton *selectedCover = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"home_select_cover"];
    [selectedCover setImage:image forState:UIControlStateNormal];
    selectedCover.frame = ({
        CGRect frame = selectedCover.frame;
        frame.size = CGSizeMake(image.size.width, image.size.height);
        frame;
    });
    selectedCover.translatesAutoresizingMaskIntoConstraints = NO;
    // selectedCover.userInteractionEnabled = false;
    _selectedCover = selectedCover;
    return _selectedCover;
}

- (void)setSelectedCoverShow:(BOOL)show {
    UIControl *selectedTabButton = [self.viewControllers[0].tabBarItem cyl_tabButton];
    [selectedTabButton cyl_replaceTabButtonWithNewView:self.selectedCover
                                                  show:show];
    //fix: #480
    //selectedTabButton.cyl_tabImageView.hidden = YES;
    if (show) {
        [self addOnceScaleAnimationOnView:self.selectedCover];
    }
}

//缩放动画
- (void)addOnceScaleAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.5, @1.0];
    animation.duration = 0.1;
    //    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection  {
    [super traitCollectionDidChange:previousTraitCollection];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
#if __has_include(<UIKit/UIScene.h>)
        UIUserInterfaceStyle currentUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
        if (currentUserInterfaceStyle == previousTraitCollection.userInterfaceStyle) {
            return;
        }
#else
#endif
        //TODO:
        [[UIViewController cyl_topmostViewController].navigationController.navigationBar setBarTintColor:[UIColor cyl_systemBackgroundColor]];
    }
    #endif
    
}



#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BOOL should = YES;
    [self updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:should];
    UIControl *selectedTabButton = [viewController.tabBarItem cyl_tabButton];
    if (selectedTabButton.selected) {
        @try {
            [[[self class] cyl_topmostViewController] performSelector:@selector(refresh)];
        } @catch (NSException *exception) {
            NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception.reason);
        }
    }
    return should;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
      // 如果 PlusButton 也添加了点击事件，那么点击 PlusButton 后不会触发该代理方法。
      if ([control isKindOfClass:[CYLExternPlusButton class]]) {
          UIButton *button = CYLExternPlusButton;
          animationView = button.imageView;
      } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
          for (UIView *subView in control.subviews) {
              if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                  animationView = subView;
              }
          }
      }
      
//      if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
//          [self addScaleAnimationOnView:animationView];
//      } else {
//          [self addRotateAnimationOnView:animationView];
//      }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView {
   //需要实现的帧动画，这里根据需求自定义
   CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
   animation.keyPath = @"transform.scale";
   animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
   animation.duration = 1;
   animation.calculationMode = kCAAnimationCubic;
   [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
   [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
       animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
   } completion:nil];
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
           animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
       } completion:nil];
   });
}


@end

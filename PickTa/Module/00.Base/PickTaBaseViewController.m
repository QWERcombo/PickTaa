//
//  PickTaBaseViewController.m
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import <MJRefresh.h>

@interface PickTaBaseViewController ()

@end

@implementation PickTaBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.extendedLayoutIncludesOpaqueBars = YES;//

//    if ([self respondsToSelector:@selector(navBackgroundImage)]) {
//           UIImage *bgimage = [self navBackgroundImage];
//           [self setNavigationBack:bgimage];
//       }

       if (![self leftButton]) {
           [self configLeftBaritemWithImage];
       }

       if (![self rightButton]) {
           [self configRightBaritemWithImage];
       }
  
    if([self respondsToSelector:@selector(setupUI)])
        [self setupUI];
    
    if([self respondsToSelector:@selector(createVM)])
        [self createVM];
    
    if([self respondsToSelector:@selector(bindViewModel)])
        [self bindViewModel];
    
    if([self respondsToSelector:@selector(requestData)])
        [self requestData];
    
    //注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeLanguage {
//    _rightBtn.title = kLocalizedString(@"Setting",@"设置");
}

-(UITableView *)createTableViewForFrame:(CGRect)frame style:(UITableViewStyle)style backGroundColor:(UIColor *)color tableViewDelegate:(NSObject<UITableViewDelegate> *)objDelegate tableViewDataSource:(NSObject<UITableViewDataSource> *)objDataSource{
    NSAssert(objDelegate, @"objDelegate 参数必须存在");
    NSAssert(objDataSource, @"objDelegate 参数必须存在");
    //    NSParameterAssert(objDataSource);
    
    color = color ?: [UIColor whiteColor];
    frame = CGRectEqualToRect(frame, CGRectZero) ? SCREEN_BOUNDS : frame;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.delegate = objDelegate;
    tableView.dataSource = objDataSource;
    tableView.backgroundColor = color;
    tableView.tableFooterView = [UIView new];
    return tableView;
}

-(UICollectionView *)createCollectionViewForFrame:(CGRect)frame backGroundColor:(UIColor *)color collectionViewDelegate:(NSObject<UICollectionViewDelegate> *)objDelegate collectionViewDataSource:(NSObject<UICollectionViewDataSource> *)objDataSource collectionViewFlowLayout:(UICollectionViewFlowLayout *)flowLayout{
    
    NSAssert(objDelegate, @"objDelegate 参数必须存在");
    NSAssert(objDataSource, @"objDelegate 参数必须存在");
    color = color ?: [UIColor whiteColor];
    frame = CGRectEqualToRect(frame, CGRectZero) ? SCREEN_BOUNDS : frame;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.delegate = objDelegate;
    collectionView.dataSource = objDataSource;
    collectionView.backgroundColor = color;
    return collectionView;
}

- (void)additionRefresh:(UIScrollView *)ess_view target:(NSObject<G_MJRefreshProtocol> *)target forHeader:(Boolean)useHeader forFooter:(Boolean)useFooter
{
    if(useHeader==YES){
        ess_view.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:@selector(pullHeaderRefresh)];
    }
    if(useFooter==YES){
        ess_view.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:@selector(pushFooterRefresh)];
    }
}


- (UIButton *)set_leftButton {
    UIButton *left_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    NSString *backImageName = self.navigationController.viewControllers.count > 1 ? @"common_back" : @"";
    [left_button setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    left_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    left_button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    left_button.hitTestEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -10);

    return left_button;
}

- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationBack:(UIImage *)image {
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    // self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setShadowImage:image];
}

#pragma mark - left_item

- (void)configLeftBaritemWithImage {
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(left_click:)];
        self.navigationItem.backBarButtonItem = item;
    }
}

- (void)configRightBaritemWithImage {
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(right_click:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark - left_button

- (BOOL)leftButton {
    BOOL isleft = [self respondsToSelector:@selector(set_leftButton)];

    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        _left_button1 = leftbutton;
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }

    return isleft;
}

#pragma mark -- right_button

- (BOOL)rightButton {
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];

    if (isright) {
        UIButton *right_button = [self set_rightButton];
        _right_button1 = right_button;
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }

    return isright;
}

- (void)left_click:(id)sender {
    if ([self respondsToSelector:@selector(left_button_event:)]) {
        [self left_button_event:sender];
    }
}

- (void)right_click:(id)sender {
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}

//- (void)changeNavigationBarHeight:(CGFloat)offset {
//    CGFloat navY = navigationY;
//    [UIView animateWithDuration:0.3f animations:^{
//        self.navigationController.navigationBar.frame = CGRectMake(
//            self.navigationController.navigationBar.frame.origin.x,
//            navY,
//            self.navigationController.navigationBar.frame.size.width,
//            offset
//            );
//    }];
//}
//
//- (void)changeNavigationBarTranslationY:(CGFloat)translationY {
//    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
//}


@end

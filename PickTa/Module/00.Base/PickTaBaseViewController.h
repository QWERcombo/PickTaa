//
//  PickTaBaseViewController.h
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G_MJRefreshProtocol.h"
#import "UIViewController+alert.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YCPBaseViewControllerDataSource <NSObject>
@optional
- (UIButton *)set_leftButton;
- (UIButton *)set_rightButton;
- (UIColor *)set_colorBackground;
- (UIImage *)navBackgroundImage;
- (UIImage *)set_leftBarButtonItemWithImage;
- (UIImage *)set_rightBarButtonItemWithImage;
- (BOOL)hideNavigationBottomLine;
@end

@protocol YCPBaseViewControllerDelegate <NSObject>
@optional
- (void)left_button_event:(UIButton *)sender;// 左按钮点击事件,默认为popViewcontroller,子类可重写
- (void)right_button_event:(UIButton *)sender;// 右按钮点击事件,子类可重写
@end


@interface PickTaBaseViewController : UIViewController <YCPBaseViewControllerDataSource, YCPBaseViewControllerDelegate>

@property (nonatomic, strong) UIButton *right_button1;
@property (nonatomic, strong) UIButton *left_button1;

-(void)setupUI;
-(void)createVM;
-(void)bindViewModel;
-(void)requestData;
- (void)changeLanguage;
/**
 创建TableView
 frame  默认屏幕尺寸
 style   默认UITableViewStylePlain
 color  默认白色
 delegate 必填
 datasource 必填
 */
-(UITableView*)createTableViewForFrame:(CGRect)frame
                                 style:(UITableViewStyle)style
                       backGroundColor:(UIColor* __nullable)color
                     tableViewDelegate:(NSObject<UITableViewDelegate>*)objDelegate
                   tableViewDataSource:(NSObject<UITableViewDataSource>*)objDataSource;


-(UICollectionView*)createCollectionViewForFrame:(CGRect)frame
                                 backGroundColor:(UIColor* __nullable)color
                          collectionViewDelegate:(NSObject<UICollectionViewDelegate>*)objDelegate
                        collectionViewDataSource:(NSObject<UICollectionViewDataSource>*)objDataSource
                        collectionViewFlowLayout:(UICollectionViewFlowLayout*)flowLayout;

/**
 添加下拉刷新、上拉加载更多
 ess_view 可为tableView、collectionView、scrollView
 target 必须遵守并实现 Ess_MJRefreshProtocol
 useHeader 是否使用header
 useFooter 是否使用footer
 */
-(void)additionRefresh:(UIScrollView*)ess_view
                target:(NSObject<G_MJRefreshProtocol>*)target
             forHeader:(Boolean)useHeader
             forFooter:(Boolean)useFooter;



@end

NS_ASSUME_NONNULL_END

//
//  PTTaskCenterVC.m
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskCenterVC.h"
#import <SGPagingView/SGPagingView.h>

#import "PTTaskDoingVC.h"
#import "PTTaskFinishVC.h"
#import "PTTaskAlreadyVC.h"
#import "PTTaskTGWVC.h"
#import "PTTaskJZJSVC.h"
#import "PTTaskTGBLVC.h"
#import "PTTangguowuVC.h"

@interface PTTaskCenterVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>
@property (nonatomic,strong) SGPageTitleView *pageTitleView;
@property (nonatomic,strong) SGPageContentScrollView *pageContentScrollView;
@end

@implementation PTTaskCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeLanguage];
}

- (void)changeLanguage {
    self.title = kLocalizedString(@"task_center", @"任务中心");
    self.tgwLbl.text = kLocalizedString(@"candy_house", @"糖果屋");
    self.gzjsLbl.text = kLocalizedString(@"store", @"卷轴集市");
    self.tgblLbl.text = kLocalizedString(@"team", @"推广部落");
}

-(void)setupUI{
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleSelectedColor = MainBlueColor;
    configure.titleColor = [UIColor grayColor];
    configure.indicatorColor = MainBlueColor;
    configure.bottomSeparatorColor = ChatLineColor;
    /// pageTitleView
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+120, SCREEN_WIDTH, 44) delegate:self titleNames:@[
        kLocalizedString(@"ongoing", @"进行中"),
        kLocalizedString(@"completed", @"已完成"),
        kLocalizedString(@"expired", @"已过期")
    ] configure:configure];
    [self.view addSubview:pageTitleView];
    self.pageTitleView = pageTitleView;
    
    NSArray *childVCs = [NSArray arrayWithObjects:[PTTaskDoingVC new],[PTTaskFinishVC new],[PTTaskAlreadyVC new], nil];
    /// pageContent
    SGPageContentScrollView *pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, pageTitleView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-pageTitleView.bottom) parentVC:self childVCs:childVCs];
    pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:pageContentScrollView];
    self.pageContentScrollView = pageContentScrollView;
    
    @weakify(self)
    [[self.tgwBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        PTTangguowuVC *vc = [PTTangguowuVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.jzjsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[PTTaskJZJSVC new] animated:YES];
    }];
    
    [[self.tgblBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[PTTaskTGBLVC new] animated:YES];
    }];
}

-(void)createVM{
    
}

-(void)bindViewModel{
    
}

-(void)requestData{
    
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}


@end

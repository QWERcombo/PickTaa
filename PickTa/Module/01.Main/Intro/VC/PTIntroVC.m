//
//  PTIntroVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTIntroVC.h"
#import "PTHeadTVC.h"
#import "PTARCodeTVC.h"

@interface PTIntroVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation PTIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    [self setupNavBar];
    [self setupUI];
    
}

#pragma mark - Network Request

- (void)reloadListView {

}

- (void)refreshData {
    
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = _itemModel.nickname;
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.contentTableView];
}

#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1 && Array_IsEmpty(self.adDataSource)) {
//        return 20;
//    }
//
//    return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 1 && Array_IsEmpty(self.adDataSource)) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//        view.backgroundColor = UIColor.clearColor;
//
//        return view;
//    }
//
//    return nil;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        if (Array_IsEmpty(self.adDataSource)) {
//            return 0;
//        } else {
//            return 18.5 + (SCREEN_WIDTH - 2 * kLeftRightMargin) * 120 / 350.f;
//        }
//    } else {  // 2
////        ZYGGoodsBriefModel *goodsBriefModel = self.dataSource[indexPath.row];
////
////        if ((self.huodongType == SPTHuoDongTypeMaiZeng) && !String_IsEmpty(goodsBriefModel.ad.name)) {
////            return 150;
////        }
//
//        return 120;
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PTHeadTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTHeadTVC"];
        return cell;
    } else {
        PTARCodeTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTARCodeTVC"];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    }

    if (indexPath.section == 1) {
    }
}

#pragma mark - Setter Getter

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated"
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT+NAV_HEIGHT) style:UITableViewStylePlain];
         #pragma clang diagnostic pop
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        // _contentTableView.emptyDataSetSource = self;
        // _contentTableView.emptyDataSetDelegate = self;
        _contentTableView.backgroundColor = UIColor.whiteColor;//COLOR_F2F5F5;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//        _contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _contentTableView.tableFooterView = UIView.new;// currentPage
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.showsHorizontalScrollIndicator = NO;
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTHeadTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTARCodeTVC class]) bundle:nil] forCellReuseIdentifier:@"PTARCodeTVC"];
    }

    return _contentTableView;
}

@end

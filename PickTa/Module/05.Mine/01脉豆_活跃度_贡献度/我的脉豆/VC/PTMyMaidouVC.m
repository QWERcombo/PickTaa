//
//  PTMyMaidouVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyMaidouVC.h"
#import "PTMyMHGHeadTVC.h"
#import "PTMyMHGRowTVC.h"
#import "PTMhgVM.h"
#import "PTMyBeanListModel.h"

@interface PTMyMaidouVC () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) PTMyMHGHeadTVC *headView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, copy) NSString *emptyString;
@property (nonatomic, strong) PTMhgVM *vm;
@property (nonatomic, strong) PTMyBeanListModel *listModel;
@end
@implementation PTMyMaidouVC

#pragma mark - Life Cycle

- (void)dealloc {
}

- (instancetype)init {
    if (self = [super init]) {
        _list = NSMutableArray.new;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];
    [self setupUI];
    [self.contentTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)layoutSubView {
}

- (void)bindViewModel {
    @weakify(self)
    self.vm = [PTMhgVM new];

    [self.vm.myBean.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.contentTableView.mj_header endRefreshing];
        [self.contentTableView.mj_footer endRefreshing];
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            PTMyBeanListModel *model = (PTMyBeanListModel *)x;

            if (self.currentPage == 1) {
                self.listModel = model;
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:model.data];
                
                self.headView.valueLbl11.text = [NSString stringWithFormat:@"%.5f", self.listModel.bean_balance.floatValue];
                self.headView.valueLbl12.text = [NSString stringWithFormat:@"%.5f", self.listModel.bean_today.floatValue];
            } else {
                [self.list addObjectsFromArray:model.data];
            }
            
            self.currentPage++;
            [self.contentTableView reloadData];
        }
    }];
}

#pragma mark - Network Request

//- (void)requestDetailDataWithMessageID:(NSString *)messageID completion:(void (^_Nonnull)(NSString *_Nullable msg, NSError *_Nullable error, ZYGMessageDetailModel *_Nullable model))completion {
//
//}

- (void)requestData {
    self.vm.param1 = @{
        @"limit" : @(kPageDefaultSizeValue),
        kPageIndexKey : @(_currentPage)
    };
    [self.contentTableView.mj_header endRefreshing];
    [self.vm.myBean execute:nil];
}

- (void)refreshData {
    _currentPage = 1;
    [_contentTableView.mj_footer endRefreshing];
    [self requestData];
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = kLocalizedString(@"my_pt", @"我的脉豆");
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
}

- (void)setupUI {
    self.view.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.contentTableView];
}

#pragma mark - Notification

- (void)addNotification {
}

- (void)removeNotification {
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (Array_IsEmpty(self.list)) {
        return 0;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 71;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//    }
//
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     PTMyBeanItemModel *model = self.list[indexPath.row];
    PTMyMHGRowTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyMHGRowTVC"];
    
    cell.titleLbl.text = model.info;
    cell.timeLbl.text = model.created_time;
    cell.valueLbl.text = [NSString stringWithFormat:@"%.5f", model.value.floatValue];
//    cell.mhgIcon.image = ;

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 10;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    WS(weakSelf);
//
//    if (offsetY < 64) {
//        [UIView animateWithDuration:0.5 animations:^{
//            weakSelf.navBgView.backgroundColor = UIColor.clearColor;
//        }];
//    } else {
//        [UIView animateWithDuration:0.5 animations:^{
//            weakSelf.navBgView.backgroundColor = COLOR_THMTE;
//        }];
//    }
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_no_data_icon"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = String_IsEmpty(self.emptyString) ? kLocalizedString(@"no_expenditure_detail", @"暂无收支明细~") : self.emptyString;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName: COLOR_999999};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [_contentTableView.mj_header beginRefreshing];
}

#pragma mark - Action

#pragma mark - Setter Getter

- (PTMyMHGHeadTVC *)headView {
    if (!_headView) {
        NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"PTMyMHGHeadTVC" owner:nil options:nil];
        self.headView = objs[0];
        self.headView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 195);
        self.headView.titleTagView.backgroundColor = COLOR_HEX_RGB(0x42B3B1);
        self.headView.titleLbl.text = kLocalizedString(@"pt_list", @"收支明细");
        self.headView.titleLbl11.textColor = COLOR_HEX_RGB(0x86E5E8);
        self.headView.titleLbl12.textColor = COLOR_HEX_RGB(0x86E5E8);
        self.headView.titleLbl21.textColor = COLOR_HEX_RGB(0x86E5E8);
        self.headView.titleLbl22.textColor = COLOR_HEX_RGB(0x86E5E8);
        self.headView.titleLbl31.textColor = COLOR_HEX_RGB(0x86E5E8);
        self.headView.headBgImgView.image = [UIImage imageNamed:@"mine_maidou_head_bg"];
        
        self.headView.view21.hidden = YES;
        self.headView.view22.hidden = YES;
        self.headView.view31.hidden = YES;
        
        self.headView.valueLbl11.text = @"0";
           self.headView.titleLbl11.text = @"我的脉豆";
           self.headView.valueLbl12.text = @"0";
           self.headView.titleLbl12.text = @"今日所得";
    }

    return _headView;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.headView.bottom - BOTTOM_HEIGHT) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.emptyDataSetSource = self;
        _contentTableView.emptyDataSetDelegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        // _contentTableView.estimatedRowHeight = 0.01;
        _contentTableView.backgroundColor = COLOR_FFFFFF;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _contentTableView.tableFooterView = UIView.new;// currentPage
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTMyMHGRowTVC class]) bundle:nil] forCellReuseIdentifier:@"PTMyMHGRowTVC"];
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _contentTableView.contentInset = UIEdgeInsetsMake(-54, 0, 0, 0);
            _contentTableView.scrollIndicatorInsets = _contentTableView.contentInset;
        }
//        if (@available(iOS 11.0, *)) {
//            // _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
////            if (@available(iOS 13.0, *)) {
////                _contentTableView.automaticallyAdjustsScrollIndicatorInsets = NO;
////            }
//        } else {
//            _contentTableView.contentInset = UIEdgeInsetsMake(-NAV_HEIGHT, 0, 0, 0);
//        }
    }

    return _contentTableView;
}

@end


//
//  PickTaCallVC.m
//  PickTa
//
//  Created by Stark on 2020/6/18.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCallVC.h"
#import "PickTaCallVM.h"
#import "PTCallCell.h"
#import "PickTaHeaderView.h"
#import "PickTaCallDetailVC.h"

@interface PickTaCallVC ()<UITableViewDelegate,UITableViewDataSource,G_MJRefreshProtocol>
@property (nonatomic,strong) PickTaCallVM *callVM;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PickTaHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray<PickTaAdvDiscoverModel*> *listData;
@property (nonatomic, assign) NSInteger page;
@end

@implementation PickTaCallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.listData = [NSMutableArray array];
}

-(void)setupUI{
    self.navigationItem.title = @"为TA打Call";
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain backGroundColor:nil tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
    [self additionRefresh:self.tableView target:self forHeader:YES forFooter:YES];
    
    self.headerView = [PickTaHeaderView createHeaderView];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120*Scale_Width +20);
    self.tableView.tableHeaderView = self.headerView;
}

-(void)createVM{
    self.callVM = [PickTaCallVM new];
}

- (void)bindViewModel{
//    @weakify(self)
//    [self.callVM.advDisCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        self.listData = x;
//        [self.headerView.bannerView sd_setImageWithURL:[NSURL URLWithString:self.listData[0].banner]];
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//    }];
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf requestData];
    }];
    
}

- (void)requestData{
    [PickHttpManager.shared requestPOST:API_AdvDiscover withParam:@{@"page":@(self.page)} withSuccess:^(id  _Nonnull obj) {
        if (self.page == 1) {
            self.page = 1;
            [self.listData removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            self.page += 1;
        }
        if ((10*self.page) < [obj[@"total"] integerValue]) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.listData addObjectsFromArray:[NSArray modelArrayWithClass:[PickTaAdvDiscoverModel class] json:obj[@"data"]]];
        [self.headerView.bannerView sd_setImageWithURL:[NSURL URLWithString:obj[@"banner"]]];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)pullHeaderRefresh{
    [self.callVM.advDisCommand execute:nil];
}

- (void)pushFooterRefresh{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PickTaCallDetailVC *detailVC = [PickTaCallDetailVC new];
    detailVC.model = self.listData[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.listData[indexPath.row].cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTCallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTCallCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTCallViews" owner:nil options:nil].firstObject;
    }
    cell.model = self.listData[indexPath.row];
    @weakify(self);
    [[[cell.inAvdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }];
    return cell;
}

@end

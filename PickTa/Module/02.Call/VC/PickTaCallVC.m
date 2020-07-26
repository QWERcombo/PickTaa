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
@property (nonatomic,strong) NSArray<PickTaAdvDiscoverModel*> *listData;

@end

@implementation PickTaCallVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    @weakify(self)
    [self.callVM.advDisCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.listData = x;
        [self.headerView.bannerView sd_setImageWithURL:[NSURL URLWithString:self.listData[0].banner]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)requestData{
    [self.tableView.mj_header beginRefreshing];
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
    return cell;
}

@end

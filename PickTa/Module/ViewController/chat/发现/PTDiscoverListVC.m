//
//  PTDiscoverListVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDiscoverListVC.h"
#import "PickTaFriendCircleModel.h"
#import "SDTimeLineTableHeaderView.h"
#import "PTDiscoverListCell.h"

@interface PTDiscoverListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) SDTimeLineTableHeaderView *headerView;
@end

@implementation PTDiscoverListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [NSMutableArray array];
    self.page = 1;
}

- (void)setupUI{
    self.navigationItem.title = @"发现";
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setImage:[UIImage imageNamed:@"chat_icon_1"] forState:UIControlStateNormal];
    publishBtn.frame = CGRectMake(0, 0, 40, 40);
    [[publishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[UIViewController initViewControllerFromChatStoryBoardName:@"PTPublishDiscoverVC"] animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    
    self.headerView = [SDTimeLineTableHeaderView new];
    self.headerView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT*0.3);
    PTMyModel *myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:myModel.avatar]];
    self.headerView.nameLabel.text = myModel.nickname;
    self.tableView.tableHeaderView = self.headerView;
    
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

- (void)requestData {
    
    [SVProgressHUD showWithStatus:@"Loading"];
    [PickHttpManager.shared requestGET:API_CircleFriend withParam:@{
        @"type":@"1",
        @"limit":@"10",
        @"page":@(self.page)
    } withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD dismiss];
        PickTaFriendCircleModel *model = [PickTaFriendCircleModel modelWithJSON:obj];
        if (self.page == 1) {
            self.page = 1;
            [self.datas removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            [self.headerView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_photo]];
            
        } else {
            self.page ++;
        }
        if ((10*self.page) < model.count) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.datas addObjectsFromArray:model.data];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTDiscoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTDiscoverListCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PTDiscoverListCell" owner:nil options:nil].firstObject;
    }
    if (self.datas.count) {
        cell.itemModel = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}

@end

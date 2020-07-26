//
//  PTTaskTGBLVC.m
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskTGBLVC.h"
#import "PTMyTGBLHeadTVC.h"
#import "PTMyTGBListCell.h"
#import "PTTaskTGBLVM.h"

@interface PTTaskTGBLVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIImageView *bgImgView; //
@property (nonatomic, strong) PTMyTGBLHeadTVC *myTGBLHeadTVC; //
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *list;

@property (nonatomic, strong) PTTaskTGBLListModel *listModel;
@property (nonatomic, strong) PTTaskTGBLVM *vm;
@end

@implementation PTTaskTGBLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = NSMutableArray.new;
    [self setupNavBar];
    [self setupUI];
    [self.tableView.mj_header beginRefreshing]; // 313
}

- (void)bindViewModel {
    @weakify(self)

    [self.vm.command1.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            PTTaskTGBLListModel *model = (PTTaskTGBLListModel *)x;

            if (self.currentPage == 1) {
                self.listModel = model;
                self.myTGBLHeadTVC.titleLbl11.text = model.friend_num;
                self.myTGBLHeadTVC.titleLbl21.text = model.team_num;
                self.myTGBLHeadTVC.titleLbl31.text = model.active_unit;
                self.myTGBLHeadTVC.titleLbl12.text = model.real_num;
                self.myTGBLHeadTVC.titleLbl22.text = model.union_num;
                self.myTGBLHeadTVC.titleLbl32.text = model.union_dou;
                [self.myTGBLHeadTVC.profileImgView sd_setImageWithURL:[NSURL URLWithString:[NSUserDefaults.standardUserDefaults valueForKey:@"p_avatar"]]];
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:model.data];
            } else {
                [self.list addObjectsFromArray:model.data];
            }

            self.currentPage++;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = kLocalizedString(@"team", @"推广部落");
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.myTGBLHeadTVC];
    self.tableView = [self createTableViewForFrame:CGRectMake(0, self.myTGBLHeadTVC.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.myTGBLHeadTVC.bottom - BOTTOM_HEIGHT) style:UITableViewStylePlain backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTMyTGBListCell class]) bundle:nil] forCellReuseIdentifier:@"PTMyTGBListCell"];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
     _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];

    [self.view addSubview:self.tableView];
}

- (void)createVM {
    self.vm = [PTTaskTGBLVM new];
}

#pragma mark - Network Request

- (void)requestData {
    self.vm.param1 = @{
        @"limit": @(kPageDefaultSizeValue),
        @"order": @"asc", // asc desc
        kPageIndexKey: @(_currentPage)
    };
    [self.tableView.mj_header endRefreshing];
    [self.vm.command1 execute:nil];
}

- (void)refreshData {
    _currentPage = 1;
    [_tableView.mj_footer endRefreshing];
    [self requestData];
}

#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.list.count > 0) {
        return 1;
    }

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTTaskTGBLItemModel *model = self.list[indexPath.row];

    PTMyTGBListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyTGBListCell"];
    cell.lbl1.text = model.nickname;
    cell.lbl2.text = model.team_number;
    cell.lbl4.text = model.level_name;

    if (model.is_auth) {
        cell.lbl3.text = kLocalizedString(@"已认证", @"已认证");
        cell.lbl3.textColor = COLOR_HEX_RGB(0x999999);
    } else {
        cell.lbl3.text = kLocalizedString(@"未认证", @"未认证");
        cell.lbl3.textColor = COLOR_HEX_RGB(0x44BCBA);
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    }

    if (indexPath.section == 1) {
    }
}

#pragma mark - Setter Getter

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 + STATUSBAR_HEIGHT - 20)];
        _bgImgView.image = [UIImage imageNamed:@"tgbl_bg"];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgView.clipsToBounds = YES;
    }

    return _bgImgView;
}

- (PTMyTGBLHeadTVC *)myTGBLHeadTVC {
    if (!_myTGBLHeadTVC) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PTMyTGBLHeadTVC" owner:nil options:nil];
        _myTGBLHeadTVC = [nibContents lastObject];
        _myTGBLHeadTVC.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 313);
        _myTGBLHeadTVC.valueLbl11.text = kLocalizedString(@"friend_num", @"好友人数");
        _myTGBLHeadTVC.valueLbl12.text = kLocalizedString(@"real_friend", @"实名好友");
//        _myTGBLHeadTVC.valueLbl21.text = kLocalizedString(@"", @"");
//        _myTGBLHeadTVC.valueLbl22.text = kLocalizedString(@"", @"");
        _myTGBLHeadTVC.valueLbl31.text = kLocalizedString(@"comm_fans", @"社群粉丝");
        _myTGBLHeadTVC.valueLbl32.text = kLocalizedString(@"colbal_dividend", @"全球分红");
        _myTGBLHeadTVC.titleLbl32.text = [NSString stringWithFormat:@"%@%@", @"0", kLocalizedString(@"", @"")];
        _myTGBLHeadTVC.titleLbl.text = kLocalizedString(@"friend_list", @"好友列表");
        _myTGBLHeadTVC.titleLLbl1.text = kLocalizedString(@"nick_name", @"昵称");
        _myTGBLHeadTVC.titleLLbl2.text = kLocalizedString(@"people_num", @"人数");
        _myTGBLHeadTVC.titleLLbl3.text = kLocalizedString(@"status", @"状态");
        _myTGBLHeadTVC.titleLLbl4.text = kLocalizedString(@"level", @"等级");

//        _myTGBLHeadTVC. = [UIImage imageNamed:@"tgbl_bg"];
//        _myTGBLHeadTVC.contentMode = UIViewContentModeScaleAspectFill;
//        _myTGBLHeadTVC.clipsToBounds = YES;
    }

    return _myTGBLHeadTVC;
}

@end

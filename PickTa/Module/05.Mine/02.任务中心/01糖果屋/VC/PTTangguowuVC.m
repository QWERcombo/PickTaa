//
//  PTTangguowuVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTangguowuVC.h"
#import "PTTgwHeadTVC.h"
#import "PTTgwNumInfoTVC.h"
#import "PTTgwHqjlHeadTVC.h"
#import "PTTgwHqjlRowTVC.h"
#import "PTTgwAlertView.h"
#import "PTTgwVM.h"

@interface PTTangguowuVC () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) PTTgwAlertView *modelView1;
@property (strong, nonatomic) PTTgwAlertView *modelView2;

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *list;

@property (nonatomic, strong) PTTgwVM *vm;
@property (nonatomic, strong) PTTgwListModel *listModel;
@end
@implementation PTTangguowuVC

- (instancetype)init {
    if (self = [super init]) {
        _list = NSMutableArray.new;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    [self setupNavBar];
    [self setupUI];
}

- (void)bindViewModel {
    @weakify(self)
    self.vm = [PTTgwVM new];

    [self.vm.command1.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.contentTableView.mj_header endRefreshing];
        [self.contentTableView.mj_footer endRefreshing];
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            PTTgwListModel *model = (PTTgwListModel *)x;

            if (self.currentPage == 1) {
                self.listModel = model;
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:model.data];
            } else {
                [self.list addObjectsFromArray:model.data];
            }
            
            self.currentPage++;
            [self.contentTableView reloadData];
        }
    }];
    
    [self.vm.command2.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.contentTableView.mj_header endRefreshing];
        [self.contentTableView.mj_footer endRefreshing];
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            [self.view makeToast:(NSString *)x duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
            [self refreshData];
        }
    }];
}

#pragma mark - Network Request

- (void)requestData {
    self.vm.param1 = @{
        @"limit" : @(kPageDefaultSizeValue),
        kPageIndexKey : @(_currentPage)
    };
    [self.contentTableView.mj_header endRefreshing];
    [self.vm.command1 execute:nil];
}

- (void)refreshData {
    _currentPage = 1;
    [_contentTableView.mj_footer endRefreshing];
    [self requestData];
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = kLocalizedString(@"candy_house", @"糖果屋");
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.contentTableView];
}

#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.list.count > 0) {
        return 2;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 1+self.list.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PTTgwHqjlHeadTVC" owner:nil options:nil];
        PTTgwHqjlHeadTVC *view = [nibContents lastObject];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
        view.titleLbl.text = kLocalizedString(@"get_records", @"获取记录");

        return view;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 35;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PTTgwHeadTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTgwHeadTVC"];
            cell.headImageView.image = [UIImage imageNamed:@"tangguowu_icon"];

            return cell;
        } else {
            PTTgwNumInfoTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTgwNumInfoTVC"];
            cell.titleLeftLbl.text = [NSString stringWithFormat:@"%@%@", kLocalizedString(@"wait_candy", @"待领取糖果: "), @""];
            cell.numLbl.text = self.listModel.un_receive;
            [cell.button1 setTitle:kLocalizedString(@"receive", @"领取") forState:UIControlStateNormal];
            [cell.button2 setTitle:kLocalizedString(@"exchange", @"兑换") forState:UIControlStateNormal];

            // 领取
            [[cell.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [self lingquTgw:indexPath];
            }];
            
            // 兑换
            [[cell.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [self duihuanTgw];
            }];

            return cell;
        }
    } else {
        PTTgwHqjlRowTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTgwHqjlRowTVC"];

        if (indexPath.row == 0) {
            cell.button1.hidden = YES;
            cell.lbl3.hidden = NO;
            cell.bgView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:248 / 255.0 blue:250 / 255.0 alpha:1.0];
            cell.lblBgView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:248 / 255.0 blue:250 / 255.0 alpha:1.0];
            cell.lbl1.textColor = COLOR_HEX_RGB(0x999999);
            cell.lbl2.textColor = COLOR_HEX_RGB(0x999999);
            cell.lbl3.textColor = COLOR_HEX_RGB(0x999999);
            cell.lbl1.text = kLocalizedString(@"time", @"时间");
            cell.lbl2.text = kLocalizedString(@"get_quantity", @"获取数量");
            cell.lbl3.text = kLocalizedString(@"status", @"状态");
        } else {
            PTTgwItemModel *itemModel = self.list[indexPath.row - 1];
            
            cell.bgView.backgroundColor = UIColor.whiteColor;
            cell.lblBgView.backgroundColor = UIColor.whiteColor;
            cell.lbl1.textColor = COLOR_HEX_RGB(0x333333);
            cell.lbl2.textColor = COLOR_HEX_RGB(0x333333);
            cell.lbl3.textColor = COLOR_HEX_RGB(0x333333);
            cell.lbl1.text = itemModel.create_time;
            cell.lbl2.text = [NSString stringWithFormat:@"%@%@", itemModel.number, kLocalizedString(@"张", @"张")];
            cell.lbl3.text = itemModel.status_name;
            
            if ([itemModel.status isEqualToString:@"1"]) {
               cell.button1.hidden = NO;
               cell.lbl3.hidden = YES;
               [cell.button1 setTitle:kLocalizedString(@"receive", @"领取") forState:UIControlStateNormal];
            } else {
                cell.button1.hidden = YES;
                cell.lbl3.hidden = NO;
            }
                           
//            // 0 未领取 1已领取 2兑换 3过期
//            if ([itemModel.status isEqualToString:@"0"]) {
//                cell.button1.hidden = NO;
//                cell.lbl3.hidden = YES;
//                [cell.button1 setTitle:kLocalizedString(@"receive", @"领取") forState:UIControlStateNormal];
//            } else if ([itemModel.status isEqualToString:@"1"]) {
//                cell.button1.hidden = YES;
//                cell.lbl3.hidden = NO;
//                cell.lbl3.text = kLocalizedString(@"received", @"已领取");
//            } else if ([itemModel.status isEqualToString:@"2"]) {
//                cell.button1.hidden = YES;
//                cell.lbl3.hidden = NO;
//                cell.lbl3.text = kLocalizedString(@"exchange", @"已兑换");
//            } else if ([itemModel.status isEqualToString:@"3"]) {
//                cell.button1.hidden = YES;
//                cell.lbl3.hidden = NO;
//                cell.lbl3.text = kLocalizedString(@"expired", @"已过期");
//            }

            // 领取
            [[cell.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [self lingquTgw:indexPath];
            }];
        }

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    }

    if (indexPath.section == 1) {
    }
}

#pragma makr - Help

// 领券
- (void)lingquTgw:(NSIndexPath *)indexPath {
    PTTgwItemModel *itemModel = self.list[indexPath.row - 1];
    self.vm.param2 = @{
        @"id" : @(itemModel.id),
    };
    [self.vm.command2 execute:nil];
//    @weakify(self)
//
//    if (_modelView1 == nil) {
//        _modelView1 = [PTTgwAlertView createViewFromNib];
//
//        if ((SCREEN_WIDTH - 60.f*2) > 238) {
//            _modelView1.btViewWidthContraint.constant = SCREEN_WIDTH - 60.f*2;
//        }
//
//        [_modelView1.btn1 setTitle:@"复制" forState:UIControlStateNormal];
//        _modelView1.inputTfl.hidden = YES;
//    }
//
//    [_modelView1 showInController:self preferredStyle:TYAlertControllerStyleAlert backgoundTapDismissEnable:YES];
//
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:_modelView1 preferredStyle:TYAlertControllerStyleActionSheet];
//    alertController.backgoundTapDismissEnable = YES;
//
//    [[_modelView1.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        // pasteboard.string = model.inviter_code;
//        [self.view makeToast:@"兑换码复制成功" duration:1.0f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
//        [self.modelView1 hideInController];
//    }];
}

// 兑换
- (void)duihuanTgw {
    @weakify(self)

    if (_modelView2 == nil) {
        _modelView2 = [PTTgwAlertView createViewFromNib];
        [_modelView2.btn1 setTitle:@"确定" forState:UIControlStateNormal];
        _modelView2.tgqNumLbl.hidden = YES;
        _modelView2.codeLbl.hidden = YES;
        _modelView2.tipCopyLbl.hidden = YES;
    }
    
    [_modelView2 showInController:self preferredStyle:TYAlertControllerStyleAlert backgoundTapDismissEnable:YES];

    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:_modelView2 preferredStyle:TYAlertControllerStyleActionSheet];
    alertController.backgoundTapDismissEnable = YES;

    [[_modelView2.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.modelView2 hideInController];

    }];
}

#pragma mark - Setter Getter

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated"
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
         #pragma clang diagnostic pop
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        // _contentTableView.emptyDataSetSource = self;
        // _contentTableView.emptyDataSetDelegate = self;
        _contentTableView.backgroundColor = UIColor.whiteColor;//COLOR_F2F5F5;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _contentTableView.tableHeaderView = UIView.new;
        _contentTableView.tableFooterView = UIView.new;// currentPage
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.showsHorizontalScrollIndicator = NO;
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwHeadTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwNumInfoTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwNumInfoTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwHqjlHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwHqjlHeadTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwHqjlRowTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwHqjlRowTVC"];
    }

    return _contentTableView;
}

@end

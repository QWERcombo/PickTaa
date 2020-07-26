//
//  PTTaskJZZXVC.m
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskJZJSVC.h"
#import "PTTaskJZJSCell.h"
#import "PTTaskJZJSVM.h"

@interface PTTaskJZJSVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSMutableArray *list;
@property (nonatomic, strong) PTTaskJZJSListModel *listModel;
@property (nonatomic, strong) PTTaskJZJSVM *vm;
@end

@implementation PTTaskJZJSVC

- (instancetype)init {
    if (self = [super init]) {
        _list = NSMutableArray.new;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
}

- (void)bindViewModel {
    @weakify(self)
    self.vm = [PTTaskJZJSVM new];

    [self.vm.command1.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            PTTaskJZJSListModel *model = (PTTaskJZJSListModel *)x;

            if (self.currentPage == 1) {
                self.listModel = model;
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

#pragma mark - Network Request

- (void)requestData {
    self.vm.param1 = @{
        @"limit" : @(kPageDefaultSizeValue),
        kPageIndexKey : @(_currentPage)
    };
    [self.tableView.mj_header endRefreshing];
    [self.vm.command1 execute:nil];
}

- (void)refreshData {
    _currentPage = 1;
    [_tableView.mj_footer endRefreshing];
    [self requestData];
}

- (void)setupUI {
    self.title = kLocalizedString(@"store", @"卷轴集市");
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain backGroundColor:ChatLineColor tableViewDelegate:self tableViewDataSource:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
}

#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.list.count > 0) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTTaskJZJSItemModel *model = self.list[indexPath.row];
    PTTaskJZJSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTaskJZJSCell"];
    
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTTaskCell" owner:nil options:nil][1];
        @weakify(self)
        [[cell.jZDHBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.listModel.is_dui && (indexPath.row == 0)) {
                return;
            }
              [SVProgressHUD showImage:[UIImage imageNamed:PlaceHolder_Logo] status:@"兑换中"];
              [[PickHttpManager shared]requestPOST:API_TaskJZDH withParam:@{@"id":@(model.id)} withSuccess:^(id  _Nonnull obj) {
                  [SVProgressHUD showImage:obj status:obj];
                  [SVProgressHUD dismissWithDelay:0.5];
              } withFailure:^(NSError * _Nonnull err) {
                  
              }];
          }];
    }
    
    [cell.jzxq setTitle:kLocalizedString(@"task_detail", @"卷轴详情") forState:UIControlStateNormal];
    cell.jzTJ.text = kLocalizedString(@"redemption_conditions", @"兑换条件");
    cell.wcsy.text = kLocalizedString(@"comletion_gain", @"成收益");
    cell.jzjsName.text = model.name;
    cell.jzCount.text = model.condition;
    cell.jzSY.text = [NSString stringWithFormat:@"%@脉豆+%@活跃度", model.bean, model.activation];
    cell.model = model;
    
    if (indexPath.row == 0) {
        if (self.listModel.is_dui) {
            cell.jZDHBtn.backgroundColor = COLOR_HEX_RGB(0xC7C7CC);
            [cell.jZDHBtn setTitle:kLocalizedString(@"received", @"已领取") forState:UIControlStateNormal];
        } else {
            cell.jZDHBtn.backgroundColor = COLOR_HEX_RGB(0x44BCBA);
            [cell.jZDHBtn setTitle:kLocalizedString(@"receive", @"领取") forState:UIControlStateNormal];
        }
    } else {
        [cell.jZDHBtn setTitle:kLocalizedString(@"exchange", @"兑换") forState:UIControlStateNormal];
    }
    //    cell.jzjsName.text = model.name;
//    cell.jzjsName.text = model.name;

//    ///卷轴名称
//    @property (weak, nonatomic) IBOutlet UILabel *jzjsName;
//    ///卷轴个数
//    @property (weak, nonatomic) IBOutlet UILabel *jzCount;
//    ///卷轴条件
//    @property (weak, nonatomic) IBOutlet UILabel *jzTJ;
//    ///卷轴兑换
//    @property (weak, nonatomic) IBOutlet UIButton *jZDHBtn;
//    ///卷轴详情
//    @property (weak, nonatomic) IBOutlet UIButton *jzxq;
//    ///卷轴收益
//    @property (weak, nonatomic) IBOutlet UILabel *jzSY;
//    ///完成收益
//    @property (weak, nonatomic) IBOutlet UILabel *wcsy;
    
    return cell;
}

@end

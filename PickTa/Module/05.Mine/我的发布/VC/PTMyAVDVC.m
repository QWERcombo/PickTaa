//
//  PTMyAVDVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyAVDVC.h"
#import "PTTgwHeadTVC.h"
#import "PTTgwNumInfoTVC.h"
#import "PTTgwHqjlHeadTVC.h"
#import "PTMyAVDTVC.h"
#import "PickTaMyAdModel.h"

@interface PTMyAVDVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PTMyAVDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    [self setupNavBar];
    [self setupUI];
    [self refreshData];
}

#pragma mark - Network Request

- (void)reloadListView {
}

- (void)refreshData {
    
    [[PickHttpManager shared] requestPOST:API_AdvertMyPublish withParam:@{} withSuccess:^(id  _Nonnull obj) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:[NSArray modelArrayWithClass:[PickTaMyAdModel class] json:obj[@"data"]]];
        [self.contentTableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showWithStatus:err.domain];
    }];
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = kLocalizedString(@"my_ad", @"我的广告");
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.contentTableView];
}

#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return self.dataArray.count;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1 && Array_IsEmpty(self.adDataSource)) {
//        return 20;
//    }
//
//    return 0;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PTTgwHqjlHeadTVC" owner:nil options:nil];
        PTTgwHqjlHeadTVC *view = [nibContents lastObject];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
        view.titleLbl.text = @"广告列表";
        
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PTTgwHeadTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTgwHeadTVC"];
            cell.headImageView.image = [UIImage imageNamed:@"myfabu_icon"];

            return cell;
        } else {
            PTTgwNumInfoTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTgwNumInfoTVC"];
            cell.contentView.backgroundColor = UIColor.whiteColor;
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.titleLeftLbl.text = @"获得打Call次数：";
            cell.numLbl.text = @"100";
            cell.titleRightLbl.hidden = NO;
            cell.valueRightLbl.hidden = NO;
            cell.titleRightLbl.text = @"获得打赏：";
            cell.valueRightLbl.text = [NSString stringWithFormat:@"%@脉豆", @"10"];

            return cell;
        }
    } else {
        PTMyAVDTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyAVDTVC"];
        cell.adModel = [self.dataArray objectAtIndex:indexPath.row];
//        cell.titleLbl.text = @"";
//        cell.startLbl.text = @"";
//        cell.endLbl.text = @"";
//        cell.heartNumLbl.text = @"";
//        cell.beanNumLbl.text = @"";
        
        if (indexPath.row == 0) { //
            [cell.btn1 setTitle:@"待审核" forState:UIControlStateNormal];
            cell.btn1.titleLabel.textColor = COLOR_HEX_RGB(0xffffff);
            cell.btn1.backgroundColor = COLOR_HEX_RGB(0xFF4747);
            cell.heartNumLbl.hidden = YES;
            cell.beanNumLbl.hidden = YES;
            cell.heartIcon.hidden = YES;
            cell.beanIcon.hidden = YES;
        } else if (indexPath.row == 1) {
            [cell.btn1 setTitle:@"显示中" forState:UIControlStateNormal];
            cell.btn1.titleLabel.textColor = COLOR_HEX_RGB(0xffffff);
            cell.btn1.backgroundColor = COLOR_HEX_RGB(0x42B3B1);
            cell.heartNumLbl.hidden = NO;
            cell.beanNumLbl.hidden = NO;
            cell.heartIcon.hidden = NO;
            cell.beanIcon.hidden = NO;
        } else if (indexPath.row == 2) {
            [cell.btn1 setTitle:@"已结束" forState:UIControlStateNormal];
            cell.btn1.titleLabel.textColor = COLOR_HEX_RGB(0x999999);
            cell.btn1.backgroundColor = COLOR_HEX_RGB(0xF7F7F7);
            cell.heartNumLbl.hidden = NO;
            cell.beanNumLbl.hidden = NO;
            cell.heartIcon.hidden = NO;
            cell.beanIcon.hidden = NO;
        }
        
        @weakify(self)
        [[cell.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            // @strongify(self)
           
            
        }];

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
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
         #pragma clang diagnostic pop
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        // _contentTableView.emptyDataSetSource = self;
        // _contentTableView.emptyDataSetDelegate = self;
        _contentTableView.backgroundColor = COLOR_F7F8FA;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//        _contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _contentTableView.tableHeaderView = UIView.new;
        _contentTableView.tableFooterView = UIView.new;// currentPage
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.showsHorizontalScrollIndicator = NO;
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwHeadTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwNumInfoTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwNumInfoTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTgwHqjlHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTTgwHqjlHeadTVC"];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTMyAVDTVC class]) bundle:nil] forCellReuseIdentifier:@"PTMyAVDTVC"];
    }

    return _contentTableView;
}

@end


//
//  PickTaCallDetailVC.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCallDetailVC.h"
#import "PTDetailCell.h"
#import "PTTangguowuVC.h"
#import "PickTaCallRewardVC.h"

@interface PickTaCallDetailVC ()<UITableViewDelegate,UITableViewDataSource,G_MJRefreshProtocol,PTDetailCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *p_quanBtn;
@property (nonatomic, strong) UIButton *p_shangBtn;
@end

@implementation PickTaCallDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    self.navigationItem.title = @"广告详情";
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain backGroundColor:nil tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
    
    self.p_quanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.p_quanBtn.backgroundColor = COLOR_HEX_RGB(0xE8E8E8);
    self.p_quanBtn.layer.cornerRadius = 6;
    self.p_quanBtn.layer.masksToBounds = YES;
    [self.p_quanBtn setTitle:@"领券" forState:UIControlStateNormal];
    self.p_quanBtn.enabled = NO;
    self.p_quanBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    [self.view addSubview:self.p_quanBtn];
    [self.p_quanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-3-HOME_INDICATOR_HEIGHT);
        make.height.mas_offset(44);
    }];
    @weakify(self);
    [[self.p_quanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [[PickHttpManager shared]requestPOST:API_AdvertCollectCouponsNew withParam:@{@"id":@(self.model.id)} withSuccess:^(id  _Nonnull obj) {
            [self alertSureCancle:@"提示" andSubTitle:@"领取成功，请前往糖果屋" sureTitle:@"确定" cancleTitle:@"取消" sureCallBack:^{
                PTTangguowuVC *vc = [PTTangguowuVC new];
                [self.navigationController pushViewController:vc animated:YES];
            } cancleCallBack:^{
                
            }];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    self.p_shangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.p_shangBtn.backgroundColor = COLOR_HEX_RGB(0x44BCBA);
    self.p_shangBtn.layer.cornerRadius = 6;
    [self.p_shangBtn setTitle:@"打赏" forState:UIControlStateNormal];
    self.p_shangBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    self.p_shangBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.p_shangBtn];
    [self.p_shangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.p_quanBtn.mas_right).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-3-HOME_INDICATOR_HEIGHT);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.width.height.equalTo(self.p_quanBtn);
    }];
    [[self.p_shangBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        PickTaCallRewardVC *reward = [[PickTaCallRewardVC alloc] initWithNibName:@"PickTaCallRewardVC" bundle:nil];
        reward.model = self.model;
        [self.navigationController pushViewController:reward animated:YES];
    }];
    
}

- (void)bindViewModel{
    
}

- (void)requestData{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTDetailCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTCallViews" owner:nil options:nil][2];
    }
    cell.model = self.model;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (void)avaliableToClickQuan {
    self.p_quanBtn.backgroundColor = COLOR_HEX_RGB(0xFF4747);
    self.p_quanBtn.enabled = YES;
}
@end

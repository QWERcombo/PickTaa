//
//  PickTaMyVC.m
//  PickTa
//
//  Created by Stark on 2020/6/18.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaMyVC.h"
#import "PTMyVM.h"
#import "PTMyAVDVC.h"
#import "PTMyMaidouVC.h"
#import "PTMyGongXianZhiVC.h"
#import "PTMyHuoYueDuVC.h"
#import "PCMinePublishAdVC.h"
#import "PTMineAuthInfoVC.h"

@interface PickTaMyVC ()
@property (nonatomic, strong) UIButton *rightNavBarButton;

@property (nonatomic,strong) PTMyVM *myVM;
@property (nonatomic,strong) PTMyModel *myModel;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *ptID;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *activityValue;
@property (weak, nonatomic) IBOutlet UIView *taskCenter;
@property (weak, nonatomic) IBOutlet UIView *inviteFriend;
@property (weak, nonatomic) IBOutlet UIView *myAVD;
@property (weak, nonatomic) IBOutlet UIView *publishAVD;
@property (weak, nonatomic) IBOutlet UIButton *myAVDBtn;
@property (weak, nonatomic) IBOutlet UIView *levelView;

@property (weak, nonatomic) IBOutlet UIButton *btn1;// 我的脉豆
@property (weak, nonatomic) IBOutlet UILabel *titleBeen; // 脉豆标题
@property (weak, nonatomic) IBOutlet UILabel *beenValue; // 脉豆值
@property (weak, nonatomic) IBOutlet UIButton *btn2;// 贡献值
@property (weak, nonatomic) IBOutlet UILabel *titleGx; // 贡献标题
@property (weak, nonatomic) IBOutlet UILabel *gxValue; // 贡献值
@property (weak, nonatomic) IBOutlet UIButton *btn3;// 活跃度
@property (weak, nonatomic) IBOutlet UILabel *activityTitle;// 活跃度title

@property (weak, nonatomic) IBOutlet UILabel *rwzxTitleLbl;// 任务中心
@property (weak, nonatomic) IBOutlet UILabel *yqhyTitleLbl;// 邀请好友
@property (weak, nonatomic) IBOutlet UILabel *wdggTitleLbl;// 我的广告
@property (weak, nonatomic) IBOutlet UILabel *fbggTitleLbl;// 发布广告

@property (weak, nonatomic) IBOutlet UILabel *ziliaoTitleLbl; //
@property (weak, nonatomic) IBOutlet UILabel *renzhengTitleLbl; //
@property (weak, nonatomic) IBOutlet UILabel *wentiTitleLbl; //
@property (weak, nonatomic) IBOutlet UILabel *aboutTitleLbl; //
@property (weak, nonatomic) IBOutlet UILabel *settingTitleLbl; //
@property (weak, nonatomic) IBOutlet UILabel *logoutTitleLbl; //
@end

@implementation PickTaMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityTitle.layer.masksToBounds = YES;
    self.beenValue.layer.masksToBounds = YES;
    self.titleGx.layer.masksToBounds = YES;

    // Do any additional setup after loading the view.
    [self setupUI];
    [self bindViewModel];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
     [self changeLanguage];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kAliPayResponseNoti" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if ([x.object integerValue] == 9000) {
            [self requestData];
        }
    }];
}

- (void)changeLanguage {
    [_rightNavBarButton setTitle:kLocalizedString(@"chanage_laguage", @"语言切换 ") forState:UIControlStateNormal];
//    self.title = kLocalizedString(@"my", @"我的");
    self.beenValue.text = kLocalizedString(@"maidou", @"脉豆");
    self.titleGx.text = kLocalizedString(@"contribution", @"贡献值");
    self.activityTitle.text = kLocalizedString(@"active_level", @"活跃度");

    self.rwzxTitleLbl.text = kLocalizedString(@"task_center", @"任务中心");
    self.yqhyTitleLbl.text = kLocalizedString(@"invite_friends", @"邀请好友");
    self.wdggTitleLbl.text = kLocalizedString(@"my_ad", @"我的广告");
    self.fbggTitleLbl.text = kLocalizedString(@"publish_ad", @"发布广告");
    
    self.ziliaoTitleLbl.text = kLocalizedString(@"information", @"我的资料");
    self.renzhengTitleLbl.text = kLocalizedString(@"auth", @"实名认证");
    self.wentiTitleLbl.text = kLocalizedString(@"problem", @"常见问题");
    self.aboutTitleLbl.text = kLocalizedString(@"about", @"关于我们");
    self.settingTitleLbl.text = kLocalizedString(@"set", @"安全设置");
    self.logoutTitleLbl.text = kLocalizedString(@"logout", @"退出登录");
    
//    self.gxValue.text = @"";
}

- (void)right_click:(UIButton *)button {
    if ([[kLanguageManager currentLanguage] isEqualToString:@"en-CN"]) {
        [kLanguageManager setUserlanguage:@""];
        [_rightNavBarButton wbc_changeTitleLeftWithPadding:8];
    }
    
    if ([[kLanguageManager currentLanguage] isEqualToString:@"zh-Hans-CN"]) {
        [kLanguageManager setUserlanguage:@"en-CN"];
        [_rightNavBarButton wbc_changeTitleLeftWithPadding:2];
    }

    [_rightNavBarButton layoutIfNeeded];
    [_rightNavBarButton layoutSubviews];
}

-(void)setupUI{
    @weakify(self);
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"home_bg"];
//    [self.view addSubview:imageView];
    
    self.navigationItem.title = @"我的";
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.levelView.layer.cornerRadius = 14;
    self.levelView.layer.borderWidth = 1;
    self.levelView.layer.borderColor = COLOR_HEX_RGB(0xFFCB6E).CGColor;
    _rightNavBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightNavBarButton setImage:[UIImage imageNamed:@"language_swicth"] forState:UIControlStateNormal];
    [_rightNavBarButton setTitle:kLocalizedString(@"chanage_laguage", @"语言切换 ") forState:UIControlStateNormal];
    _rightNavBarButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
    // _rightNavBarButton.hitTestEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -15);
    [_rightNavBarButton wbc_changeTitleLeftWithPadding:8];
    [_rightNavBarButton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_rightNavBarButton];
    self.navigationItem.rightBarButtonItem = item;
    
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.backgroundView = imageView;
    self.tableView.tableFooterView = [UIView new];
    self.icon.layer.cornerRadius = 30;
    self.icon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.icon.layer.borderWidth = 2;
    UITapGestureRecognizer *tapGesture_task = [[UITapGestureRecognizer alloc]init];
    [[tapGesture_task rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//        [SVProgressHUD showImage:nil status:@"任务中心"];
//        [SVProgressHUD dismissWithDelay:1];
    }];
    [self.taskCenter addGestureRecognizer:tapGesture_task];
    
    UITapGestureRecognizer *tapGesture_invite = [[UITapGestureRecognizer alloc]init];
    [[tapGesture_invite rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//        [SVProgressHUD showImage:nil status:@"邀请好友"];
//        [SVProgressHUD dismissWithDelay:1];
    }];
    [self.inviteFriend addGestureRecognizer:tapGesture_invite];
    
    UITapGestureRecognizer *tapGesture_avd = [[UITapGestureRecognizer alloc]init];
    [[tapGesture_avd rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//        [SVProgressHUD showImage:nil status:@"我的广告"];
//        [SVProgressHUD dismissWithDelay:1];
    }];
    [self.myAVD addGestureRecognizer:tapGesture_avd];
    
    // 发布广告
    UITapGestureRecognizer *tapGesture_publishAVD = [[UITapGestureRecognizer alloc]init];
    [[tapGesture_publishAVD rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        PCMinePublishAdVC *vc = [[PCMinePublishAdVC alloc] initWithNibName:@"PCMinePublishAdVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.publishAVD addGestureRecognizer:tapGesture_publishAVD];
    
    [[self.myAVDBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self)
        PTMyAVDVC *vc = [PTMyAVDVC new];
          [self.navigationController pushViewController:vc animated:YES];
      }];
    
    // 我的麦豆
    [[self.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self)
        PTMyMaidouVC *vc = [PTMyMaidouVC new];
          [self.navigationController pushViewController:vc animated:YES];
      }];
    
    // 我的贡献值
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self)
        PTMyGongXianZhiVC *vc = [PTMyGongXianZhiVC new];
          [self.navigationController pushViewController:vc animated:YES];
      }];
    
    // 我的活跃度
    [[self.btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self)
        PTMyHuoYueDuVC *vc = [PTMyHuoYueDuVC new];
          [self.navigationController pushViewController:vc animated:YES];
      }];
}

-(void)bindViewModel{
    @weakify(self)
    self.myVM = [PTMyVM new];
    [self.myVM.myCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.myModel = x;
        RAC(self.nickName,text) = RACObserve(self.myModel,nickname);
        RAC(self.phone,text) = RACObserve(self.myModel, phone);
        self.ptID.text = [NSString stringWithFormat:@"ID:%ld",self.myModel.my_id];
        self.level.text = [NSString stringWithFormat:@"LV%ld",(long)self.myModel.user_level];
        if(String_IsEmpty(self.myModel.avatar)){
            [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.head_portrait]];
        }else{
            [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.avatar]];
            [[NSUserDefaults standardUserDefaults] setValue:self.myModel.avatar forKey:@"p_avatar"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
//        self.beenValue.text = self.myModel.cdn_balance;
        self.beenValue.text = @"脉豆";
//        self.activityTitle.text = [NSString stringWithFormat:@"%@:%@", kLocalizedString(@"active_level", @"活跃度"), self.myModel.active_weight];
    }];
}

-(void)requestData{
    [self.myVM.myCommand execute:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 5){
        [self alertSureCancle:@"退出登录" andSubTitle:@"确定退出吗？" sureTitle:@"确定" cancleTitle:@"取消" sureCallBack:^{
            [PickTaUserDefaults g_cleanToken];
            [[NSNotificationCenter defaultCenter]postNotificationName:OutLogin object:nil];
        } cancleCallBack:^{
            
        }];
    }
    if (indexPath.row == 1) {
        // 1认证 2提交 3拒绝
        if (self.myModel.is_auth == 0) {
            PTIDAnthVC *secondVC = (PTIDAnthVC *)[[UIStoryboard storyboardWithName:@"MyViews" bundle:nil] instantiateViewControllerWithIdentifier:@"PTIDAnthVC"];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
        else if (self.myModel.is_auth == 1 || self.myModel.is_auth == 2) {
            PTMineAuthInfoVC *authVC = [[PTMineAuthInfoVC alloc] initWithNibName:@"PTMineAuthInfoVC" bundle:nil];
            authVC.myModel = self.myModel;
            [self.navigationController pushViewController:authVC animated:YES];
        } else {
            PTIDAnthVC *secondVC = (PTIDAnthVC *)[[UIStoryboard storyboardWithName:@"MyViews" bundle:nil] instantiateViewControllerWithIdentifier:@"PTIDAnthVC"];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"scrollView: %.2f",offsetY);
    if(-offsetY >= NAVIGATION_BAR_HEIGHT){
        [self wr_setNavBarBarTintColor:[UIColor clearColor]];
        [self wr_setNavBarTitleColor:[UIColor blackColor]];
    }else{
        [self wr_setNavBarBarTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
        [self wr_setNavBarTitleColor:[UIColor blackColor]];
    }
}
@end

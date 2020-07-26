//
//  PickTaRegisterVC.m
//  PickTa
//
//  Created by sgq on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaRegisterVC.h"
#import "PickTaRegosterVM.h"
#import "PTRegister2VC.h"
#import "RegisterDealVC.h"

@interface PickTaRegisterVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PickTaRegosterVM *RegosterVM;
@property (nonatomic, strong) NSString *is_ch;
@end
@implementation PickTaRegisterVC

- (void)changeLanguage {
    //    dispatch_main_async_safe(^{
    self.descriptionLab.text = kLocalizedString(@"Rigster", @"手机号注册");
    self.phoneLab.text = kLocalizedString(@"phone_num", @"手机号");
    self.phoneTxt.placeholder = kLocalizedString(@"please_input_mobile", @"请填写手机号");
    self.codeLab.text = kLocalizedString(@"captcha", @"验证码");
    self.codeTxt.placeholder = kLocalizedString(@"please_input_code", @"请填写验证码");
    [self.obtainCodeBtn setTitle:kLocalizedString(@"get_ver_code", @"获取验证码") forState:UIControlStateNormal];
    self.passLab.text = kLocalizedString(@"pass", @"登录密码");
    self.passTxt.placeholder = kLocalizedString(@"enter_pass", @"请填写登陆密码");
    self.passAgainLab.text = kLocalizedString(@"confirm_pass", @"确认登录密码");
    self.passAgainTxt.placeholder = kLocalizedString(@"enter_pass", @"请再次填写登陆密码");
    self.transacLab.text = kLocalizedString(@"pay_pass", @"交易密码");
    self.transacTxt.placeholder = kLocalizedString(@"in_new_pay", @"请输入6位新交易密码");
    self.transacAgainLab.text = kLocalizedString(@"confirm_in_new_pay", @"确认交易密码");
    self.transacAgainTxt.placeholder = kLocalizedString(@"agegin_new_pay", @"请再次填写交易密码");
    self.invitationLab.text = kLocalizedString(@"invite_code1", @"邀请码");
    self.invitationTxt.placeholder = kLocalizedString(@"input_invite_code", @"请填写邀请码");
    self.welabel.text = kLocalizedString(@"yiyuedubingtongyi", @"已阅读并同意");
    [self.jumpBtn setTitle:kLocalizedString(@"pick_ta_server_protocol", @"《PICK TA及服务协议》") forState:UIControlStateNormal];
    [self.completeBtn setTitle:kLocalizedString(@"Rigster", @"注册") forState:UIControlStateNormal];
    self.longinLab.text = kLocalizedString(@"yiyouzhanghao", @"已有账号，");
    [self.loginBtn setTitle:kLocalizedString(@"lijidenglu", @"立即登陆") forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    //    });
}

- (void)setupRegisterUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarShadowImageHidden:YES];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    self.view.frame = CGRectMake(0, 0, w, h);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closebtn1) name:RegosterSuccess object:nil];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    self.scrollView.delegate = self;
    
    if (!(h > 800)) {
        self.scrollView.contentSize = CGSizeMake(w, h + 110 + 150);//667 736 812
    } else {
        self.scrollView.contentSize = CGSizeMake(w, h); //667 736 812
    }
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    CGFloat titleLblWidth = 120.f;
    CGFloat leftRightPadding = 16.f;
    CGFloat sepViewHeight = 0.5f;
    UIColor *sepViewColor = COLOR_DDDDDD;
    
    //关闭按钮
    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 40, 17, 17)];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"关  闭"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closebtn) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn.hidden = YES;
    //背景图片
    self.imageBr = [[UIImageView alloc] initWithFrame:CGRectMake(136, 99, 103, 100)];
    self.imageBr.image = [UIImage imageNamed:@"login_logo"];
    
    //文字说明
    self.descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(leftRightPadding, 259, 200, 26)];
    self.descriptionLab.text = @"手机号注册";
    self.descriptionLab.font = [UIFont systemFontOfSize:27];
    self.descriptionLab.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    //说明手机号
    self.phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 330, titleLblWidth, 15)];
    self.phoneLab.text = @"手机号";
    self.phoneLab.font = [UIFont systemFontOfSize:16];
    self.phoneLab.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    //输入手机号text
    self.phoneTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 318.5, w - 98, 40)];
    self.phoneTxt.placeholder = @"请填写手机号";
    self.phoneTxt.font = [UIFont systemFontOfSize:14];
    UIView *phoneView = [UIView new];
    phoneView.frame = CGRectMake(leftRightPadding, 360, w - 2*leftRightPadding, sepViewHeight);
    phoneView.backgroundColor = sepViewColor;
    
    //12 11.5  29
    self.codeLab = [[UILabel alloc]initWithFrame:CGRectMake(28, 372+15, titleLblWidth, 15)];
    self.codeLab.text = @"验证码";
    self.codeLab.font = [UIFont systemFontOfSize:16];
    self.codeLab.textColor = CompleteLAB;
    self.codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150, 360.5+15, w - 270, 40)];
    self.codeTxt.placeholder = @"请填写验证码";
    self.codeTxt.font = [UIFont systemFontOfSize:14];
    self.obtainCodeBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(250, 369.5+15, 100, 20)];
    [self.obtainCodeBtn addTarget:self action:@selector(obtainCodebtn) forControlEvents:UIControlEventTouchUpInside];
    [self.obtainCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.obtainCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    //设置文字颜色
    [self.obtainCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.obtainCodeBtn.layer.backgroundColor = CompleteBTN.CGColor;
    self.obtainCodeBtn.layer.cornerRadius = 3;
    UIView *codeView = [UIView new];
    codeView.frame = CGRectMake(16, 401+15, w - 32, sepViewHeight);
    codeView.backgroundColor = sepViewColor;
    
    //密码
    self.passLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 413+30, titleLblWidth, 15)];
    self.passLab.text = @"登录密码";
    self.passLab.font = [UIFont systemFontOfSize:16];
    self.passLab.textColor = CompleteLAB;
    self.passTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 401.5+30, w - 270, 40)];
    self.passTxt.placeholder = @"请填写登陆密码";
    self.passTxt.font = [UIFont systemFontOfSize:14];
    UIView *passView = [UIView new];
    passView.frame = CGRectMake(16, 443+30, w - 32, 0.5);
    passView.backgroundColor = sepViewColor;
    
    self.passAgainLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 455+45, titleLblWidth, 15)];
    self.passAgainLab.text = @"确认登录密码";
    self.passAgainLab.font = [UIFont systemFontOfSize:16];
    self.passAgainLab.textColor = CompleteLAB;
    self.passAgainTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 443.5+45, w - 190, 40)];
    self.passAgainTxt.placeholder = @"请再次填写登陆密码";
    self.passAgainTxt.font = [UIFont systemFontOfSize:14];
    UIView *passAgainView = [UIView new];
    passAgainView.frame = CGRectMake(16, 484+45, w - 32, sepViewHeight);
    passAgainView.backgroundColor = sepViewColor;
    
    //交易密码
    self.transacLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 484 + 12 + 60, titleLblWidth, 15)];
    self.transacLab.text = @"交易密码";
    self.transacLab.font = [UIFont systemFontOfSize:16];
    self.transacLab.textColor = CompleteLAB;
    self.transacTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 484 + 12 - 11.5 + 60, w - 270, 40)];
    self.transacTxt.placeholder = @"请填写交易密码";
    self.transacTxt.font = [UIFont systemFontOfSize:14];
    UIView *ransacView = [UIView new];
    ransacView.frame = CGRectMake(16, 484 + 12 + 29 + 60, w - 32, 0.5);
    ransacView.backgroundColor = sepViewColor;
    
    self.transacAgainLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 484 + 12 + 12 + 29 + 75, titleLblWidth, 15)];
    self.transacAgainLab.text = @"确认交易密码";
    self.transacAgainLab.font = [UIFont systemFontOfSize:16];
    self.transacAgainLab.textColor = CompleteLAB;
    self.transacAgainTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 484 + 12 + 12 + 29 - 11.5  + 75, w - 190, 40)];
    self.transacAgainTxt.placeholder = @"请再次填写交易密码";
    self.transacAgainTxt.font = [UIFont systemFontOfSize:14];
    UIView *transacAgainView = [UIView new];
    transacAgainView.frame = CGRectMake(16, 484 + 12 + 29 + 29 + 12 + 75, w - 32, 0.5);
    transacAgainView.backgroundColor = sepViewColor;
    
    //邀请码
    self.invitationLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 484 + 12 + 29 + 29 + 12 + 12 + 90, titleLblWidth, 15)];
    self.invitationLab.text = @"邀请码";
    self.invitationLab.font = [UIFont systemFontOfSize:16];
    self.invitationLab.textColor = CompleteLAB;
    self.invitationTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 484 + 12 + 29 + 29 + 12 - 11.5 + 12 + 90, w - 270, 40)];
    self.invitationTxt.placeholder = @"请填写邀请码码";
    self.invitationTxt.font = [UIFont systemFontOfSize:14];
    UIView *invitationView = [UIView new];
    invitationView.backgroundColor = UIColor.redColor;
    invitationView.frame = CGRectMake(16, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 90, w - 32, 0.5);
    invitationView.backgroundColor = sepViewColor;
    
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 11 + 105, 16, 16)];
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"矩形 13"] forState:UIControlStateNormal];
    [self.checkBtn addTarget:self action:@selector(checkbtn) forControlEvents:UIControlEventTouchUpInside];
    self.is_ch = @"1";
    self.welabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 11 + 105, 100+20, 15)];
    self.welabel.text = @"已阅读并同意";
    self.welabel.textColor = CompWeLabel;
    self.welabel.font = [UIFont systemFontOfSize:16];
    self.jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake(128 + 20, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 11 + 105, 200, 15)];
    [self.jumpBtn setTitle:@"《PICK TA及服务协议》" forState:UIControlStateNormal];
    self.jumpBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.jumpBtn setTitleColor:CompleteBTN forState:UIControlStateNormal];
    // 协议跳转
    [self.jumpBtn addTarget:self action:@selector(jumpbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 11 + 30 + 130, w - 30, 50)];
    [self.completeBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //设置文字颜色
    [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.completeBtn.layer.backgroundColor = CompleteBTN.CGColor;
    [self.completeBtn addTarget:self action:@selector(completebtn) forControlEvents:UIControlEventTouchUpInside];
    self.completeBtn.layer.cornerRadius = 3;
    self.passTxt.secureTextEntry = YES;
    self.passAgainTxt.secureTextEntry = YES;
    self.transacTxt.secureTextEntry = YES;
    self.transacAgainTxt.secureTextEntry = YES;
    
    self.longinLab = [[UILabel alloc] initWithFrame:CGRectMake(125.5, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 131 + 150, 100, 15)];
    self.longinLab.text = @"已有账号，";
    self.longinLab.textColor = [UIColor darkGrayColor];
    self.longinLab.font = [UIFont systemFontOfSize:16];
    //    [self.view addSubview:self.scrollView];
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 484 + 12 + 29 + 29 + 12 + 29 + 12 + 131 + 150, 180, 15)];
    [self.loginBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    //    [self.loginBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(onloginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitleColor:CompleteBTN forState:UIControlStateNormal];
    
    [self changeLanguage];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.closeBtn];
    [self.scrollView addSubview:self.imageBr];
    [self.scrollView addSubview:self.descriptionLab];
    [self.scrollView addSubview:self.phoneLab];
    [self.scrollView addSubview:self.phoneTxt];
    [self.scrollView addSubview:phoneView];
    [self.scrollView addSubview:self.codeLab];
    [self.scrollView addSubview:self.codeTxt];
    [self.scrollView addSubview:self.self.obtainCodeBtn];
    [self.scrollView addSubview:codeView];
    [self.scrollView addSubview:self.passLab];
    [self.scrollView addSubview:self.passTxt];
    [self.scrollView addSubview:passView];
    [self.scrollView addSubview:self.passAgainLab];
    [self.scrollView addSubview:self.passAgainTxt];
    [self.scrollView addSubview:passAgainView];
    [self.scrollView addSubview:self.transacLab];
    [self.scrollView addSubview:self.transacTxt];
    [self.scrollView addSubview:ransacView];
    [self.scrollView addSubview:self.transacAgainLab];
    [self.scrollView addSubview:self.transacAgainTxt];
    [self.scrollView addSubview:transacAgainView];
    [self.scrollView addSubview:self.invitationLab];
    [self.scrollView addSubview:self.invitationTxt];
    [self.scrollView addSubview:invitationView];
    [self.scrollView addSubview:self.checkBtn];
    [self.scrollView addSubview:self.welabel];
    [self.scrollView addSubview:self.jumpBtn];
    [self.scrollView addSubview:self.completeBtn];
    [self.scrollView addSubview:self.longinLab];
    [self.scrollView addSubview:self.loginBtn];
    
    if (self.loginBtn.bottom < h-BOTTOM_HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(w, h);//667 736 812
    } else {
        self.scrollView.contentSize = CGSizeMake(w, self.loginBtn.bottom+60+BOTTOM_HEIGHT); //667 736 812
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.phoneTxt];
    
}

- (void)onloginBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews {
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RegosterVM = PickTaRegosterVM.new;
    [self setupRegisterUI];
    [self loginViewsOper];
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    //把scrollView与pageControl添加到当前视图中
    
    //    [[self.obtainCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
    //        [self obtainCodebtn];
    //    }];
    //    [[self.checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
    //        [self checkbtn];
    //    }];
    
    
    // 注册
    [self.loginBtn addTarget:self action:@selector(completebtn) forControlEvents:UIControlEventTouchUpInside];
    // 立即登录
    [self.loginBtn addTarget:self action:@selector(closebtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginViewsOper {
}

- (void)jumpbtn:(UIButton *)sender {
    
    RegisterDealVC *dealVC = [[RegisterDealVC alloc] init];
    [self.navigationController pushViewController:dealVC animated:YES];
}

- (void)closebtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closebtn1 {
    // [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)checkPhone:(NSString *)str {
    NSString *MOBILE = @"^1[0-9]{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (![regextestmobile evaluateWithObject:str]) {
        return NO;
    }
    return YES;
}

//发送验证码
- (void)obtainCodebtn {
    WeakSelf(self)
    if (![weakself checkPhone:weakself.phoneTxt.text]) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    self.RegosterVM.loginParam = @{ @"phone": self.phoneTxt.text, @"type": @"register" };
    [self.RegosterVM.loginCommand execute:nil];
    [self.obtainCodeBtn startCountDownWithSecond:60];
    self.obtainCodeBtn.userInteractionEnabled = YES;
    //    int64_t delayInSeconds = 57.0;          // 延迟的时间
}

- (void)checkbtn {
    if (self.is_ch.length == 1) {
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
        self.is_ch = @"11";
    } else {
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"矩形 13"] forState:UIControlStateNormal];
        self.is_ch = @"1";
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    if (toBeString.length-1 > 10 && toBeString.length > 1) {
        textField.text = [toBeString substringToIndex:11];
    }
}

//注册
- (void)completebtn {
        
    if (self.is_ch.length == 2) {
//        WeakSelf(self)
        if (!(self.phoneTxt.text.length > 0)) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
            return;
        }
        if (!(self.codeTxt.text.length > 0)) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入正确验证码"];
            return;
        }
        if (!self.passTxt.text.length) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        if (!self.passAgainTxt.text.length) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
            return;
        }
        if (![self.passTxt.text isEqualToString:self.passAgainTxt.text]) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"输入的确认密码和密码不一致"];
            return;
        }
        if (!self.transacTxt.text.length) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入交易密码"];
            return;
        }
        if (!self.transacAgainTxt.text.length) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请输入确认交易密码"];
            return;
        }
        if (![self.transacAgainTxt.text isEqualToString:self.transacTxt.text]) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"输入的确认交易密码和交易密码不一致"];
            return;
        }
        if (!self.invitationTxt.text.length) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"输入邀请码"];
            return;
        }
    } else {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请同意服务协议"];
        return;
    }
    self.RegosterVM.completeParam = @{@"phone": self.phoneTxt.text, @"code": self.codeTxt.text, @"password": self.passTxt.text, @"pay_password": self.transacTxt.text, @"invitation_code": self.invitationTxt.text};
    [self.RegosterVM.completeCommand execute:nil];
    @weakify(self);
    [[self.RegosterVM.completeCommand.executionSignals.switchToLatest take:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (![x isKindOfClass:[NSError class]]) {
            PTRegister2VC *vc = [[PTRegister2VC alloc] initWithNibName:@"PTRegister2VC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

@end

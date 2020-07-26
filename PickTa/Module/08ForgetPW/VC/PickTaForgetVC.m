//
//  PickTaRegisterVC.m
//  PickTa
//
//  Created by sgq on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaForgetVC.h"
#import "PickTaForgetVM.h"
@interface PickTaForgetVC ()
@property (nonatomic, strong) PickTaForgetVM *RegosterVM;
@property (nonatomic, strong) NSString *is_ch;

@end

@implementation PickTaForgetVC

- (void)changeLanguage {
    self.descriptionLab.text = kLocalizedString(@"forget_pass1", @"忘记密码");
    self.phoneLab.text = kLocalizedString(@"phone_num", @"手机号");
    self.phoneTxt.placeholder = kLocalizedString(@"enter_phone", @"请填写手机号");
    self.codeLab.text = kLocalizedString(@"captcha", @"验证码");
    self.codeTxt.placeholder = kLocalizedString(@"in_ver_code", @"请填写验证码");
    [self.obtainCodeBtn setTitle:kLocalizedString(@"get_ver_code", @"获取验证码") forState:UIControlStateNormal];
    self.passLab.text = kLocalizedString(@"new_pwd", @"新密码");
    self.passTxt.placeholder = kLocalizedString(@"enter_new_pass", @"请输入新密码");
    self.passAgainLab.text = kLocalizedString(@"confirm_pass", @"确认新密码");
    self.passAgainTxt.placeholder = kLocalizedString(@"again_new_pass", @"请再次填写新密码");
    [self.completeBtn setTitle:kLocalizedString(@"modify", @"修改") forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RegosterVM = PickTaForgetVM.new;
    [self setupUI];
    [self loginViewsOper];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closebtn) name:RegosterSuccess object:nil];

    //把scrollView与pageControl添加到当前视图中
    CGFloat titleLblWidth = 120.f;
    CGFloat leftRightPadding = 16.f;
    CGFloat sepViewHeight = 0.5f;
    UIColor *sepViewColor = COLOR_DDDDDD;

    //关闭按钮
    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 40, 17, 17)];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"关  闭"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closebtn) forControlEvents:UIControlEventTouchUpInside];
    //背景图片
    self.imageBr = [[UIImageView alloc] initWithFrame:CGRectMake(136, 99, 103, 100)];
    self.imageBr.image = [UIImage imageNamed:@"login_logo"];

    //文字说明
    self.descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(17, 259, 150, 26)];
    self.descriptionLab.text = @"忘记密码";
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
    phoneView.frame = CGRectMake(16, 360, w - 32, 0.5);
    phoneView.backgroundColor = sepViewColor;

    //12 11.5  29
    self.codeLab = [[UILabel alloc]initWithFrame:CGRectMake(28, 372 + 15, titleLblWidth, 15)];
    self.codeLab.text = @"验证码";
    self.codeLab.font = [UIFont systemFontOfSize:16];
    self.codeLab.textColor = (__bridge UIColor *_Nullable)(CompleteLAB.CGColor);
    self.codeTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 360.5 + 15, w - 270, 40)];
    self.codeTxt.placeholder = @"请填写验证吗";
    self.codeTxt.font = [UIFont systemFontOfSize:14];
    self.obtainCodeBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(250, 369.5 + 15, 100, 20)];
    [self.obtainCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.obtainCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    //设置文字颜色
    [self.obtainCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.obtainCodeBtn.layer.backgroundColor = CompleteBTN.CGColor;
    self.obtainCodeBtn.layer.cornerRadius = 3;
    UIView *codeView = [UIView new];
    codeView.frame = CGRectMake(16, 401 + 15, w - 32, 0.5);
    codeView.backgroundColor = sepViewColor;

    //密码
    self.passLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 413 + 30, titleLblWidth, 15)];
    self.passLab.text = @"新密码";
    self.passLab.font = [UIFont systemFontOfSize:16];
    self.passLab.textColor = (__bridge UIColor *_Nullable)(CompleteLAB.CGColor);
    self.passTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 401.5 + 30, w - 270, 40)];
    self.passTxt.placeholder = @"请填写新密码";
    self.passTxt.font = [UIFont systemFontOfSize:14];
    UIView *passView = [UIView new];
    passView.frame = CGRectMake(16, 443 + 30, w - 32, 0.5);
    passView.backgroundColor = sepViewColor;

    self.passAgainLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 455 + 45, titleLblWidth, 15)];
    self.passAgainLab.text = @"确认新密码";
    self.passAgainLab.font = [UIFont systemFontOfSize:16];
    self.passAgainLab.textColor = (__bridge UIColor *_Nullable)(CompleteLAB.CGColor);
    self.passAgainTxt = [[UITextField alloc]initWithFrame:CGRectMake(150, 443.5 + 45, w - 190, 40)];
    self.passAgainTxt.placeholder = @"请再次填写新密码";
    self.passAgainTxt.font = [UIFont systemFontOfSize:14];
    UIView *passAgainView = [UIView new];
    passAgainView.frame = CGRectMake(16, 484 + 45, w - 32, 0.5);
    passAgainView.backgroundColor = sepViewColor;

    self.completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 484 + 32 + 65, w - 30, 50)];
    [self.completeBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //设置文字颜色
    [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.completeBtn.layer.backgroundColor = CompleteBTN.CGColor;
    self.completeBtn.layer.cornerRadius = 3;
    self.passTxt.secureTextEntry = YES;
    self.passAgainTxt.secureTextEntry = YES;
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.imageBr];
    [self.view addSubview:self.descriptionLab];
    [self.view addSubview:self.phoneLab];
    [self.view addSubview:self.phoneTxt];
    [self.view addSubview:phoneView];
    [self.view addSubview:self.codeLab];
    [self.view addSubview:self.codeTxt];
    [self.view addSubview:self.self.obtainCodeBtn];
    [self.view addSubview:codeView];
    [self.view addSubview:self.passLab];
    [self.view addSubview:self.passTxt];
    [self.view addSubview:passView];
    [self.view addSubview:self.passAgainLab];
    [self.view addSubview:self.passAgainTxt];
    [self.view addSubview:passAgainView];

    [self.view addSubview:self.completeBtn];

    [[self.obtainCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        [self obtainCodebtn];
    }];

    [[self.completeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        [self completebtn];
    }];

    [self changeLanguage];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loginViewsOper {
}

- (void)closebtn {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    // [self.navigationController popViewControllerAnimated:YES];
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
    self.RegosterVM.loginParam = @{ @"phone": self.phoneTxt.text, @"type": @"find" };
    [self.RegosterVM.loginCommand execute:nil];
    [self.obtainCodeBtn startCountDownWithSecond:60];
    self.obtainCodeBtn.userInteractionEnabled = YES;
    int64_t delayInSeconds = 57.0;          // 延迟的时间
}

//修改

- (void)completebtn {
    if (!(self.phoneTxt.text.length > 0) ) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    if (!(self.codeTxt.text.length > 0) ) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确验证码"];
        return;
    }
//     BOOL res =  [self.passTxt.text isEqualToString:self.passAgainTxt.text];
    if ([self.passTxt.text isEqualToString:self.passAgainTxt.text]) {
        self.RegosterVM.forgetParam = @{ @"phone": self.phoneTxt.text, @"code": self.codeTxt.text, @"password": self.passTxt.text };
        [self.RegosterVM.forgetCommand execute:nil];
    } else {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确登陆密码"];
    }
}

@end

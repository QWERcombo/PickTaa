//
//  PickTaLoginVC.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaLoginVC.h"
#import "PickTaLoginVM.h"
#import "PickTaRegisterVC.h"
#import "PickTaForgetVC.h"

@interface PickTaLoginVC ()
@property (nonatomic,strong)PickTaLoginVM *loginVM;
@end

@implementation PickTaLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginVM = PickTaLoginVM.new;
    [self setupUI];
    [self loginViewsOper];
}
-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
}

- (void)changeLanguage {
    self.loginTitleLbl.text = kLocalizedString(@"login", @"登录");
    self.phoneLbl.text = kLocalizedString(@"phone_num", @"手机号");
    self.pswLbl.text = kLocalizedString(@"pass", @"密码");
    self.noRigsterLbl.text = kLocalizedString(@"no_account", @"没有账号，");

    self.phoneNo.placeholder = kLocalizedString(@"enter_phone", @"请填写手机号");
    self.psw.placeholder = kLocalizedString(@"enter_pass", @"请填写密码");

    [self.login setTitle:kLocalizedString(@"login", @"登录") forState:UIControlStateNormal];
    [self.registers setTitle:kLocalizedString(@"register_now", @"立即注册") forState:UIControlStateNormal];
    [self.passwork setTitle:kLocalizedString(@"forget_pass", @"忘记密码？") forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
}

-(void)setupUI {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.phoneNo];

    if(!String_IsEmpty([PickTaUserDefaults g_getPSW]))
        self.psw.text = [PickTaUserDefaults g_getPSW];
    
    if(!String_IsEmpty([PickTaUserDefaults g_getPhoneNum]))
        self.phoneNo.text = [PickTaUserDefaults g_getPhoneNum];
    
    [self changeLanguage];
}

#pragma mark - UITextFieldDelegate

- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
   
    if (toBeString.length-1 > 10 && toBeString.length > 1) {
        textField.text = [toBeString substringToIndex:11];
    }
}

-(void)loginViewsOper{
    @weakify(self);
    RAC(self.login,enabled) = [RACSignal combineLatest:@[self.phoneNo.rac_textSignal,self.psw.rac_textSignal] reduce:^(NSString *username, NSString *password){
        @strongify(self);
        if(username.length>0 && password.length>0){
            [self.login setBackgroundColor:[UIColor colorWithRGB:0x44BCBA]];
        }else{
            [self.login setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }
        return @(username.length>0 && password.length>0);
    }];
    
    //登录
    [[self.login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.loginVM.loginParam = @{@"phone":self.phoneNo.text,@"password":self.psw.text};
        [self.loginVM.loginCommand execute:nil];
    }];
    //注册
    [[self.registers rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self loginWithViewController:self];
//          [self.loginVM.loginCommand execute:nil];
      }];
    //忘记密码
    [[self.passwork rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self);
      
          [self forgetWithViewController:self];          
      }];
//    //命令结束
//    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"success or error:%@",x);
//    }];
//    
//    //提示框，可有可无
//    [[self.loginVM.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
//        if([x isEqualToNumber:@(YES)])
//            [SVProgressHUD showWithStatus:@""];
//        else
//            [SVProgressHUD dismiss];
//    }];
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        // 这里的x是一个RACSignal，即执行Command时返回的那个Signal，所以x也是可以订阅的。收到这个信号，说明网络请求开始。
//        [SVProgressHUD showWithStatus:@""];
//        // 这里收到信号是开始发送网络请求
//        [x subscribeNext:^(id x) {
//            // 这里收到信号是网络请求返回
//            [SVProgressHUD dismiss];
//NSLog(@"success or error:%@",x);
//            // do something
//        }];
        if ([x isKindOfClass:NSError.class]) {
            NSError *error = (NSError *)x;
            [SVProgressHUD showErrorWithStatus:error.domain];
        }
    }];
}


- (void)loginWithViewController:(UIViewController *)currentVC {
    PickTaRegisterVC *loginApp = [[PickTaRegisterVC alloc] init];
//    [self presentViewController:loginApp animated:YES completion:^{}];
    [self.navigationController pushViewController:loginApp animated:YES];
}

- (void)forgetWithViewController:(UIViewController *)currentVC {
    PickTaForgetVC *loginApp = [[PickTaForgetVC alloc]init];
    [self presentViewController:loginApp animated:YES completion:^{
           
       }];
    //[self.navigationController pushViewController:loginApp animated:YES];
}

@end

//
//  PTModifyDealPwVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTModifyDealPwVC.h"
#import "PTModifyLoginPwVM.h"
#import "PickTaRegosterVM.h"
#import "XSWJVARegexPattern.h"
#import "PTMyModel.h"

@interface PTModifyDealPwVC ()
@property (nonatomic, strong) PickTaRegosterVM *RegosterVM; //loginCommand
@property (nonatomic, strong) PTModifyLoginPwVM *vm;
@end

@implementation PTModifyDealPwVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = kLocalizedString(@"change_pay_pass", @"修改交易密码");
    self.titleLbl1.text = kLocalizedString(@"captcha", @"验证码");
    //self.titleLbl2.text = kLocalizedString(@"pay_pass", @"交易密码");
       self.titleLbl3.text = kLocalizedString(@"new_pay_pass", @"新交易密码");
    self.titleLbl4.text = kLocalizedString(@"confirm_in_new_pay", @"确认新交易密码");

       self.pwTfl1.placeholder = kLocalizedString(@"in_ver_code", @"请输入验证码");
       //self.pwTfl2.placeholder = kLocalizedString(@"", @"");
       self.pwTfl3.placeholder = kLocalizedString(@"in_new_pay", @"请输入6位新交易密码");
    self.pwTfl4.placeholder = kLocalizedString(@"agegin_new_pay", @"请再次输入6位新交易密码");
    
    [self.modifyBtn setTitle:kLocalizedString(@"modify", @"修改") forState:UIControlStateNormal];
    [self.codeBtn setTitle:kLocalizedString(@"get_ver_code", @"获取验证码") forState:UIControlStateNormal];
    
    @weakify(self)
    self.vm = [PTModifyLoginPwVM new];
    self.RegosterVM = PickTaRegosterVM.new;

       [self.vm.command2.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
           @strongify(self)
           
           if ([x isKindOfClass:[NSError class]]) {
               NSError *error = (NSError *)x;
               [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
           } else {
               [self.view makeToast:(NSString *)x duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
               [self.navigationController popViewControllerAnimated:YES];
           }
       }];
    
    [self.RegosterVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn startCountDownWithSecond:60];
                self.codeBtn.enabled = NO;
            });
        }
    }];
}

- (IBAction)codeBtnAction:(JKCountDownButton *)sender {
    NSString *string = [PickTaUserDefaults g_getValueForKey:@"user_info"];
    PTMyModel *myModel = [PTMyModel modelWithJSON:string];

    self.RegosterVM.loginParam = @{
        @"phone":myModel.phone,
        @"type":@"pay_password"
    };
    
    [self.RegosterVM.loginCommand execute:nil];
}

- (IBAction)modifyBtnAction:(id)sender {
    if (String_IsEmpty(self.pwTfl1.text)) {
        [self.view makeToast:kLocalizedString(@"in_ver_code", @"请输入验证码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (![XSWJVARegexPattern validateVerifyCode:self.pwTfl1.text]) {
        [self.view makeToast:@"请输入正确的验证码" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (String_IsEmpty(self.pwTfl3.text)) {
        [self.view makeToast:kLocalizedString(@"new_pay_pass", @"新交易密码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (![XSWJVARegexPattern validateVerifyCode:self.pwTfl3.text]) {
        [self.view makeToast:@"请输入6位数字交易密码" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }

    if (String_IsEmpty(self.pwTfl4.text)) {
        [self.view makeToast:kLocalizedString(@"agegin_new_pay", @"请再次输入6位数字新交易密码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (![self.pwTfl4.text isEqualToString:self.pwTfl3.text]) {
        [self.view makeToast:@"两次输入交易密码不一致" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    self.vm.param1 = @{
        @"code" : self.pwTfl1.text,
        @"password" : self.pwTfl3.text,
    };
    [self.vm.command2 execute:nil];

}

@end

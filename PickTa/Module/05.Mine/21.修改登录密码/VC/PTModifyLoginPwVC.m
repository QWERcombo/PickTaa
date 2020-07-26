//
//  PTModifyLoginPwVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTModifyLoginPwVC.h"
#import "PTModifyLoginPwVM.h"

@interface PTModifyLoginPwVC ()
@property (nonatomic, strong) PTModifyLoginPwVM *vm;
@end

@implementation PTModifyLoginPwVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = kLocalizedString(@"change_pass", @"修改登录密码");
    self.titleLbl1.text = kLocalizedString(@"old_pass", @"旧登录密码");
    self.titleLbl2.text = kLocalizedString(@"new_pass", @"新登录密码");
    self.titleLbl3.text = kLocalizedString(@"confirm_new_pass", @"确认新登录密码");
    self.pwTfl1.placeholder = kLocalizedString(@"in_old_pass", @"请输入旧登录密码");
    self.pwTfl2.placeholder = kLocalizedString(@"in_new_pass", @"请设置新登录密码");
    self.pwTfl3.placeholder = kLocalizedString(@"confrim_in_new_pass", @"请再次确认新登录密码");
    [self.modifyBtn setTitle:kLocalizedString(@"modify", @"修改") forState:UIControlStateNormal];
    
    @weakify(self)
    self.vm = [PTModifyLoginPwVM new];

    [self.vm.command1.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            [self.view makeToast:(NSString *)x duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (IBAction)modifyBtnAction:(id)sender {
    if (String_IsEmpty(self.pwTfl1.text)) {
        [self.view makeToast:kLocalizedString(@"in_old_pass", @"请输入旧登录密码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (self.pwTfl1.text.length < 8 || self.pwTfl1.text.length > 20) {
        [self.view makeToast:@"请输入8-20位旧密码" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (String_IsEmpty(self.pwTfl2.text)) {
        [self.view makeToast:kLocalizedString(@"in_new_pass", @"请设置新登录密码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (self.pwTfl2.text.length < 8 || self.pwTfl2.text.length > 20) {
        [self.view makeToast:@"请输入8-20位新密码" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }

    if (String_IsEmpty(self.pwTfl3.text)) {
        [self.view makeToast:kLocalizedString(@"confirm_new_pass", @"确认新登录密码") duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    if (![self.pwTfl2.text isEqualToString:self.pwTfl3.text]) {
        [self.view makeToast:@"两次输入的新登录密码不一致" duration:2.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    self.vm.param1 = @{
        @"old_password" : self.pwTfl1.text,
        @"password" : self.pwTfl2.text,
        @"re_password" : self.pwTfl3.text,
    };
    [self.vm.command1 execute:nil];
}

@end

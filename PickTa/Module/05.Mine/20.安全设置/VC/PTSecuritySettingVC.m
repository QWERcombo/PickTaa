//
//  PTSecuritySettingVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTSecuritySettingVC.h"

@interface PTSecuritySettingVC ()

@end

@implementation PTSecuritySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = kLocalizedString(@"set", @"安全设置");
    self.modifyLoginPwLbl.text = kLocalizedString(@"change_pass", @"修改登录密码");
    self.modifyDealPwLbl.text = kLocalizedString(@"change_pay_pass", @"修改交易密码");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

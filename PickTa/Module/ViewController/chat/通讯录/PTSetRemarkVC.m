//
//  PTSetRemarkVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTSetRemarkVC.h"

@interface PTSetRemarkVC ()

@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@end

@implementation PTSetRemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置备注";
 
    self.inputTF.placeholder = @"输入备注名";
    self.inputTF.text = self.user_remark;
    [self.inputTF becomeFirstResponder];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:kLocalizedString(@"save", @"保存") forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    @weakify(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        if (!self.inputTF.text.length) {
            [SVProgressHUD showErrorWithStatus:self.inputTF.placeholder];
            return;
        }
        [PickHttpManager.shared requestPOST:API_FriendRemark withParam:@{
            @"remark":self.inputTF.text,
            @"to_id":self.user_id
        } withSuccess:^(id  _Nonnull obj) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateRemark" object:nil];
            [SVProgressHUD showSuccessWithStatus:obj];
            [self.navigationController popViewControllerAnimated:YES];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

@end

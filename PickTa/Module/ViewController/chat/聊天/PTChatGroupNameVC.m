//
//  PTChatGroupNameVC.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatGroupNameVC.h"

@interface PTChatGroupNameVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@end

@implementation PTChatGroupNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"群名称";
    self.inputTF.text = self.text;
    [self.inputTF becomeFirstResponder];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:kLocalizedString(@"save", @"保存") forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 60, 40);
    @weakify(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        if (!self.inputTF.text.length) {
            [SVProgressHUD showErrorWithStatus:self.inputTF.placeholder];
            return;
        }
        [PickHttpManager.shared requestPOST:API_ChatGroupNameSet withParam:@{
            @"group_id":self.grp_id,
            @"name":self.inputTF.text
        } withSuccess:^(id  _Nonnull obj) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

@end

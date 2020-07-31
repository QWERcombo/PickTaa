//
//  PTChatGroupNotesVC.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatGroupNotesVC.h"

@interface PTChatGroupNotesVC ()

@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@end

@implementation PTChatGroupNotesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"群公告";
    self.inputTV.text = self.text;
    [self.inputTV becomeFirstResponder];
}

- (IBAction)doneClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!self.inputTV.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入公告内容"];
        return;
    }
    [PickHttpManager.shared requestPOST:API_ChatSetNotice withParam:@{
        @"group_id":self.grp_id,
        @"notice":self.inputTV.text
    } withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}

@end

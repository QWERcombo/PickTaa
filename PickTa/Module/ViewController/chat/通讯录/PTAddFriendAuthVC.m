//
//  PTAddFriendAuthVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTAddFriendAuthVC.h"

@interface PTAddFriendAuthVC ()
@property (weak, nonatomic) IBOutlet UILabel *user_name;

@end

@implementation PTAddFriendAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友验证";
    
    PTMyModel *myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    self.user_name.text = [NSString stringWithFormat:@"我是: %@", myModel.nickname];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"发送" forState:UIControlStateNormal];
    addBtn.backgroundColor = MainBlueColor;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 55, 30);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [PickHttpManager.shared requestPOST:API_FriendApply withParam:@{
            @"to_id":self.userModel.id,
            @"remarks":myModel.nickname
        } withSuccess:^(id  _Nonnull obj) {
            [SVProgressHUD showSuccessWithStatus:@"好友请求已发送"];
            [self.navigationController popViewControllerAnimated:YES];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}



@end

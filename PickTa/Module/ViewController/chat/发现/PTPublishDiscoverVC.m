//
//  PTPublishDiscoverVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishDiscoverVC.h"

@interface PTPublishDiscoverVC ()

@end

@implementation PTPublishDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setupUI {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"发布" forState:UIControlStateNormal];
    addBtn.backgroundColor = MainBlueColor;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 55, 30);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [PickHttpManager.shared requestPOST:API_FriendApply withParam:@{
//            @"to_id":self.userModel.id,
//            @"remarks":myModel.nickname
//        } withSuccess:^(id  _Nonnull obj) {
//            [SVProgressHUD showSuccessWithStatus:@"好友请求已发送"];
//            [self.navigationController popViewControllerAnimated:YES];
//        } withFailure:^(NSError * _Nonnull err) {
//            [SVProgressHUD showErrorWithStatus:err.domain];
//        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

@end

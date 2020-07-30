//
//  PTFriendAuthVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTFriendAuthVC.h"

@interface PTFriendAuthVC ()
@property (weak, nonatomic) IBOutlet UISwitch *authSwitch1;
@property (weak, nonatomic) IBOutlet UISwitch *authSwitch2;

@end

@implementation PTFriendAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友权限";
    
    self.authSwitch1.on = self.model.side_auth;
    self.authSwitch2.on = self.model.circle_auth;
    
    /** 不让看 */
    [self.authSwitch1.rac_newOnChannel subscribeNext:^(NSNumber * _Nullable x) {
        [PickHttpManager.shared requestPOST:API_FriendForbidMe withParam:@{
            @"friend_id":@(self.model.friend_id),
            @"status":[x boolValue]?@"on":@"off"
        } withSuccess:^(id  _Nonnull obj) {
            self.model.side_auth = [x boolValue];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    /** 不看 */
    [self.authSwitch2.rac_newOnChannel subscribeNext:^(NSNumber * _Nullable x) {
        [PickHttpManager.shared requestPOST:API_FriendForbidHim withParam:@{
            @"friend_id":@(self.model.friend_id),
            @"status":[x boolValue]?@"on":@"off"
        } withSuccess:^(id  _Nonnull obj) {
            self.model.circle_auth = [x boolValue];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
}

@end

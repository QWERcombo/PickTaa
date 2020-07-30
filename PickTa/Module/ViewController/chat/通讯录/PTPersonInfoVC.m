//
//  PTPersonInfoVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/29.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPersonInfoVC.h"
#import "PTSetRemarkVC.h"
#import "PTFriendAuthVC.h"
#import "PTChatDetaiVC.h"
#import "PTFriendDiscoverVC.h"

@interface PTPersonInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_id;
@property (weak, nonatomic) IBOutlet UILabel *user_status;
@property (nonatomic, strong) PickTaUserListModel *currentUserModel;
@end

@implementation PTPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.user_avatar.layer.cornerRadius = 6;
    self.user_avatar.layer.masksToBounds = YES;
    
    [self requestData];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kUpdateRemark" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestData];
    }];
}

- (void)requestData {
    
    [PickHttpManager.shared requestPOST:API_FriendInfo withParam:@{
        @"friend_id":@(self.userListModel.friend_id).stringValue
    } withSuccess:^(id  _Nonnull obj) {
        
        PickTaUserListModel *model = [PickTaUserListModel modelWithJSON:obj];
        self.currentUserModel = model;
        [self.user_avatar sd_setImageWithURL:[NSURL URLWithString:model.to_head] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
        self.user_name.text = model.nick_remark;
        self.user_id.text = [NSString stringWithFormat:@"ID: %@",model.my_id];
        self.user_status.text = model.status_name;
        
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        /** 备注 */
        PTSetRemarkVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTSetRemarkVC"];
        vc.user_id = @(self.currentUserModel.friend_id).stringValue;
        vc.user_remark = self.currentUserModel.nick_remark;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        /** 权限 */
        PTFriendAuthVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTFriendAuthVC"];
        vc.model = self.currentUserModel;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        /** 朋友圈 */
        PTFriendDiscoverVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTFriendDiscoverVC"];
        vc.friend_id = @(self.currentUserModel.friend_id).stringValue;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        /** 发消息 */
        PTChatDetaiVC *chatVC = [PTChatDetaiVC new];
        chatVC.to_id = @(self.currentUserModel.friend_id).stringValue;
        chatVC.type = @"1";
        chatVC.navigationItem.title = self.currentUserModel.to_nickname;
        [self.navigationController pushViewController:chatVC animated:YES];
    } else if (indexPath.row == 6) {
        /** 删除 */
        [self alertSureCancle:@"提示" andSubTitle:@"确定删除好友" sureTitle:@"确定" cancleTitle:@"取消" sureCallBack:^{
            
            [PickHttpManager.shared requestPOST:API_FriendDel withParam:@{
                @"friend_id":@(self.userListModel.friend_id).stringValue
            } withSuccess:^(id  _Nonnull obj) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateRemark" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
            
        } cancleCallBack:^{
        }];
    }
}

@end

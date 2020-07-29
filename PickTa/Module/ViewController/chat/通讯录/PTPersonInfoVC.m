//
//  PTPersonInfoVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/29.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPersonInfoVC.h"

@interface PTPersonInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_id;
@property (weak, nonatomic) IBOutlet UILabel *user_status;

@end

@implementation PTPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.user_avatar.layer.cornerRadius = 6;
    self.user_avatar.layer.masksToBounds = YES;
    
    [self requestData];
}

- (void)requestData {
    
    [PickHttpManager.shared requestPOST:API_FriendInfo withParam:@{
        @"friend_id":@(self.userListModel.friend_id).stringValue
    } withSuccess:^(id  _Nonnull obj) {
        
        PickTaUserListModel *model = [PickTaUserListModel modelWithJSON:obj];
        
        [self.user_avatar sd_setImageWithURL:[NSURL URLWithString:model.to_head] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
        self.user_name.text = model.nick_remark;
        self.user_id.text = [NSString stringWithFormat:@"ID: %@",model.my_id];
        self.user_status.text = model.status_name;
        
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    if (indexPath.row == 1) {
        /** 备注 */
        
    } else if (indexPath.row == 2) {
        /** 权限 */
        
    } else if (indexPath.row == 3) {
        /** 朋友圈 */
        
    } else if (indexPath.row == 5) {
        /** 发消息 */
        
    } else if (indexPath.row == 6) {
        /** 删除 */
        [self alertSureCancle:@"提示" andSubTitle:@"确定删除好友" sureTitle:@"确定" cancleTitle:@"取消" sureCallBack:^{
            
            [PickHttpManager.shared requestPOST:API_FriendDel withParam:@{
                @"friend_id":@(self.userListModel.friend_id).stringValue
            } withSuccess:^(id  _Nonnull obj) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
            
        } cancleCallBack:^{
            
        }];
    }
}

@end

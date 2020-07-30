//
//  PTAddFriendInfoVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTAddFriendInfoVC.h"
#import "PTAddFriendAuthVC.h"
#import "PTSetRemarkVC.h"
@interface PTAddFriendInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;

@end

@implementation PTAddFriendInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.user_avatar.layer.cornerRadius = 6;
    self.user_avatar.layer.masksToBounds = YES;
    [self.user_avatar sd_setImageWithURL:[NSURL URLWithString:self.userModel.head_portrait] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    self.user_name.text = self.userModel.nickname;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        PTSetRemarkVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTSetRemarkVC"];
        vc.user_id = self.userModel.id;
        vc.user_remark = self.userModel.nickname;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        PTAddFriendAuthVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTAddFriendAuthVC"];
        vc.userModel = self.userModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

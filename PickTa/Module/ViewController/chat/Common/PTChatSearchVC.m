//
//  PTChatSearchVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatSearchVC.h"
#import "PickTaSearchUserModel.h"
#import "PTAddFriendInfoVC.h"
@interface PTChatSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation PTChatSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.datas = [NSMutableArray array];
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.tableView.rowHeight = 62.f;
    self.tableView.separatorColor = ChatLineColor;
    self.tableView.tableFooterView = [UIView new];
    
    self.topView.layer.cornerRadius = 6;
    self.topView.layer.masksToBounds = YES;
    
    [self.searchTF becomeFirstResponder];
    if (self.searchType == 1) {
        self.searchTF.placeholder = kLocalizedString(@"phone_id", @"手机号/ID号");
    } else if (self.searchType == 2) {
        self.searchTF.placeholder = kLocalizedString(@"search", @"搜索");
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTContractsCell *cell = [PTChatViewFactory createChatContractsCellForTableView:tableView];
    
    if (self.datas.count) {
        if (self.searchType == 1) {
            PickTaSearchUserModel *model = [self.datas objectAtIndex:indexPath.row];
            [cell.contractIcon sd_setImageWithURL:[NSURL URLWithString:model.head_portrait] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
            cell.contractType.text = [NSString stringWithFormat:@"搜索: %@",model.nickname];
        } else {
            PTChatRecordModel *model = [self.datas objectAtIndex:indexPath.row];
            [cell.contractIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
            cell.contractType.text = model.nickname;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchType == 1) {
        PTAddFriendInfoVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTAddFriendInfoVC"];
        vc.userModel = [self.datas objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (self.searchType == 2) {
        
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length) {
        [textField resignFirstResponder];
        if (self.searchType == 1) {
            [PickHttpManager.shared requestGET:API_Usersearch withParam:@{
                @"content":textField.text
            } withSuccess:^(id  _Nonnull obj) {
                [self.datas removeAllObjects];
                [self.datas addObjectsFromArray:[NSArray modelArrayWithClass:[PickTaSearchUserModel class] json:obj[@"users"]]];
                [self.tableView reloadData];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        } else if (self.searchType == 2) {
            [PickHttpManager.shared requestPOST:API_ChatMyGroup withParam:@{
                @"search":textField.text
            } withSuccess:^(id  _Nonnull obj) {
                [self.datas removeAllObjects];
                [self.datas addObjectsFromArray:[NSArray modelArrayWithClass:[PTChatRecordModel class] json:obj]];
                [self.tableView reloadData];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        }
        
        return YES;
    }
    
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

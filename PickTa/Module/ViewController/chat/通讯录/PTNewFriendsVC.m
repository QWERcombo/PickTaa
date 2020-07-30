//
//  PTNewFriendsVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/29.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTNewFriendsVC.h"
#import "PTChatSearchVC.h"
#import "PickTaNewFriendModel.h"
#import "PTAddRequestListCell.h"

@interface PTNewFriendsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lab0;
@property (weak, nonatomic) IBOutlet UILabel *cardId;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation PTNewFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = kLocalizedString(@"new_friend", @"新的朋友");
    self.datas = [NSMutableArray array];
}

- (void)setupUI {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 70.f;
    self.lab0.text = kLocalizedString(@"my_id", @"我的ID：");
    PTMyModel *myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    self.cardId.text = @(myModel.my_id).stringValue;
    self.lab1.text = kLocalizedString(@"new_fd", @"新的好友");
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:kLocalizedString(@"add_friend", @"添加朋友") forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 60, 40);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        PTChatSearchVC *search = [[PTChatSearchVC alloc] initWithNibName:@"PTChatSearchVC" bundle:nil];
        search.searchType = 1;
        PickTaNavigationController *navi = [[PickTaNavigationController alloc]initWithRootViewController:search];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:YES completion:^{
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

- (void)requestData {
    
    [PickHttpManager.shared requestGET:API_FriendAppleList withParam:@{} withSuccess:^(id  _Nonnull obj) {
        [self.datas removeAllObjects];
        [self.datas addObjectsFromArray:[NSArray modelArrayWithClass:PickTaNewFriendModel.class json:obj[@"list"]]];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTAddRequestListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTAddRequestListCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PTAddRequestListCell" owner:nil options:nil].firstObject;
    }
    
    if (self.datas.count) {
        PickTaNewFriendModel *model = [self.datas objectAtIndex:indexPath.row];
        
        [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.apply_head] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
        cell.showName.text = model.apply_nickname;
        cell.showDesc.text = @"好友申请";
        
        [[[cell.acceptBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [PickHttpManager.shared requestPOST:API_FriendApproveUser withParam:@{
                @"id":model.id,
                @"remark":model.apply_nickname
            } withSuccess:^(id  _Nonnull obj) {
                [SVProgressHUD showSuccessWithStatus:@"接受申请"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateRemark" object:nil];
                [self.datas removeObject:model];
                [self.tableView reloadData];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        }];
    }
    
    return cell;
}

@end

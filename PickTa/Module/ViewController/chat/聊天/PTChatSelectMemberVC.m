//
//  PTChatSelectMemberVC.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatSelectMemberVC.h"
#import "PTChatSelectCell.h"
@interface PTChatSelectMemberVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *selectDatas;
@end

@implementation PTChatSelectMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择联系人";
    self.datas = [NSMutableArray array];
    self.selectDatas = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:self.type==0?@"建群":@"确定" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    @weakify(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        if (!self.selectDatas.count) {
            [SVProgressHUD showErrorWithStatus:@"请选择联系人"];
            return;
        }

        [PickHttpManager.shared requestPOST:API_ChatGroupAdd withParam:@{
            @"group_id":self.group_id,
            @"ids":[self.selectDatas modelToJSONString]
        } withSuccess:^(id  _Nonnull obj) {
            [SVProgressHUD showSuccessWithStatus:self.type==0?@"创建成功":@"添加成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

- (void)requestData {
    
    [[PickHttpManager shared]requestGET:API_userList withParam:@{} withSuccess:^(id  _Nonnull obj) {
        [self.datas addObjectsFromArray:[NSArray modelArrayWithClass:[PickTaUserListModel class] json:obj[@"data"]]];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTChatSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTChatSelectCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PTChatSelectCell" owner:self options:nil].firstObject;
    }
    
    PickTaUserListModel *userModel = [self.datas objectAtIndex:indexPath.row];
    cell.user_name.text = userModel.nick_remark;
    [cell.user_avatar sd_setImageWithURL:[NSURL URLWithString:userModel.to_head] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    cell.statsuBtn.selected = userModel.isSelect;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PickTaUserListModel *userModel = [self.datas objectAtIndex:indexPath.row];
    userModel.isSelect = !userModel.isSelect;
    if (userModel.isSelect) {
        [self.selectDatas addObject:@(userModel.friend_id)];
    } else {
        [self.selectDatas removeObject:@(userModel.friend_id)];
    }
    [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

@end

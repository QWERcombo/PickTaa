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
@end

@implementation PTChatSelectMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择联系人";
    self.datas = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:self.type==0?@"建群":@"确定" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    @weakify(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        NSLog(@"%@", addBtn.currentTitle);
//        if (!self.inputTF.text.length) {
//            [SVProgressHUD showErrorWithStatus:self.inputTF.placeholder];
//            return;
//        }
//        [PickHttpManager.shared requestPOST:API_ChatGroupNameSet withParam:@{
//            @"group_id":self.grp_id,
//            @"name":self.inputTF.text
//        } withSuccess:^(id  _Nonnull obj) {
//            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//        } withFailure:^(NSError * _Nonnull err) {
//            [SVProgressHUD showErrorWithStatus:err.domain];
//        }];
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end

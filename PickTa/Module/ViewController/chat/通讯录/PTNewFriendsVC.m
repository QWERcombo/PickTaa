//
//  PTNewFriendsVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/29.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTNewFriendsVC.h"

@interface PTNewFriendsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UILabel *lab0;
@property (weak, nonatomic) IBOutlet UILabel *cardId;
@property (weak, nonatomic) IBOutlet UILabel *lab1;

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
        NSLog(@"222");
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

- (void)requestData {
    
    [PickHttpManager.shared requestGET:API_FriendAppleList withParam:@{} withSuccess:^(id  _Nonnull obj) {
        
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end

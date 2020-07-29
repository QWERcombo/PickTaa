//
//  PickTaContactsVC.m
//  PickTa
//
//  Created by Stark on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaContactsVC.h"
#import "PTChatViewFactory.h"
#import "PTUserListVM.h"

@interface PickTaContactsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PTUserListVM *userListVM;
@property (nonatomic,strong) NSArray <PickTaUserListModel*>*userList;
@end

@implementation PickTaContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupUI{
    self.navigationItem.title = kLocalizedString(@"mill", @"通讯录");
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 61.5;
    self.tableView.separatorColor = ChatLineColor;
}

- (void)bindViewModel{
    self.userListVM = [PTUserListVM new];
    @weakify(self)
    [self.userListVM.userListCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.userList = x;
        [self.tableView reloadData];
    }];
}

- (void)requestData{
    [self.userListVM.userListCommand execute:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userList.count+2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTContractsCell *cell = [PTChatViewFactory createChatContractsCellForTableView:tableView];
    if(indexPath.row == 0)
        [cell contractNewFriendsUI];
    if(indexPath.row == 1)
        [cell contractGroupUI];
    if(indexPath.row >= 2)
        cell.model = self.userList[indexPath.row-2];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else {
        
    }
    
}

@end

//
//  PickTaMSGVC.m
//  PickTa
//
//  Created by Stark on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaChatsVC.h"
#import "PTChatViewFactory.h"
#import "PTChatRecordVM.h"
#import "PTChatDetaiVC.h"

@interface PickTaChatsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PTChatRecordVM *vm;
@property (nonatomic,strong) NSMutableArray<PTChatRecordModel*> *records;
@end

@implementation PickTaChatsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.records = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestData) name:ReceiveMessage object:nil];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kUpdateInfoReload" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestData];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)setupUI{
    self.navigationItem.title = kLocalizedString(@"talk", @"聊天");
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    self.tableView.separatorColor = ChatLineColor;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 74.5;
}


- (void)bindViewModel{
    self.vm = [PTChatRecordVM new];
//    [[PickTaWebSocketManager share]connect];
   
    @weakify(self)
    [self.vm.chatRecordCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.records removeAllObjects];
        [self.records addObjectsFromArray:x];
        [self.tableView reloadData];
    }];
}

- (void)requestData{
     [self.vm.chatRecordCommand execute:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PTChatDetaiVC *chatVC = [PTChatDetaiVC new];
    chatVC.to_id = [NSString stringWithFormat:@"%ld",self.records[indexPath.row].to_id];
    chatVC.type = [NSString stringWithFormat:@"%ld",self.records[indexPath.row].type];
    chatVC.avatar = self.records[indexPath.row].avatar;
    chatVC.navigationItem.title = self.records[indexPath.row].nickname;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.records.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTChatCurrentCell *cell = [PTChatViewFactory createChatCurrentCellForTableView:tableView];
    cell.recordIndexModel = self.records[indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PTChatRecordModel *model = [self.records objectAtIndex:indexPath.row];
        [PickHttpManager.shared requestPOST:API_ChatRecordDel withParam:@{
            @"id":@(model.pickID).stringValue
        } withSuccess:^(id  _Nonnull obj) {
            [self.records removeObject:model];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    }
}

@end

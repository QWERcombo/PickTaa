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
@property (nonatomic,strong) NSArray<PTChatRecordModel*> *records;
@end

@implementation PickTaChatsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestData) name:ReceiveMessage object:nil];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kUpdateInfoReload" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestData];
    }];
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
        self.records = x;
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


@end

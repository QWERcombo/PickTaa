//
//  PTDiscoverListVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDiscoverListVC.h"
#import "PickTaFriendCircleModel.h"
#import "SDTimeLineTableHeaderView.h"
#import "PTDiscoverListCell.h"
#import "JYLCommentInputView.h"

@interface PTDiscoverListVC ()<UITableViewDelegate,UITableViewDataSource,PTDiscoverListCellDelegate,JYLCommentInputViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) SDTimeLineTableHeaderView *headerView;
@property (nonatomic, strong) PTMyModel *myModel;
@property (nonatomic, strong) JYLCommentInputView *inputView;
@property (nonatomic, strong) DataItem *currentCommentItem;
@end

@implementation PTDiscoverListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [NSMutableArray array];
    self.page = 1;
}

- (void)setupUI{
    self.navigationItem.title = @"发现";
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setImage:[UIImage imageNamed:@"chat_icon_1"] forState:UIControlStateNormal];
    publishBtn.frame = CGRectMake(0, 0, 40, 40);
    [[publishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[UIViewController initViewControllerFromChatStoryBoardName:@"PTPublishDiscoverVC"] animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    
    self.headerView = [SDTimeLineTableHeaderView new];
    self.headerView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT*0.3);
    self.myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:self.myModel.avatar]];
    self.headerView.nameLabel.text = self.myModel.nickname;
    self.tableView.tableHeaderView = self.headerView;
    
    /** 输入框 */
    self.inputView = [[JYLCommentInputView alloc] initWithFrame:CGRectMake(0, self.view.size.height, kScreenWidth, 50)];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
    
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf requestData];
    }];
}

- (void)requestData {
    
    [SVProgressHUD showWithStatus:@"Loading"];
    [PickHttpManager.shared requestGET:API_CircleFriend withParam:@{
        @"type":@"1",
        @"limit":@"10",
        @"page":@(self.page)
    } withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD dismiss];
        PickTaFriendCircleModel *model = [PickTaFriendCircleModel modelWithJSON:obj];
        if (self.page == 1) {
            self.page = 1;
            [self.datas removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            [self.headerView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_photo]];
            
        } else {
            self.page ++;
        }
        if ((10*self.page) < model.count) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.datas addObjectsFromArray:model.data];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTDiscoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTDiscoverListCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PTDiscoverListCell" owner:nil options:nil].firstObject;
    }
    if (self.datas.count) {
        DataItem *item = [self.datas objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.indexPath = indexPath;
        if (item.is_in_like) {
            cell.CLICKMENUBLOCK = ^{
                NSArray * itemsArray = @[@"已点赞",@"评论"];
                return itemsArray;
            };
        } else {
            cell.CLICKMENUBLOCK = ^{
                NSArray * itemsArray = @[@"点赞",@"评论"];
                return itemsArray;
            };
        }
        
        cell.itemModel = item;
    }
    return cell;
}

/// 0删除 1点赞 2取消点赞 3评论
- (void)operateCellWithType:(NSInteger)operateType indexPath:(NSIndexPath *)indexPath {
    DataItem *item = [self.datas objectAtIndex:indexPath.row];
    if (operateType == 0) {
        [self alertSureCancle:@"提示" andSubTitle:@"是否确定删除" sureTitle:@"删除" cancleTitle:@"取消" sureCallBack:^{
            [PickHttpManager.shared requestPOST:API_FriendDelCircle withParam:@{
                @"id":item.id
            } withSuccess:^(id  _Nonnull obj) {
                [self.datas removeObject:item];
                [self.tableView reloadData];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        } cancleCallBack:^{
        }];
    } else if (operateType == 1) {
        [PickHttpManager.shared requestPOST:API_FriendLike withParam:@{
            @"c_id":item.id
        } withSuccess:^(id  _Nonnull obj) {
            item.is_in_like = YES;
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:item.in_like];
            [tempArr addObject:self.myModel.nickname];
            item.in_like = tempArr.mutableCopy;
            [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    } else if (operateType == 2) {
        [PickHttpManager.shared requestPOST:API_FriendLike withParam:@{
            @"c_id":item.id
        } withSuccess:^(id  _Nonnull obj) {
            item.is_in_like = NO;
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:item.in_like];
            [tempArr removeObject:self.myModel.nickname];
            item.in_like = tempArr.mutableCopy;
            [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    } else if (operateType == 3) {
        self.currentCommentItem = item;
        [self.inputView.textView becomeFirstResponder];
        [self.view bringSubviewToFront:self.inputView];
    }
}
- (void)addCommentMsg:(NSString *)msg {
    [PickHttpManager.shared requestPOST:API_FriendComment withParam:@{
        @"c_id":self.currentCommentItem.id,
        @"content":msg,
        @"record_id":self.currentCommentItem.id
    } withSuccess:^(id  _Nonnull obj) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.currentCommentItem.comment_list];
        Comment_listItem *com_item = [Comment_listItem new];
        com_item.comments = msg;
        com_item.nickname = self.myModel.nickname;
        [tempArr addObject:com_item];
        self.currentCommentItem.comment_list = tempArr;
        [self.tableView reloadRowAtIndexPath:[NSIndexPath indexPathForRow:[self.datas indexOfObject:self.currentCommentItem] inSection:0] withRowAnimation:UITableViewRowAnimationNone];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}
@end

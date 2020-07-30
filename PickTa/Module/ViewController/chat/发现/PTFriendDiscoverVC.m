//
//  PTFriendDiscoverVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTFriendDiscoverVC.h"
#import "PickTaFriendCircleModel.h"
#import "PickTaFriendDiscoverListCell.h"
@interface PTFriendDiscoverVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgCoverImg;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger page;
@end

@implementation PTFriendDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [NSMutableArray array];
    self.page = 1;
    self.nameLab.text = self.user_name;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:self.user_avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
}
- (void)setupUI {
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
        
    self.avatarImg.layer.cornerRadius = 6;
    self.avatarImg.layer.masksToBounds = YES;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 110;
    
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
    ///type:1我的朋友圈 2好友的朋友圈
    [SVProgressHUD showWithStatus:@"Loading"];
    [PickHttpManager.shared requestGET:API_FriendList withParam:@{
        @"friend_id":self.friend_id,
        @"type":@"2",
        @"page":@(self.page),
        @"limit":@"10"
    } withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD dismiss];
        if (self.page == 1) {
            self.page = 1;
            [self.datas removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            self.page ++;
        }
        PickTaFriendCircleModel *model = [PickTaFriendCircleModel modelWithJSON:obj];
        [self.datas addObjectsFromArray:model.data];
        [self.bgCoverImg sd_setImageWithURL:[NSURL URLWithString:model.cover_photo]];
        if ((10*self.page) < model.count) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:err.domain];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PickTaFriendDiscoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickTaFriendDiscoverListCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PickTaFriendDiscoverListCell" owner:nil options:nil].firstObject;
    }
    if (self.datas.count) {
        cell.itemModel = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    
}
@end

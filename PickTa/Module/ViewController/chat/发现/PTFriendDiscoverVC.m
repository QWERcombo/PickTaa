//
//  PTFriendDiscoverVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTFriendDiscoverVC.h"
#import "PickTaFriendCricleModel.h"
#import "PickTaFriendDiscoverListCell.h"
@interface PTFriendDiscoverVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgCoverImg;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation PTFriendDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [NSMutableArray array];
    
}
- (void)setupUI {
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    PTMyModel *myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    [self.bgCoverImg sd_setImageWithURL:[NSURL URLWithString:myModel.cover_photo]];
    self.avatarImg.layer.cornerRadius = 6;
    self.avatarImg.layer.masksToBounds = YES;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 110;
}
- (void)requestData {
    
    [PickHttpManager.shared requestGET:API_FriendFriendDetail withParam:@{
        @"friend_id":self.friend_id,
    } withSuccess:^(id  _Nonnull obj) {
        PickTaFriendCricleModel *model = [PickTaFriendCricleModel modelWithJSON:obj];
        [self.datas addObjectsFromArray:model.friend_cricle];
        self.nameLab.text = model.nickname;
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.head_portrait] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
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

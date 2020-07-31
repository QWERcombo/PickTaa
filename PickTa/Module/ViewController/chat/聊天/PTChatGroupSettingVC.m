//
//  PTChatGroupSettingVC.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatGroupSettingVC.h"
#import "PickTaGroupSettingModel.h"
#import "PTGroupMemberCell.h"
#import "PTChatGroupAllMemberVC.h"
#import "PTChatGroupNameVC.h"
#import "PTChatGroupNotesVC.h"
#import "PTChatSelectMemberVC.h"
@interface PTChatGroupSettingVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) PickTaGroupSettingModel *model;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation PTChatGroupSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群设置";
    self.datas = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(60, 95);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = (kScreenWidth-32-300)/4.f;
    flowLayout.sectionInset = UIEdgeInsetsMake(12, 16, 12, 16);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:PTGroupMemberCell.class forCellWithReuseIdentifier:@"PTGroupMemberCell"];
    [self.headerView addSubview:self.collectionView];
    
    [self requestData];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kUpdateInfoReload" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestData];
    }];
}

- (void)requestData {
    
    [PickHttpManager.shared requestPOST:API_ChatGroupInfo withParam:@{
        @"group_id":self.to_id
    } withSuccess:^(id  _Nonnull obj) {
        self.model = [PickTaGroupSettingModel modelWithJSON:obj];
        [self.datas addObjectsFromArray:[self.model.member_list subarrayWithRange:NSMakeRange(0, self.model.member_list.count>14?14:self.model.member_list.count)]];
        GroupMemberItemModel *item = [GroupMemberItemModel new];
        item.avatar = @"chat_icon_7";
        item.nickname = @"";
        [self.datas addObject:item];
        [self.collectionView reloadData];
        
        NSInteger row = self.datas.count%5==0?self.datas.count/5:(self.datas.count/5)+1;
        self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, (95*row)+24);
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth, (row*95)+12+16+(10*(row-1))+12+10+25);
        [self.tableView setTableHeaderView:self.headerView];
        
        self.groupName.text = self.model.name;
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PTGroupMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGroupMemberCell" forIndexPath:indexPath];
    GroupMemberItemModel *model = [self.datas objectAtIndex:indexPath.row];
    cell.user_name.text = model.nickname;
    if ([model.avatar hasPrefix:@"http"] || [model.avatar hasPrefix:@"https"]) {
        [cell.user_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    } else {
        cell.user_avatar.image = [UIImage imageNamed:model.avatar];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.datas.count-1) {
        PTChatSelectMemberVC *vc = [PTChatSelectMemberVC new];
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)showAllMemberClick:(UIButton *)sender {
    [self jumpToAllMemberVC:0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        /** 群名 */
        PTChatGroupNameVC *vc = [[PTChatGroupNameVC alloc] initWithNibName:@"PTChatGroupNameVC" bundle:nil];
        vc.text = self.model.name;
        vc.grp_id = self.to_id;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        /** 公告 */
        PTChatGroupNotesVC *vc = [[PTChatGroupNotesVC alloc] initWithNibName:@"PTChatGroupNotesVC" bundle:nil];
        vc.text = self.model.notice;
        vc.grp_id = self.to_id;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        /** 禁言 */
        [self jumpToAllMemberVC:1];
    } else if (indexPath.row == 4) {
        /** 删除 */
        [self jumpToAllMemberVC:2];
    } else if (indexPath.row == 5) {
        /** 退出群聊 */
        [self alertSureCancle:@"提示" andSubTitle:@"是否确定退出该群聊" sureTitle:@"退出" cancleTitle:@"取消" sureCallBack:^{
            [PickHttpManager.shared requestPOST:API_ChatGroupOut withParam:@{
                @"id":self.to_id
            } withSuccess:^(id  _Nonnull obj) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        } cancleCallBack:^{
        }];
    }
    
}
- (void)jumpToAllMemberVC:(NSInteger)type {
    PTChatGroupAllMemberVC *vc = [[PTChatGroupAllMemberVC alloc] initWithNibName:@"PTChatGroupAllMemberVC" bundle:nil];
    vc.model = self.model;
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}
@end

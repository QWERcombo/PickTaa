//
//  PTChatGroupAllMemberVC.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatGroupAllMemberVC.h"
#import "PTGroupMemberCell.h"
#import "PTChatSelectMemberVC.h"
@interface PTChatGroupAllMemberVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *deleteDatas;
@end

@implementation PTChatGroupAllMemberVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.type == 2) {
        for (GroupMemberItemModel *item in self.model.member_list) {
            item.isSelect = NO;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.type == 0) {
        self.title = @"群成员";
    } else if (self.type == 1) {
        self.title = @"群禁言";
    } else if (self.type == 2) {
        self.title = @"删除成员";
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"删除成员" forState:UIControlStateNormal];
        [addBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.frame = CGRectMake(0, 0, 60, 40);
        @weakify(self);
        [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (!self.deleteDatas.count) {
                [SVProgressHUD showErrorWithStatus:@"请选择群成员"];
                return;
            }
            [PickHttpManager.shared requestPOST:API_ChatGroupDel withParam:@{
                @"group_id":self.model.id,
                @"user_id":[self.deleteDatas modelToJSONString]
            } withSuccess:^(id  _Nonnull obj) {
                [SVProgressHUD showSuccessWithStatus:obj];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateInfoReload" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        }];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    }
    
    self.datas = [NSMutableArray array];
    self.deleteDatas = [NSMutableArray array];
    [self.collectionView registerClass:PTGroupMemberCell.class forCellWithReuseIdentifier:@"PTGroupMemberCell"];
    self.flowLayout.itemSize = CGSizeMake(60, 95);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = (kScreenWidth-32-300)/4.f;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(12, 16, 12, 16);
    
    [self.datas addObjectsFromArray:self.model.member_list];
    if (self.type == 0) {
        GroupMemberItemModel *item = [GroupMemberItemModel new];
        item.avatar = @"chat_icon_7";
        item.nickname = @"";
        [self.datas addObject:item];
    }
    [self.collectionView reloadData];
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
    
    if (self.type == 2) {
        cell.deleteBtn.hidden = !model.isSelect;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GroupMemberItemModel *itemModel = [self.datas objectAtIndex:indexPath.row];
    if (self.type == 0) {
        if (indexPath.row == self.datas.count-1) {
            PTChatSelectMemberVC *vc = [PTChatSelectMemberVC new];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (self.type == 1) {
        
        [PickHttpManager.shared requestPOST:[itemModel.is_allow boolValue]?API_ChatWordsRemove:API_ChatWords withParam:@{
            @"group_id":self.model.id,
            @"user_id":itemModel.id
        } withSuccess:^(id  _Nonnull obj) {
            [SVProgressHUD showSuccessWithStatus:obj];
            [self.navigationController popViewControllerAnimated:YES];
        } withFailure:^(NSError * _Nonnull err) {
            [SVProgressHUD showErrorWithStatus:err.domain];
        }];
    } else if (self.type == 2) {
        itemModel.isSelect = !itemModel.isSelect;
        if (itemModel.isSelect) {
            if (![self.deleteDatas containsObject:itemModel.id]) {
                [self.deleteDatas addObject:itemModel.id];
            }
        } else {
            if ([self.deleteDatas containsObject:itemModel.id]) {
                [self.deleteDatas removeObject:itemModel.id];
            }
        }
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
    
}

@end

//
//  PTHYDListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTHYDItemModel.h"
#import "PTHYDLevelItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHYDListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTHYDItemModel *> *data;
@property (nonatomic, copy) NSArray<PTHYDLevelItemModel *> *level_list;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic , copy) NSString *active_balance;  // 我的活跃度
@property (nonatomic, copy) NSString *base_active; // 基础活跃度
@property (nonatomic, copy) NSString *weight_active; // 加权活跃度
@property (nonatomic, copy) NSString *large_active; // 大区活跃度
@property (nonatomic, copy) NSString *small_active; // 小区活跃度
@property (nonatomic, copy) NSString *msg1; // 每推广一位实名用户：经验值+50
@property (nonatomic, copy) NSString *msg2; // 每发一条朋友圈，经验值+1（限每天第一条朋友圈）

@end

NS_ASSUME_NONNULL_END

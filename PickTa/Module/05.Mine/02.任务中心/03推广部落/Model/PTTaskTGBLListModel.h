//
//  PTTaskTGBLListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTTaskTGBLItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskTGBLListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTTaskTGBLItemModel *> *data;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSString *friend_num; // 好友人数
@property (nonatomic, strong) NSString *team_num;// 部落人数
@property (nonatomic, strong) NSString *active_unit;// 部落活跃度
@property (nonatomic, strong) NSString *real_num;// 实名好友
@property (nonatomic, strong) NSString *union_num;// 联盟人数
@property (nonatomic, strong) NSString *union_dou;// 部落分红
@property (nonatomic, strong) NSString *level_name;
@end

NS_ASSUME_NONNULL_END

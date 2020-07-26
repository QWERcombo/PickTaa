//
//  PTTaskTGBLItemModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskTGBLItemModel : PickTaBaseModel

@property (nonatomic, assign) BOOL is_auth; // 0未认证 1已认证
@property (nonatomic, strong) NSString *nickname; // 昵称
@property (nonatomic, strong) NSString *team_number;// 部落人数
@property (nonatomic, strong) NSString *level_name;
@property (nonatomic, strong) NSString *share_level;
@property (nonatomic, strong) NSString *user_level;
@end

NS_ASSUME_NONNULL_END

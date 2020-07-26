//
//  PTTgwItemModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTgwItemModel : PickTaBaseModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger f_id;
@property (nonatomic, copy) NSString *create_time;// 时间
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *status; // 0 未领取 1已领取 2兑换 3过期
@property (nonatomic, copy) NSString *number; // 数量
@property (nonatomic, copy) NSString *status_name; // 糖果home接口返回数据
@property (nonatomic, copy) NSString *code; // 兑换码    

@end

NS_ASSUME_NONNULL_END

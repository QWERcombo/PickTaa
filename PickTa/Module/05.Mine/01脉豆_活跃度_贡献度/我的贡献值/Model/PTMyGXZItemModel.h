//
//  PTMyGXZItemModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyGXZItemModel : PickTaBaseModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger chat_id;
@property (nonatomic, assign) NSInteger balance_type;
@property (nonatomic, assign) NSInteger tmp_user_id;
@property (nonatomic, copy) NSString *value; // 数量
@property (nonatomic, copy) NSString *created_time;// 时间
@property (nonatomic, copy) NSString *info; // 时间
@property (nonatomic, copy) NSString *now_value;
@property (nonatomic, assign) BOOL is_show;
@property (nonatomic, copy) NSString *real_value;
@property (nonatomic, copy) NSString *account_number;

@end

NS_ASSUME_NONNULL_END

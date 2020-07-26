//
//  PTTaskJZJSItemModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskJZJSItemModel : PickTaBaseModel

@property (nonatomic, assign) NSInteger id;
//@property (nonatomic, assign) NSInteger user_id;
//@property (nonatomic, assign) NSInteger f_id;
@property (nonatomic, copy) NSString *name; // 名称
@property (nonatomic, copy) NSString *condition; //     条件
@property (nonatomic, copy) NSString *bean; // 脉豆
@property (nonatomic, copy) NSString *activation; // 活跃度
@property (nonatomic, copy) NSString *times_receive; // 领取次数
@property (nonatomic, copy) NSString *daily; // 日产
@property (nonatomic, copy) NSString *date_term; // 有效期
@property (nonatomic, copy) NSString *created_at; //
@property (nonatomic, copy) NSString *updated_at; //
@property (nonatomic, copy) NSString *img; //

@end

NS_ASSUME_NONNULL_END

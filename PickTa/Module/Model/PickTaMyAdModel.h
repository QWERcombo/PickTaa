//
//  PickTaMyAdModel.h
//  PickTa
//
//  Created by 赵越 on 2020/7/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaMyAdModel : PickTaBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *comment_num;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_name;
@property (nonatomic, copy) NSString *is_top;
@property (nonatomic, copy) NSString *like_num;
@property (nonatomic, copy) NSString *like_reward;

@end

NS_ASSUME_NONNULL_END

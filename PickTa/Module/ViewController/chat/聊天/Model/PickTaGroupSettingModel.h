//
//  PickTaGroupSettingModel.h
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupMemberItemModel : PickTaBaseModel
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_allow;
@property (nonatomic, copy) NSString *is_manage;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isSelect;
@end

@interface PickTaGroupSettingModel : PickTaBaseModel

@property (nonatomic, copy) NSString *allowed_no;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_my;
@property (nonatomic, copy) NSString *is_word;
@property (nonatomic, copy) NSString *manage;
@property (nonatomic, copy) NSString *member;
@property (nonatomic, copy) NSArray<GroupMemberItemModel *> *member_list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *official;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_mobile;
@end

NS_ASSUME_NONNULL_END

//
//  PickTaGroupSettingModel.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaGroupSettingModel.h"

@implementation GroupMemberItemModel
@end

@implementation PickTaGroupSettingModel
- (void)setMember_list:(NSArray<GroupMemberItemModel *> *)member_list {
    _member_list = [NSArray modelArrayWithClass:GroupMemberItemModel.class json:member_list];
}
@end

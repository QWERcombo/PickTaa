//
//  PickTaFriendCricle.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaFriendCricleModel.h"

@implementation PTItemModel

@end

@implementation PickTaFriendCricleModel
- (void)setFriend_cricle:(NSArray<PTItemModel *> *)friend_cricle {
    _friend_cricle = [NSArray modelArrayWithClass:[PTItemModel class] json:friend_cricle];
}
@end

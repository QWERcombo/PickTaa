//
//  PickTaFriendCricle.h
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTItemModel : PickTaBaseModel
@property (nonatomic, copy) NSString *comment_num;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSArray<NSString *> *img;
@property (nonatomic, copy) NSString *like_num;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *user_avatar;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_name;
@end

@interface PickTaFriendCricleModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTItemModel *> *friend_cricle;
@property (nonatomic, copy) NSString *head_portrait;
@property (nonatomic, copy) NSString *my_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSArray<NSString *> *show_img;
@property (nonatomic, copy) NSString *total;
@end

NS_ASSUME_NONNULL_END

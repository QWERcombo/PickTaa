//
//  PickTaUserListModel.h
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaUserListModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              friend_id;
@property (nonatomic , copy) NSString              * my_id;
@property (nonatomic , copy) NSString              * nick_remark;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * to_head;
@property (nonatomic , copy) NSString              * status_name;
@property (nonatomic , copy) NSString              * to_mobile;
@property (nonatomic , copy) NSString              * to_nickname;
@property (nonatomic , assign) BOOL                 circle_auth;
@property (nonatomic , assign) BOOL                 side_auth;
@property (nonatomic , assign) BOOL                 isSelect;
@end

NS_ASSUME_NONNULL_END

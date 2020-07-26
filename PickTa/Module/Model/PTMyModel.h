//
//  PTMyModel.h
//  PickTa
//
//  Created by Stark on 2020/6/22.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger              pickID;
@property (nonatomic , copy) NSString              * account_number;
@property (nonatomic , copy) NSString              * nickname; // 昵称
@property (nonatomic , copy) NSString              * phone; // 手机号
@property (nonatomic , copy) NSString              * autograph;
@property (nonatomic , assign) NSInteger              parent_id;
@property (nonatomic , copy) NSString              * head_portrait;
@property (nonatomic , copy) NSString              * invitation_code; // 邀请码
@property (nonatomic , copy) NSString              * user_brief;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              user_level; // 会员等级 V1-V5
@property (nonatomic , assign) NSInteger              time;
@property (nonatomic , assign) NSInteger              last_login_time;
@property (nonatomic , copy) NSString              * last_login_ip;
@property (nonatomic , assign) NSInteger              my_id;
@property (nonatomic , copy) NSString              * cover_photo; // 相册封面
@property (nonatomic , copy) NSString              * cdn_balance; // 脉豆数
@property (nonatomic , copy) NSString              * id_show;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * open_id;
@property (nonatomic , copy) NSString              * weixin_info;
@property (nonatomic , assign) NSInteger              is_auth;
@property (nonatomic , assign) NSInteger              share_level; // 推广等级 1星 2星    
@property (nonatomic , assign) NSInteger              team_number;
@property (nonatomic , assign) NSInteger              team_level;
@property (nonatomic , copy) NSString              * register_ip;
@property (nonatomic , assign) NSInteger              is_block;
@property (nonatomic , assign) NSInteger              update_team_number;
@property (nonatomic , assign) NSInteger              error_times;
@property (nonatomic , assign) NSInteger              invite_receive;
@property (nonatomic , assign) NSInteger              is_realname;
@property (nonatomic , assign) NSInteger              sex;
@property (nonatomic , copy) NSString              * real_name;
@property (nonatomic , copy) NSString              * card_id;
@property (nonatomic , copy) NSString              * pairing_code;
@property (nonatomic , copy) NSString              * active_balance;
@property (nonatomic , assign) NSInteger              expe_num;
@property (nonatomic , copy) NSString              * team_active;
@property (nonatomic , copy) NSString              * active_weight;
@property (nonatomic , assign) NSInteger              is_machine;
@property (nonatomic , assign) NSInteger              country;
@property (nonatomic , assign) NSInteger              friend_update;

@property (nonatomic , copy) NSString              * tag;
//@property (nonatomic , copy) NSArray<NSString *> *tag;

@end

NS_ASSUME_NONNULL_END

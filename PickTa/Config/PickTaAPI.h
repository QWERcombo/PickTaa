//
//  PickTaAPI.h
//  PickTa
//
//  Created by Stark on 2020/6/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#ifndef PickTaAPI_h
#define PickTaAPI_h

// 1-0代表不需要此接口 1代表此接口已写调试完毕

#define API_BASE @"http://www.pickta.net" //

#define API_Login @"/api/user/login" // 1 登录
#define API_Register @"/api/user/register" // 1 注册
#define API_Sendsms @"/api/sendsms" // 1
#define API_Passwor @"/api/find_password" // 1
#define API_LoginCheck @"/api/user/login_check" // 1-0 登录校验获取随机数
#define API_LoginCode @"/api/user/login_code" // 1-0 登录校验
#define API_CodeFreshen @"/api/user/code_freshen" // 0 验证码刷新
#define API_PairingPost @"/api/user/pairing_post" // 0 配对提交
#define API_PairingHall @"/api/user/pairing_hall" // 0 配对大厅

#define API_UserHome @"/api/user/home" // 1 首页
#define API_AdvDiscover @"/api/advert/discover"
#define API_UserInfo @"/api/user/info" // 1 会员信息
#define API_userList @"api/friend/user_list" // 1 我的好友
#define API_CircleFriend @"/api/friend/list"
#define API_UserSHared @"/api/user/share" // 1 邀请好友
//#define API_Usershare @"/api/user/share" // 1 邀请好友
#define API_TaskCenter @"/api/user/tasks_center" // 1 任务中心

#define API_BriefSet @"/api/user/brief_set" // 1 设置简介
#define API_TagList @"/api/user/tag_list" // 0 标签列表
#define API_TagInfo @"/api/user/tag_info" // 0 标签点击查看详情
#define API_UserNameSet @"/api/user/username_set" // 0 设置昵称、性别，标签
#define API_UserEdit @"/api/user/edit" // 0 修改会员接口
#define API_UserEditPayPw @"/api/user/pay_password" // 1 修改交易密码
#define API_UserEditPw @"/api/user/password" // 0 修改登录密码
#define API_UserSetPayPw @"/api/user/set_pay_password" // 0 设置交易密码

#define API_Usersearch @"/api/user/search" // 0 get /api/user/search?content=55 get 搜索用户接口
#define API_Usersee @"/api/user/see" // 0 get /api/user/see?id=39 查看用户接口

//#define API_User @"/api/user/" // 0
//#define API_User @"/api/user/" // 0
//#define API_User @"/api/user/" // 0
//#define API_User @"/api/user/" // 0

#define API_Upload @"/api/upload" // 0 上传图片
#define API_UserCoverPhoto @"/api/user/cover_photo" // 0 更换相册封面
#define API_UserChangeAvatar @"/api/user/change_avatar" // 0 修改头像
#define API_UserUploadQrCode @"/api/user/contact_qrcode" // 0 上传二维码

#define API_UserMyActive @"/api/user/my_active" // 1 我的活跃度
#define API_UserMyExpe @"/api/user/my_expe" // 1 我的贡献值
#define API_UserMyContact @"/api/user/my_contact" // 0 我的社交
#define API_UserMyBean @"/api/user/my_bean" // 1 我的脉豆

// 糖果
#define API_AdvertCandyHouse @"/api/advert/candy_house" // 1 糖果屋
#define API_AdvertCandyReceive @"/api/advert/candy_receive" // 1 糖果屋-领取
#define API_AdvertCandyConvert @"/api/advert/candy_convert" // 1-0 糖果屋-兑换
#define API_AdvertCandyConvertNew @"/api/advert/candy_convert_new" // 0 糖果屋-兑换-新
// 卷轴
#define API_UserScrollMarket @"/api/user/scroll_market" // 1 卷轴集市
#define API_UserChangeMarketExchange @"/api/user/market_exchange" // 1 卷轴集市-兑换
#define API_TaskJZJS @"/api/user/scroll_market" // 1 卷轴集市-兑换
#define API_TaskJZDH @"/api/user/market_exchange" // 1 卷轴集市-兑换
// 推广部落
#define API_UserTeamTribes @"/api/user/team_tribes" // 1 推广部落

#define API_AdvertCollectCoupons @"/api/advert/collect_coupons" // 1-0 领券
#define API_AdvertCollectCouponsNew @"/api/advert/collect_coupons_new" // 0 领券-新

#define API_AdvertHitCall @"/api/advert/hit_call" // 0 打call
#define API_AdvertDiscover @"/api/advert/discover" // 0 发现
// 发布-广告
#define API_AdvertMyPublish @"/api/advert/my_publish" // 0 我的发布
#define API_AdvertPublish @"/api/advert/publish" // 0 发布广告
#define API_AdvertDiscoverDetail @"/api/advert/discover_detail" // 0 广告详情
#define API_AdvertPublishInfo @"/api/advert/publish_info" // 0 获取发布支付数量
#define API_AdvertRewardAvaert @"/api/advert/reward_avaert" // 0 广告打赏
#define API_AdvertMyPublishDel @"/api/advert/my_publish_del" // 0 删除

// 团队
#define API_UserTeam @"/api/user/team" // 0 团队接口
#define API_UserTeamUser @"/api/user/team_user" // 1-0 团队人员接口
#define API_UserTeamUserNew @"/api/user/team_user_new" // 0 团队人员接口-新
#define API_UserTeamUpgrade @"/api/user/team_upgrade" // 0 团队升级
#define API_UserGetTeamInfo @"/api/user/get_team_info" // 0 获取团队升级说明


#define API_UserRealCodeGet @"/api/user/real_code_get" // 0 实名认证获取语音验证码
#define API_UserRealCodeCheck @"/api/user/real_code_check" // 0 实名认证校验验证码
#define API_UserRealName @"/api/user/real_name" // 0 实名认证接口
#define API_FindPw @"/api/find_password" // 1 忘记密码


// 好友-聊天
#define API_FriendDelCircle @"/api/friend/friend_circle_del" // 0 删除朋友圈
#define API_FriendUserComplaint @"/api/friend/user_complaint" // 0 投诉
#define API_FriendDel @"/api/friend/friend_del" // 0 删除好友
#define API_FriendInfo @"/api/friend/friend_info" // 0 获取好友备注信息
#define API_FriendAppleList @"/api/friend/apply_list" // 0 申请列表
#define API_FriendApplyInfo @"/api/friend/apply_info" // 0 申请好友详情
#define API_FriendRemark @"/api/friend/remark" // 0 设置备注和标签
#define API_FriendForbidHim @"/api/friend/forbid_him" // 0 不看他
#define API_FriendForbidMe @"/api/friend/forbid_me" // 0 不让他看我
#define API_FriendJoinBlacklist @"/api/friend/join_blacklist" // 0 加入黑名单
#define API_FriendRejectUser @"/api/friend/reject_user" // 0 申请好友拒绝
#define API_FriendApproveUser @"/api/friend/approve_user" // 0 申请好友同意
#define API_FriendApply @"/api/friend/apply" // 0 申请好友-感兴趣

// 朋友圈
#define API_FriendCricleDetail @"/api/friend/cricle_detail" // 0 朋友圈单条记录详情
#define API_FriendUserReward @"/api/friend/user_reward" // 0 打赏
#define API_FriendLike @"/api/friend/like" // 0 用户点赞/取消
#define API_FriendComment @"/api/friend/comment" // 0 评论
#define API_FriendFriendDetail @"/api/friend/friend_detail" // 0 好友详情
#define API_FriendPublish @"/api/friend/publish" // 0 发布圈子
#define API_FriendMyList @"/api/friend/my_list" // 0 我的动态详情
#define API_FriendList @"/api/friend/list" // 0 发现 (异常)

// 默认分组
#define API_ @"/" // 0 推送数据 (1聊天数据 2加好友 3领取红包和转账)
#define API_ApiAppUpdate @"/api/app_update" // 0 更新接口
#define API_ApiAppNoteShow @"/api/note_show" // 0 公告接口
#define API_ApiHelpCenter @"/api/help_center" // 1 帮助中心
#define API_Api @"/api/app_update" // 0
#define API_Api @"/api/app_update" // 0
#define API_Api @"/api/app_update" // 0


#define API_UploadSignature @"/api/upload_signature" // 0 获取上传签名

// chat 群
#define API_RecordIndex @"/api/chat/record_index" // 1 聊天首页
#define API_ChatRecordEl @"/api/chat/record_el" // 0 聊天首页测试
#define API_ChatSend @"/api/chat/send" // 1 发送聊天
#define API_ChatRecordDel @"/api/chat/record_del" // 0 聊天删除
#define API_ChatRecordInfoDel @"/api/chat/record_info_del" // 0 聊天记录删除
#define API_ChatRecord @"/api/chat/record" // 1 获取聊天记录
//#define API_ChatRecord @"/api/chat/record"
#define API_ChatRemove @"/api/chat/remove" // 0 删除成员
// 红包 转账
#define API_ChatTransferDetail @"/api/chat/transfer_detail" // 0 获取转账详情
#define API_ChatReceiveStatistics @"/api/chat/receive_statistics" // 0 统计红包领取数量和金额
#define API_ChatReceiveRed @"/api/chat/receive_red" // 0 红包领取
#define API_ChatReceiveRedDetail @"/api/chat/receive_red_detail" // 0 红包详情
#define API_ChatReceiveRecord @"/api/chat/receive_record" // 0 获取红包记录
// 禁言
#define API_ChatWordsRemove @"/api/chat/remove_words" // 0 解除禁言
#define API_ChatWords @"/api/chat/words" // 0 禁言
// 群
#define API_ChatMyGroup @"/api/chat/my_group" // 0 我的群聊
#define API_ChatGroupOut @"/api/chat/group_out" // 0 /api/chat/group_out 退群
#define API_ChatGroupNameSet @"/api/chat/group_name_set" // 0 /api/chat/group_name_set 设置群名称
#define API_ChatGroupManagerSet @"/api/chat/group_manage_set" // 0 设置群管理员
#define API_ChatGroupDel @"/api/chat/group_del" // 0 删除群成员
#define API_ChatGroupInfo @"/api/chat/group_info" // 0 获取群成员和群信息
#define API_ChatGroupAdd @"/api/chat/group_add" // 0 group_add
#define API_ChatSetNotice @"/api/chat/set_notice" // 0 设置群公告


// 钱包 打赏
#define API_Userwallet @"/api/user/wallet" // 0 get /api/user/wallet get 钱包
#define API_Usercdnlist @"/api/user/cdn_list" // 0 get /api/user/cdn_list get 钱包明细
#define API_FriendRewardFcirst @"/api/friend/reward_first" // 0 get  get 打赏最近一条



#endif /* PickTaAPI_h */

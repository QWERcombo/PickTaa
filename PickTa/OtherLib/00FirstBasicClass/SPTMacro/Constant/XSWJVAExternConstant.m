//
//  XSWJVAExternConstant.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAExternConstant.h"

@implementation XSWJVAExternConstant

#pragma mark - Company Info

NSString * const kZYGSectionTypeKey = @"kZYGSectionTypeKey";
NSString * const kZYGSectionIndexKey = @"kZYGSectionIndexKey";
NSString * const kZYGSectionHeadKey = @"kZYGSectionHeadKey";
NSString * const kZYGSectionCellKey = @"kZYGSectionCellKey";
NSString * const kZYGSectionFootKey = @"kZYGSectionFootKey";

//NSInteger const kZYGResponseSuccessMes = 1;
NSString * const kZYGResponseSuccessMes = @"1";


// 客服电话
NSString * const kCustomerService = @"";
NSString * const kCustomerServicePhone = @"";

#pragma mark - Third Info

// Bugly配置信息
NSString * const kBuglyID = @"8285f2bf3b";// 足e购
NSString * const kBuglyAppKey = @"d79f22f8-8f3c-4a47-8e82-c4431aa3f3bc";// 足e购

// 友盟APPkey
NSString * const kUMAppkey = @"5e378cde4ff1593816e2642d";// 足e购

// 微信
NSString * const kWXAppKey = @"wxc5abcb45c2d1bb01";// 足e购
NSString * const kWXAppSecret = @"25dc5db4654dfdbcb66c9c58dea84f16";//  足e购
NSString * const kWXAppPartnerID = @"";

// 极光推送
NSString * const kJPushAppKey = @"08d9829acf69de878d9201cc";
NSString * const kJPushAppSecret = @"6a84898845a3a53271fd31d7";

#pragma mark - UserDefault Key

// 登录session 用户登录令牌
NSString * const kAuthSessionKey = @"AUTH_SESSION_KEY";
NSString * const kAuthUserIDKey = @"AUTH_USERID_KEY";
NSString * const kAuthInviteSignKey = @"AUTH_INVITESIGN_KEY";// invite_sign
NSString * const kAuthUserModelKey = @"AUTH_USERMODEL_KEY";
NSString * const kAuthUserDetailModelKey = @"AUTH_USERDETAILMODEL_KEY";

// 盐value
NSString * const kSaltValue = @"lyxy_vdolipxqfh924";// 足e购
//#define SALT @"lyxy_vdolipxqfh924"// 副app
//#define SALT @"lyxy_12lauysutkjan"// 主app

#pragma mark - 搜索

NSString * const kHotSearchKey = @"kHotSearchKey";



#pragma mark - 分页请求

NSString * const kPageIndexKey = @"page";
NSString * const kPageSizeKey = @"pagesize";
NSUInteger const kPageDefaultSizeValue = 10;

#pragma mark - Documents File

//Documents本地文件夹存储,以及DB名字, 创建DB和table，以及PhotoDoc, VideoDoc, AudioDoc,
//数据库文件夹目录,数据库名称
NSString * const kDBDocName = @"com.sanpintian.database";//#define DB_DOC_NAME  @"SPTDBDoc"
NSString * const kDBFileName = @"SPT";//#define DB_FILE_NAME @"SPT"

NSString * const kDataDoc = @"DataDoc";//NSData数据存储位置
NSString * const kImageDoc = @"ImageDoc";
NSString * const kVideoDoc = @"VideoDoc";
NSString * const kAudioDoc = @"AudioDoc";
NSString * const kThumbImgDoc = @"ThumbImgDoc";
NSString * const kTempDoc = @"TempDoc";

#pragma mark - Notification

NSString * const kNotificationLoginSuccess = @"LoginSuccessNotification";
NSString * const kNotificationPaySuccessGoods = @"NotificationPaySuccessGoods";
NSString * const kNotificationPaySuccessCourseVideo = @"NotificationPaySuccessCourseVideo";
NSString * const kNotificationPaySuccessGoodsFromMine = @"NotificationPaySuccessGoodsFromMine";


NSString * const kNoNetWork = @"暂无网络";
NSString * const kPaySuccess = @"支付成功";
NSString * const kPayFail = @"支付失败";

NSString * const kIapSandbox = @"https://sandbox.itunes.apple.com/verifyReceipt";
NSString * const kIapAppStore = @"https://buy.itunes.apple.com/verifyReceipt";

@end

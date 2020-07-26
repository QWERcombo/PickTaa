//
//  XSWJVAExternConstant.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XSWJVAExternConstant : NSObject

UIKIT_EXTERN NSString * const kZYGSectionTypeKey;
UIKIT_EXTERN NSString * const kZYGSectionIndexKey;
UIKIT_EXTERN NSString * const kZYGSectionHeadKey;
UIKIT_EXTERN NSString * const kZYGSectionCellKey;
UIKIT_EXTERN NSString * const kZYGSectionFootKey;

//UIKIT_EXTERN NSInteger const kZYGResponseSuccessMes;
UIKIT_EXTERN NSString * const kZYGResponseSuccessMes;




// 客服电话
UIKIT_EXTERN NSString * const kCustomerService;
UIKIT_EXTERN NSString * const kCustomerServicePhone;

// bugly
UIKIT_EXTERN NSString * const kBuglyID;
UIKIT_EXTERN NSString * const kBuglyAppKey;

// 友盟APPkey
UIKIT_EXTERN NSString * const kUMAppkey;

// 微信
UIKIT_EXTERN NSString * const kWXAppKey;
UIKIT_EXTERN NSString * const kWXAppSecret;
UIKIT_EXTERN NSString * const kWXAppPartnerID;

// 极光推送
UIKIT_EXTERN NSString * const kJPushAppKey;
UIKIT_EXTERN NSString * const kJPushAppSecret;

// 登录session 用户登录令牌
UIKIT_EXTERN NSString * const kAuthSessionKey;
UIKIT_EXTERN NSString * const kAuthUserIDKey;
UIKIT_EXTERN NSString * const kAuthInviteSignKey;
UIKIT_EXTERN NSString * const kAuthUserModelKey;
UIKIT_EXTERN NSString * const kAuthUserDetailModelKey;

// 盐value
UIKIT_EXTERN NSString * const kSaltValue;

UIKIT_EXTERN NSString * const kPageIndexKey;
UIKIT_EXTERN NSString * const kPageSizeKey;
UIKIT_EXTERN NSUInteger const kPageDefaultSizeValue;

#pragma mark - 搜索
UIKIT_EXTERN NSString * const kHotSearchKey;

//Documents本地文件夹存储,以及DB名字, 创建DB和table，以及PhotoDoc, VideoDoc, AudioDoc,
//数据库文件夹目录,数据库名称
UIKIT_EXTERN NSString * const kDBDocName;//#define kDBDocName  @"kDBDocName"
UIKIT_EXTERN NSString * const kDBFileName;//#define kDBFileName @"SPT"

UIKIT_EXTERN NSString * const kDataDoc;//NSData数据存储位置
UIKIT_EXTERN NSString * const kImageDoc;
UIKIT_EXTERN NSString * const kVideoDoc;
UIKIT_EXTERN NSString * const kAudioDoc;
UIKIT_EXTERN NSString * const kThumbImgDoc;
UIKIT_EXTERN NSString * const kTempDoc;

// 登录成功
UIKIT_EXTERN NSString * const kNotificationLoginSuccess;
UIKIT_EXTERN NSString * const kNotificationPaySuccessGoods;
UIKIT_EXTERN NSString * const kNotificationPaySuccessCourseVideo;
UIKIT_EXTERN NSString * const kNotificationPaySuccessGoodsFromMine;

// 文字描述
UIKIT_EXTERN NSString * const kNoNetWork;
UIKIT_EXTERN NSString * const kPaySuccess;
UIKIT_EXTERN NSString * const kPayFail;

// 苹果支付 沙盒测试环境验证以及正式环境
UIKIT_EXTERN NSString * const kIapSandbox;
UIKIT_EXTERN NSString * const kIapAppStore;

@end



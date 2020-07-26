//
//  Enums.h
//  Shop_Mall_Net_Market
//
//  Created by SOPOCO_ljt on 2018/8/20.
//  Copyright © 2018 ************ Information Service Co., Ltd. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

#import <Foundation/Foundation.h>

#define kNotificationLoginIn @"kNotificationLoginIn" // 登录成功
#define kNotificationLoginOut @"kNotificationLoginOut" // 退出成功
#define kNotificationRefreshUserInfo @"kNotificationRefreshUserInfo" // 刷新个人信息
#define kNotificationPaySuccess @"kPaySuccessNotification"
#define kNotificationPaySFail @"kPayFailNotification"
#define kNotificationShouHoushenqingSuccess @"kOrderShouhoushenqingSuccessNotification"


//typedef NS_ENUM(NSInteger, SPTGoodsListType) {
//    SPTGoodsListTypeNone, // 无参数
//    SPTGoodsListType,// 所有商品 商品分类
//};

typedef NS_ENUM(NSInteger, ZYGUserType) {
    ZYGUserTypeUnknown = 0,
    ZYGUserTypeB = 1, // B
    ZYGUserTypeA = 2, // A
};

typedef NS_ENUM(NSInteger, SPTPinglunListType) {
    SPTPinglunListTypeNone,
    SPTPinglunListTypeGoods,// 商品
    SPTPinglunListTypeNews,// 新闻
    SPTPinglunListTypeCourse, // 课程
};


// 店铺状态： 0关闭，1正常开启，2审核中
typedef NS_ENUM(NSInteger, SPTStoreState) {
    SPTStoreStateClose,
    SPTStoreStateNormalOpen,
    SPTStoreStateInReview,
};

// 促销类型： 0:无促销 1:抢购 2:限时折扣
typedef NS_ENUM(NSInteger, SPTPromotionType) {
    SPTPromotionTypeNone,
    SPTPromotionTypeRuseToPurchase,
    SPTPromotionTypeDiscount
};
    
typedef NS_ENUM(NSInteger, ZYGShouyiTongjiType) {
    ZYGShouyiTongjiTypeDay=1, // 日销售额
    ZYGShouyiTongjiTypeMonth=2, // 月销售额
};

typedef NS_ENUM(NSInteger, ZYGMyKehuViewType) {
    ZYGMyKehuViewTypeMonth=1, // 本月用户
    ZYGMyKehuViewTypeLeiji=2, // 累计用户
};

// 发送手机验证码
typedef NS_ENUM(NSInteger, SPTRegisterPictureType) {
    SPTRegisterPictureTypeNone,// 注册
    SPTRegisterPictureTypeYingyezhizhao,// 营业执照
    SPTRegisterPictureTypeDianmianmentou,//店面门头
    SPTRegisterPictureTypeCarddiZhengmian,//身份证正面
    SPTRegisterPictureTypeCarddiFanmian,//身份证背面
};

// 发送手机验证码
typedef NS_ENUM(NSInteger, SPTPhoneCodeType) {
    SPTPhoneCodeTypeRegister=1,// 注册
    SPTPhoneCodeTypeLogin=2,// 登录
    SPTPhoneCodeTypeFindPassword=3// 找回密码
};

typedef NS_ENUM(NSInteger, SPTWuliuType) {
    SPTWuliuTypeHaveTitle,
    SPTWuliuTypeNoHaveTitle,
};

typedef NS_ENUM(NSInteger, SPTHuoDongType) {
    SPTHuoDongTypeMiaoSha = 1, //秒杀
    SPTHuoDongTypeTeJia = 2,//特价
    SPTHuoDongTypePinTuan = 3,//拼团
    SPTHuoDongTypeMaiZeng = 4,//买赠
    SPTHuoDongTypeCategory = 5,// 分类
};

typedef NS_ENUM(NSInteger, SPOrderStatu) {
    SPOrderStatuAll, //全部
    SPOrderStatuDaifukuai,//待付款
    SPOrderStatuDaifahuo,//待发货
    SPOrderStatuDaishouhuo,//待收货 
    SPOrderStatuDaipingjia,//待评价
    SPOrderStatuTuihuanShouhou,//退换售后 SPOrderStatuJiaoYiChenggong,//交易成功
    SPOrderStatuJiaoYiGuanbi,//交易关闭
    SPOrderStatuOrderDelete,//订单删除
    SPOrderStatuUnKnow
};

// 类别（默认全部 1申请 2处理中 3完成）
typedef NS_ENUM(NSInteger, SPOrderRefundStatu) {
    SPOrderRefundStatuAll = 0,
    SPOrderRefundStatuWeiShenqing = 1,
    SPOrderRefundStatuChuliZhong = 2,
    SPOrderRefundStatuWancheng = 3,
    SPOrderRefundStatuUnKnow
};

// （1:待审核,2:同意,3:不同意） 当SPOrderRefundStatu为3完成时，使用此字段
typedef NS_ENUM(NSInteger, SPOrderSellerState) {
    SPOrderSellerStateAll = 0,
    SPOrderSellerStateDaishenke = 1,
    SPOrderSellerStateTongyi = 2,
    SPOrderSellerStateButongyi = 3,
    SPOrderSellerStateUnKnow
};

// 类别（默认全部 1退款 2退货 3维修）
typedef NS_ENUM(NSInteger, SPOrderRefundType) {
    SPOrderRefundTypeAll = 0,
    SPOrderRefundTypeTuikuan = 1,
    SPOrderRefundTypeTuihuo = 2,
    SPOrderRefundTypeWeixiu = 3,
    SPOrderRefundTypeUnKnow
};

typedef NS_ENUM(NSInteger, SPOrderCourseStatu) {
    SPOrderCourseStatuCancel = 0, // 已取消
    SPOrderCourseStatuDaifukuan = 10,//待付款 未付款
    SPOrderCourseStatuYifukuan = 20,// 已付款
    SPOrderCourseStatuUnKnow
};


typedef NS_ENUM(NSInteger, ZYGPayType) {
    ZYGPayTypeWeiXin,
    ZYGPayTypeAli,
    ZYGPayTypeYinlian,
    ZYGPayTypeApple
};

// 平台
typedef NS_ENUM(NSInteger, BFZLPlatform) {
    BFZLPlatformIOS = 0,
    BFZLPlatformAndroid = 1,
};

// 顺序：1=正序；2=倒序
typedef NS_ENUM(NSInteger, BFZLSequenceType) {
    BFZLSequenceTypeAsc = 1,//正序 升序
    BFZLSequenceTypeDesc = 2,//倒序
};

// 角色区分
typedef NS_ENUM(NSInteger, BFZLRole) {
    BFZLRole0 = 0,//
    BFZLRole1 = 1,//
};

// 账户状态
typedef NS_ENUM(NSInteger, BFZLAccountStatus) {
    BFZLAccountStatusNormal = 0,
    BFZLAccountStatus1 = 1,
    BFZLAccountStatus2 = 2 //
};

// 性别
typedef NS_ENUM(NSInteger, SPTGender) {
    SPTGenderDefault = 0,// 未知
    SPTGenderMan = 1,// 男
    SPTGenderWomen = 2,// 女
};

//订单状态
typedef NS_ENUM(NSInteger, BFZLOrderStatus) {
    BFZLOrderStatusUndefine = 10,
    BFZLOrderStatusPies = 100,//派单中-
    BFZLOrderStatusWaitForService = 190,//待服务-
    BFZLOrderStatusServicingNoBeginServce = 200,//待服务-
    BFZLOrderStatusServicingBeginServce = 210,//服务中-
    BFZLOrderStatusServicingStartPay = 220,//服务中-
    BFZLOrderStatusServicedPaymentsDue = 300,//待支付-订单已完成-"结束服务"
    BFZLOrderStatusServicedPaymentsMade = 310,//冻结(待支付)-订单已完成-"支付成功"
    BFZLOrderStatusCanceled = 320,//订单已取消-"取消订单"
    BFZLOrderStatusPiesFail = 330,//订单已完成-"派单失败"
    BFZLOrderStatusClosed = 400,//订单关闭。
    BFZLOrderStatusError = 1000,
};

// 订单类型
typedef NS_ENUM(NSInteger, BFZLOrderType) {
    BFZLOrderTypeNoknow = 0, // 不清楚订单状态
    BFZLOrderTypeRealTime = 1,// 实时订单 1
    BFZLOrderTypeAppointment = 2,// 预约订单 2
};

//分页请求
typedef NS_ENUM(NSInteger, BFZLPageStyle) {
    BFZLPageStyleInitial = 0,//初始化，最初没有数据
    BFZLPageStyleRich = 1//已有数据
};

// 评价-服务结束并且已经付款的订单(BFZLOrderStatusServiced-->BFZLOrderPayStatusPaymentsMade-->)，乘客才能评价。
// 评价状态是否已经评价
typedef NS_ENUM(NSInteger, BFZLOrderEvaluateStatus) {
    BFZLOrderEvaluateStatusNotEvaluate = 0,// 未评价
    BFZLOrderEvaluateStatusEvaluated = 1,// 已评价
};

// 乘客对订单评价
typedef NS_ENUM(NSInteger, BFZLOrderEvaluateGrade) {
    BFZLOrderEvaluateGradeUndefine = 0,
    BFZLOrderEvaluateGradePositive = 1,// 好评
    BFZLOrderEvaluateGradeMedium = 2,// 中评
    BFZLOrderEvaluateGradeNegative = 3// 差评
};

// 是否开具发票 0 未开票 1开票中 2 开票成功
typedef NS_ENUM(NSInteger, BFZLInvoiceStatus) {
    BFZLInvoiceStatusNoOpen = 0,
    BFZLInvoiceStatusOpening = 1,
    BFZLInvoiceStatusOpened = 2,
    BFZLInvoiceStatusError = 1000,
};

typedef NS_ENUM(NSInteger, BFZLPassengerOperationStatus) {
    BFZLPassengerOperationStatusUndefine = 0,
    BFZLPassengerOperationStatusCityNotOpen = 1, //没有开启城市
    BFZLPassengerOperationStatusLocationNotOpen = 2, //没有开启定位
};

////支付状态-服务结束的订单(BFZLOrderStatusServiced)
//typedef NS_ENUM(NSInteger, BFZLOrderPayStatus) {
//    BFZLOrderPayStatusPaymentsDue = 5,//未支付
//    BFZLOrderPayStatusPaymentsMade = 6//已支付
//};


#endif /* Enums_h */

//
//  PTChatRedPacketCreateVC.h
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatRedPacketCreateVC : PickTaBaseViewController
@property (nonatomic,strong) NSString *type;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) void(^completeRedBlock)(NSString *money,NSString *count,NSString *msg,NSString *paypsd);

@end

NS_ASSUME_NONNULL_END

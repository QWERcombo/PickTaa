//
//  PTExchangeVC.h
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTExchangeVC : PickTaBaseViewController
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void(^completeExchangeBlock)(NSString *money, NSString *paypsd);
@end

NS_ASSUME_NONNULL_END

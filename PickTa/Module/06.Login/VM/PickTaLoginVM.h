//
//  PickTaLoginVM.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaLoginVM : PickTaBaseViewModel

// 请求登录 (如果需要拿到API参数)需要使用
@property (nonatomic, strong) RACCommand *loginCommand;
// 登录需要的参数
@property (nonatomic,strong) NSDictionary *loginParam;

@end

NS_ASSUME_NONNULL_END

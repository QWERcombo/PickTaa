//
//  PickTaLoginVM.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaForgetVM : PickTaBaseViewModel

// 请求登录 (如果需要拿到API参数)需要使用
@property (nonatomic, strong) RACCommand *loginCommand;
// 登录需要的参数
@property (nonatomic,strong) NSDictionary *loginParam;
// 请求修改密码 (如果需要拿到API参数)需要使用
@property (nonatomic, strong) RACCommand *forgetCommand;
// 获取注册参数
@property (nonatomic,strong) NSDictionary *forgetParam;
@end

NS_ASSUME_NONNULL_END

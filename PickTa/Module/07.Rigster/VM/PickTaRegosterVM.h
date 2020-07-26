//
//  PickTaRegosterVM.h
//  PickTa
//
//  Created by sgq on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaRegosterVM : PickTaBaseViewModel

// 请求验证码 (如果需要拿到API参数)需要使用
@property (nonatomic, strong) RACCommand *loginCommand;
// 获取验证码需要的参数
@property (nonatomic,strong) NSDictionary *loginParam;

// 请求注册 (如果需要拿到API参数)需要使用
@property (nonatomic, strong) RACCommand *completeCommand;
// 获取注册参数
@property (nonatomic,strong) NSDictionary *completeParam;

// 标签列表
@property (nonatomic, strong) RACCommand *tagCommand;
// 获取注册参数
@property (nonatomic,strong) NSDictionary * _Nullable tagParam;

@end

NS_ASSUME_NONNULL_END

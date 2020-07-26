//
//  PTModifyLoginPwVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTModifyLoginPwVM : PickTaBaseViewModel

// 修改登录密码
@property (nonatomic, strong) RACCommand *command1;
@property (nonatomic, strong) NSDictionary *param1;

// 修改交易密码
@property (nonatomic, strong) RACCommand *command2;
@property (nonatomic, strong) NSDictionary *param2;

@end

NS_ASSUME_NONNULL_END

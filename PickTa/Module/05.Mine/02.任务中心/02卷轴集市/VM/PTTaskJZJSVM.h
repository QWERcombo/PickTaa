//
//  PTTaskJZJSVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTTaskJZJSListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskJZJSVM : PickTaBaseViewModel

// 卷轴集市 /api/user/scroll_market
@property (nonatomic, strong) RACCommand *command1;
@property (nonatomic, strong) NSDictionary *param1;

// 卷轴集市-兑换
@property (nonatomic,strong) RACCommand *command2;
@property (nonatomic, strong) NSDictionary *param2;

@end

NS_ASSUME_NONNULL_END

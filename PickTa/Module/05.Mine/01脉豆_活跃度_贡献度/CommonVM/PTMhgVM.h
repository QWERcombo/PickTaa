//
//  PTMhgVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTMyBeanListModel.h"
#import "PTMyGXZListModel.h"
#import "PTHYDListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMhgVM : PickTaBaseViewModel

// 我的脉豆
@property (nonatomic, strong) RACCommand *myBean;
@property (nonatomic, strong) NSDictionary *param1; // 需要的参数

// 我的贡献值
@property (nonatomic, strong) RACCommand *myGX;
@property (nonatomic, strong) NSDictionary *param2;

// 我的活跃度
@property (nonatomic, strong) RACCommand *myHYD;
@property (nonatomic, strong) NSDictionary *param3;

@end

NS_ASSUME_NONNULL_END

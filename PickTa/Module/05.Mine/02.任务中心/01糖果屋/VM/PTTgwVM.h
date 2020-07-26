//
//  PTTgwVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTTgwListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTgwVM : PickTaBaseViewModel

// 糖果屋candyHouse
@property (nonatomic,strong) RACCommand *command1;
@property (nonatomic, strong) NSDictionary *param1;

// 糖果屋-兑换
@property (nonatomic,strong) RACCommand *command2;
@property (nonatomic, strong) NSDictionary *param2;

// 糖果屋-领取
@property (nonatomic,strong) RACCommand *command3;
@property (nonatomic, strong) NSDictionary *param3;


@end

NS_ASSUME_NONNULL_END

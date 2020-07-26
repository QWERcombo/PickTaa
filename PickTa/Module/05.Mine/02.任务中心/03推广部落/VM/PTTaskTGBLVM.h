//
//  PTTaskTGBLVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTTaskTGBLListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskTGBLVM : PickTaBaseViewModel

// 推广部落 /api/user/team_tribes
@property (nonatomic, strong) RACCommand *command1;
@property (nonatomic, strong) NSDictionary *param1;

@end

NS_ASSUME_NONNULL_END

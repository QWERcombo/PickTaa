//
//  PTHelpCenterVM.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTHelpCenterListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHelpCenterVM : PickTaBaseViewModel

// 帮助中心
@property (nonatomic, strong) RACCommand *command1;
@property (nonatomic, strong) NSDictionary *param1;

@end

NS_ASSUME_NONNULL_END

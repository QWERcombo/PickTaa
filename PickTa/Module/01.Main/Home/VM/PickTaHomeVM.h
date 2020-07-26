//
//  PickTaHomeVM.h
//  PickTa
//
//  Created by Stark on 2020/6/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "DHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaHomeVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *userHomeCommand;
@end

NS_ASSUME_NONNULL_END

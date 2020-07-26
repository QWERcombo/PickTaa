//
//  PTTaskVM.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *taskCommand;
@end

NS_ASSUME_NONNULL_END

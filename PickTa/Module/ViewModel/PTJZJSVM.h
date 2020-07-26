//
//  PTJZJSVM.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PickTaJZJSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTJZJSVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *jzjsCommand;
@end

NS_ASSUME_NONNULL_END

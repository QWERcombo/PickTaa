//
//  PickTaCallVM.h
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PickTaAdvDiscoverModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PickTaCallVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *advDisCommand;
@property (nonatomic,strong) PickTaAdvDiscoverModel *disCoverModel;

@end

NS_ASSUME_NONNULL_END

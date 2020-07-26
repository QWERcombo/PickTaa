//
//  PickTaCircleFriendVM.h
//  PickTa
//
//  Created by Stark on 2020/6/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PickTaFriendCircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaCircleFriendVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *friendCircleCommand;
@end

NS_ASSUME_NONNULL_END

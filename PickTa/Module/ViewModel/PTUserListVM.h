//
//  PTUserListVM.h
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PickTaUserListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTUserListVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *userListCommand;
@end

NS_ASSUME_NONNULL_END

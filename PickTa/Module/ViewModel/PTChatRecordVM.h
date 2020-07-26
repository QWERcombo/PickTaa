//
//  PTChatRecordVM.h
//  PickTa
//
//  Created by Stark on 2020/6/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTChatRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatRecordVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *chatRecordCommand;
@end

NS_ASSUME_NONNULL_END

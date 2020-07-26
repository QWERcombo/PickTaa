//
//  PTChatRecordContentVM.h
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTChatRecordContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatRecordContentVM : PickTaBaseViewModel
@property (nonatomic,strong) NSDictionary *fetchContentParam;
@property (nonatomic,strong) RACCommand *recordContentCommand;
@property (nonatomic,strong) RACCommand *recordSendCommand;
@end

NS_ASSUME_NONNULL_END

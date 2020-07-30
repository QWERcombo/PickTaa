//
//  PTChatSearchVC.h
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatSearchVC : PickTaBaseViewController
/// 1.好友 2.群聊
@property (nonatomic, assign) NSInteger searchType;
@end

NS_ASSUME_NONNULL_END

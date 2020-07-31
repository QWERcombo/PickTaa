//
//  PTChatGroupAllMemberVC.h
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "PickTaGroupSettingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PTChatGroupAllMemberVC : PickTaBaseViewController
@property (nonatomic, strong) PickTaGroupSettingModel *model;
/// 0全部 1禁言 2删除
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END

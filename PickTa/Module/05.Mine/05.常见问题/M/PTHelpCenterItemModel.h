//
//  PTHelpCenterItemModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHelpCenterItemModel : PickTaBaseModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *desc; // 描述

@end

NS_ASSUME_NONNULL_END

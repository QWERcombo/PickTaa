//
//  PTHelpCenterListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTHelpCenterItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHelpCenterListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTHelpCenterItemModel *> *data;

@end

NS_ASSUME_NONNULL_END

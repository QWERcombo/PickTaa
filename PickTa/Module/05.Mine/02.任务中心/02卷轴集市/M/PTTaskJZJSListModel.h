//
//  PTTaskJZJSListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTTaskJZJSItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskJZJSListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTTaskJZJSItemModel *> *data;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) BOOL is_dui;  // 0未兑换 1已兑换    

@end

NS_ASSUME_NONNULL_END

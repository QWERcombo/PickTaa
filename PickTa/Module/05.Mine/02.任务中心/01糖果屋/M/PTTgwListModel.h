//
//  PTTgwListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTTgwItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTgwListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTTgwItemModel *> *data;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic , copy) NSString *un_receive;  // 待领取糖果
 
@end

NS_ASSUME_NONNULL_END

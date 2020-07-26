//
//  PTMyGXZListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTMyGXZItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyGXZListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTMyGXZItemModel *> *data;
//@property (nonatomic , assign) CGFloat bean_balance;
@property (nonatomic , copy) NSString *expe_num; // 贡献值    
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END

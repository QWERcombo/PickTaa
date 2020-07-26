//
//  PTMyBeanListModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"
#import "PTMyBeanItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyBeanListModel : PickTaBaseModel

@property (nonatomic, copy) NSArray<PTMyBeanItemModel *> *data;
//@property (nonatomic , assign) CGFloat bean_balance;
//@property (nonatomic , assign) CGFloat bean_today;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, copy) NSString *bean_balance;               // 我的脉豆
@property (nonatomic, copy) NSString *bean_today;               // 今日所得


@end

NS_ASSUME_NONNULL_END

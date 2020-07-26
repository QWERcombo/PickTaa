//
//  PTProblemVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "YUFoldingTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTProblemVC : PickTaBaseViewController  <YUFoldingTableViewDelegate>

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END

//
//  PTTaskStatusBaseVC.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "PTTaskCell.h"
#import "PTTaskVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskStatusBaseVC : PickTaBaseViewController
@property (nonatomic,strong)PTTaskVM *taskVM;
@end

NS_ASSUME_NONNULL_END

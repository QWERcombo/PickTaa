//
//  PTMyProfileInfoVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/11.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "PTMyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyProfileInfoVC : PickTaBaseViewController

@property (nonatomic, strong) PTMyModel *myModel;
- (IBAction)submitBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END

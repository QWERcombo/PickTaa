//
//  PTUserSharedVC.h
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTUserSharedVC : PickTaBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *sharedCode;
@property (weak, nonatomic) IBOutlet UIImageView *sharedImg;
@property (weak, nonatomic) IBOutlet UIButton *sharedCodeCopy;

@end

NS_ASSUME_NONNULL_END

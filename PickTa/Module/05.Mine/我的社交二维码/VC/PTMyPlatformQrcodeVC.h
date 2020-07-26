//
//  PTMyPlatformQrcodeVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyPlatformQrcodeVC : PickTaBaseViewController

@property (assign, nonatomic) NSInteger tag;

@property (weak, nonatomic) IBOutlet UIView *qrBgView;
@property (weak, nonatomic) IBOutlet UILabel *qrWarnLbl;
@property (weak, nonatomic) IBOutlet UIImageView *qrImgView;
@property (weak, nonatomic) IBOutlet UIButton *qrSelectBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@end

NS_ASSUME_NONNULL_END

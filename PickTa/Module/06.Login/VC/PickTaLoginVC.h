//
//  PickTaLoginVC.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaLoginVC : PickTaBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *loginTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *pswLbl;
@property (weak, nonatomic) IBOutlet UILabel *noRigsterLbl;


@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *psw;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *registers;
@property (weak, nonatomic) IBOutlet UIButton *passwork;

@end

NS_ASSUME_NONNULL_END

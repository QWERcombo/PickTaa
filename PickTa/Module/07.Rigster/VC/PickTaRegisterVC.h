//
//  PickTaRegisterVC.h
//  PickTa
//
//  Created by sgq on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "JKCountDownButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface PickTaRegisterVC : PickTaBaseViewController
@property (strong, nonatomic)  UIButton *closeBtn;
@property (strong, nonatomic)  UIImageView *imageBr;
@property (strong, nonatomic)  UILabel *descriptionLab;
@property (strong, nonatomic)  UILabel *phoneLab;
@property (strong, nonatomic)  UITextField *phoneTxt;
@property (strong, nonatomic)  UILabel *codeLab;
@property (strong, nonatomic)  UITextField *codeTxt;
@property (strong, nonatomic)  JKCountDownButton *obtainCodeBtn;
@property (strong, nonatomic)  UILabel *passLab;
@property (strong, nonatomic)  UITextField *passTxt;
@property (strong, nonatomic)  UILabel *passAgainLab;
@property (strong, nonatomic)  UITextField *passAgainTxt;
@property (strong, nonatomic)  UILabel *transacLab;
@property (strong, nonatomic)  UITextField *transacTxt;
@property (strong, nonatomic)  UILabel *transacAgainLab;
@property (strong, nonatomic)  UITextField *transacAgainTxt;
@property (strong, nonatomic)  UILabel *invitationLab;
@property (strong, nonatomic)  UITextField *invitationTxt;
@property (strong, nonatomic)  UIButton *checkBtn;
@property (strong, nonatomic)  UIButton *jumpBtn;
@property (strong, nonatomic)  UIButton *completeBtn;
@property (strong, nonatomic)  UIButton *loginBtn;
@property (strong, nonatomic)  UILabel *welabel;
@property (strong, nonatomic)  UILabel *longinLab;

@end

NS_ASSUME_NONNULL_END

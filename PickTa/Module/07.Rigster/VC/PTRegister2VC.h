//
//  PTRegister2VC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTRegister2VC : PickTaBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *nikeNameLbl;
@property (weak, nonatomic) IBOutlet UITextField *genderTfl;


@property (weak, nonatomic) IBOutlet UILabel *genderTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderMenTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderWomenTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *genderManBtn;
@property (weak, nonatomic) IBOutlet UIImageView *genderManSelectImg;
- (IBAction)onGenderMenBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *genderWomenBtn;
@property (weak, nonatomic) IBOutlet UIImageView *genderWomenSelectImg;
- (IBAction)onGenderWomenBtnAction:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)onNextBtnAction:(UIButton *)sender;



@end

NS_ASSUME_NONNULL_END

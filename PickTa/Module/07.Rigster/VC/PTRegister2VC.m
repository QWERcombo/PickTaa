//
//  PTRegister2VC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTRegister2VC.h"
#import "PTRegister3VC.h"

@implementation PTRegister2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarShadowImageHidden:YES];
    _genderManSelectImg.hidden = NO;
    _genderWomenSelectImg.hidden = YES;
    
    self.nikeNameLbl.text = kLocalizedString(@"nickname", @"昵称");
    self.genderTfl.placeholder = kLocalizedString(@"input_nickName", @"请输入您的昵称");

    self.genderTitleLbl.text = kLocalizedString(@"select_gender", @"请选择您的性别");
    self.genderMenTitleLbl.text = kLocalizedString(@"men", @"男");
    self.genderWomenTitleLbl.text = kLocalizedString(@"women", @"女");
    [self.nextBtn setTitle:kLocalizedString(@"next", @"下一步") forState:UIControlStateNormal];
}

- (IBAction)onNextBtnAction:(UIButton *)sender {
    if (String_IsEmpty(self.genderTfl.text)) {
        [self.view makeToast:@"请输入您的昵称" duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }
    
    PTRegister3VC *vc = [[PTRegister3VC alloc] init];
    vc.nickname = self.genderTfl.text;
    
    if (_genderManSelectImg.hidden == NO) {
        vc.sex = @"1";
    } else {
        vc.sex = @"2";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onGenderWomenBtnAction:(id)sender {
    _genderManSelectImg.hidden = YES;
    _genderWomenSelectImg.hidden = NO;
}

- (IBAction)onGenderMenBtnAction:(id)sender {
    _genderManSelectImg.hidden = NO;
    _genderWomenSelectImg.hidden = YES;
}

@end

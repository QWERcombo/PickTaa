//
//  PickTaTaskVC.m
//  PickTa
//
//  Created by Stark on 2020/6/18.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaTaskVC.h"

@interface PickTaTaskVC ()

@end

@implementation PickTaTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

-(void)setupUI{
    
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.pleaseBtn.layer.borderWidth = 1;
    self.pleaseBtn.layer.cornerRadius = 10;
    self.pleaseBtn.layer.borderColor = MainBlueColor.CGColor;
    self.pleaseBtn.layer.masksToBounds = YES;
    
    
    [[self.pleaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"login_logo"] status:@"敬请期待"];
        [SVProgressHUD dismissWithDelay:1];
    }];
    

}


@end

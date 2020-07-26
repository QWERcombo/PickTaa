//
//  PTMyPlatformTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/11.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyPlatformTVC.h"
#import "PTMyPlatformQrcodeVC.h"

@implementation PTMyPlatformTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView1.layer.masksToBounds = YES;
    self.bgView2.layer.masksToBounds = YES;
    self.bgView3.layer.masksToBounds = YES;
    self.bgView4.layer.masksToBounds = YES;
    self.bgView5.layer.masksToBounds = YES;
    self.bgView6.layer.masksToBounds = YES;
    self.bgView7.layer.masksToBounds = YES;
    self.bgView8.layer.masksToBounds = YES;
    
    self.titleLbl1.text = kLocalizedString(@"platform_1", @"Pick Ta");
    self.titleLbl2.text = kLocalizedString(@"platform_2", @"Wechat");
    self.titleLbl3.text = kLocalizedString(@"platform_3", @"QQ");
    self.titleLbl4.text = kLocalizedString(@"platform_4", @"Telegram");
    self.titleLbl5.text = kLocalizedString(@"platform_5", @"Facebook");
    self.titleLbl6.text = kLocalizedString(@"platform_6", @"Twitter");
    self.titleLbl7.text = kLocalizedString(@"platform_7", @"What's app");
    self.titleLbl8.text = kLocalizedString(@"platform_8", @"Others");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 @property (weak, nonatomic) IBOutlet UIView *bgView1;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView1;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl1;
 @property (weak, nonatomic) IBOutlet UIButton *btn1;

 @property (weak, nonatomic) IBOutlet UIView *bgView2;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView2;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl2;
 @property (weak, nonatomic) IBOutlet UIButton *btn2;

 @property (weak, nonatomic) IBOutlet UIView *bgView3;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView3;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl3;
 @property (weak, nonatomic) IBOutlet UIButton *btn3;

 @property (weak, nonatomic) IBOutlet UIView *bgView4;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView4;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl4;
 @property (weak, nonatomic) IBOutlet UIButton *btn4;

 @property (weak, nonatomic) IBOutlet UIView *bgView5;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView5;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl5;
 @property (weak, nonatomic) IBOutlet UIButton *btn5;

 @property (weak, nonatomic) IBOutlet UIView *bgView6;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView6;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl6;
 @property (weak, nonatomic) IBOutlet UIButton *btn6;

 @property (weak, nonatomic) IBOutlet UIView *bgView7;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView7;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl7;
 @property (weak, nonatomic) IBOutlet UIButton *btn7;

 @property (weak, nonatomic) IBOutlet UIView *bgView8;
 @property (weak, nonatomic) IBOutlet UIImageView *platformImgView8;
 @property (weak, nonatomic) IBOutlet UILabel *titleLbl8;
 @property (weak, nonatomic) IBOutlet UIButton *btn8;
 */
- (IBAction)onBtnAction:(UIButton *)sender {
    if (sender.tag == 101) {
    } else if (sender.tag == 102) {
    } else if (sender.tag == 103) {
    } else if (sender.tag == 104) {
    } else if (sender.tag == 105) {
    } else if (sender.tag == 106) {
    } else if (sender.tag == 107) {
    } else if (sender.tag == 108) {
    }
    
    PTMyPlatformQrcodeVC *vc = [[PTMyPlatformQrcodeVC alloc] initWithNibName:@"PTMyPlatformQrcodeVC" bundle:nil];
    vc.tag = sender.tag;
    [[XSWJVASPTHelper getCurrentVC].navigationController pushViewController:vc animated:YES];
}

@end

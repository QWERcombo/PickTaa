//
//  PTMineAuthInfoVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMineAuthInfoVC.h"

@interface PTMineAuthInfoVC ()

@end

@implementation PTMineAuthInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = kLocalizedString(@"check_data", @"审核资料");
    self.countryTitleLbl.text = kLocalizedString(@"country", @"国家");
    self.countryLbl.text = self.myModel.country==1?kLocalizedString(@"china", @"中国"):kLocalizedString(@"other_country", @"海外");
    self.areaLbl.text = kLocalizedString(@"area", @"地区");
    self.areaValueLbl.text = kLocalizedString(@"", @"");
    self.nameLbl.text = kLocalizedString(@"real_name", @"真实姓名");
    self.nameValueLbl.text = self.myModel.real_name;
    self.idTypeLbl.text = kLocalizedString(@"cer_type", @"证件类型");
    self.idNumLbl.text = kLocalizedString(@"id_number", @"证件号码");
    self.idValueLbl.text = self.myModel.card_id;
    
    self.idTypeValueLbl.text = kLocalizedString(@"id_card", @"身份证");// "" = "";
    
    if (self.myModel.is_auth == 1) {
        self.statusImgView.image = [UIImage imageNamed:@"mine_authed"];
    } else {
        self.statusImgView.image = [UIImage imageNamed:@"mine_authing"];
    }
}



@end

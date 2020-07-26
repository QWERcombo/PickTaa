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
    self.countryLbl.text = kLocalizedString(@"china", @"中国");
    self.areaLbl.text = kLocalizedString(@"area", @"地区");
    self.areaValueLbl.text = kLocalizedString(@"", @"");
    self.nameLbl.text = kLocalizedString(@"real_name", @"真实姓名");
    self.nameValueLbl.text = kLocalizedString(@"", @"");
    self.idTypeLbl.text = kLocalizedString(@"cer_type", @"证件类型");
    self.idNumLbl.text = kLocalizedString(@"id_number", @"证件号码");
    self.idValueLbl.text = kLocalizedString(@"", @"");
    
    self.idTypeValueLbl.text = kLocalizedString(@"id_card", @"身份证");// "" = "";
    self.idTypeValueLbl.text = kLocalizedString(@"other_id_card", @"社会安全号");
    self.statusImgView.image = [UIImage imageNamed:@"mine_authing"];
    self.statusImgView.image = [UIImage imageNamed:@"mine_authed"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

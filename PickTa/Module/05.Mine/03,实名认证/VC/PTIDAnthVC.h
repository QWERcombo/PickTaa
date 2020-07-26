//
//  PTIDAnthVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTIDAnthVC : UITableViewController

// 国家
@property (weak, nonatomic) IBOutlet UILabel *countryTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countryLbl;
@property (weak, nonatomic) IBOutlet UIButton *countryBtn;

// 地区
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UITextField *areaTfl;

// 真实名称
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameTfl;

// 证件类型
@property (weak, nonatomic) IBOutlet UILabel *idTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *idTypeValueLbl;

// 证件号码
@property (weak, nonatomic) IBOutlet UILabel *idNumLbl;
@property (weak, nonatomic) IBOutlet UITextField *idNumTfl;

// 身份证正面
@property (weak, nonatomic) IBOutlet UILabel *upIdFaceLbl;
@property (weak, nonatomic) IBOutlet UIButton *upIdFaceBtn;
@property (weak, nonatomic) IBOutlet UILabel *upIdBackLbl;
@property (weak, nonatomic) IBOutlet UIButton *upIdBackBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

NS_ASSUME_NONNULL_END

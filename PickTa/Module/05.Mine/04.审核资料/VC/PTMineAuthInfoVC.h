//
//  PTMineAuthInfoVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"
#import "PTMyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PTMineAuthInfoVC : PickTaBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;
@property (nonatomic,strong) PTMyModel *myModel;
// 国家
@property (weak, nonatomic) IBOutlet UILabel *countryTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countryLbl;
@property (weak, nonatomic) IBOutlet UILabel *showText;

// 地区
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *areaValueLbl;

// 真实名称
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameValueLbl;

// 证件类型
@property (weak, nonatomic) IBOutlet UILabel *idTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *idTypeValueLbl;

// 证件号码
@property (weak, nonatomic) IBOutlet UILabel *idNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *idValueLbl;

@end

NS_ASSUME_NONNULL_END

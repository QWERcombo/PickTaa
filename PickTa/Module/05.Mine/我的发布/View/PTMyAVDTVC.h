//
//  PTMyAVDTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PickTaMyAdModel;
@interface PTMyAVDTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *startLbl;
@property (weak, nonatomic) IBOutlet UILabel *endLbl;

@property (weak, nonatomic) IBOutlet UILabel *heartNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *heartIcon;
@property (weak, nonatomic) IBOutlet UILabel *beanNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *beanIcon;

@property (nonatomic, strong) PickTaMyAdModel *adModel;
@end

NS_ASSUME_NONNULL_END

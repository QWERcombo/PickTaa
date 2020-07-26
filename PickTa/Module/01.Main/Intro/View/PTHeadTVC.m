//
//  PTHeadTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTHeadTVC.h"

@interface PTHeadTVC ()
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *tagBgView;

@property (weak, nonatomic) IBOutlet UIImageView *profileIcon;
@property (weak, nonatomic) IBOutlet UILabel *profileIntroLbl;
@property (weak, nonatomic) IBOutlet UILabel *profileInfoLbl;

@end
@implementation PTHeadTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.headBgView.layer.masksToBounds = YES;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

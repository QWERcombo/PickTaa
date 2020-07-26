//
//  PTMyAVDTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyAVDTVC.h"

@implementation PTMyAVDTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.btn1.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAdModel:(PickTaMyAdModel *)adModel {
    _adModel = adModel;
    
}

@end

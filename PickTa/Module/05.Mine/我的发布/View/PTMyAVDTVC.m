//
//  PTMyAVDTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyAVDTVC.h"
#import "PickTaMyAdModel.h"

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
    
    _titleLbl.text = _adModel.title;
    _startLbl.text = [NSString stringWithFormat:@"广告开始时间:%@", _adModel.start_time];
    _endLbl.text = [NSString stringWithFormat:@"广告结束时间:%@", _adModel.end_time];
    _heartNumLbl.text = _adModel.like_num;
    _beanNumLbl.text = _adModel.like_reward;
    [_btn1 setTitle:_adModel.status_name forState:UIControlStateNormal];
    
    if (_adModel.status.intValue == 0) {
        _btn1.backgroundColor = COLOR_HEX_RGB(0xFF4747);
    } else if (_adModel.status.intValue == 1) {
        _btn1.backgroundColor = COLOR_HEX_RGB(0x42B3B1);
    } else if (_adModel.status.intValue == 2) {
        _btn1.backgroundColor = COLOR_HEX_RGB(0xF7F7F7);
    }
}

@end

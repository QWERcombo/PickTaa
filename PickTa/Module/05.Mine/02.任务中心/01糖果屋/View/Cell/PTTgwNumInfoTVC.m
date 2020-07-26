//
//  PTTgwNumInfoTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTgwNumInfoTVC.h"

@implementation PTTgwNumInfoTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.button1.layer.masksToBounds = YES;
    self.button2.layer.masksToBounds = YES;
    self.button1.layer.borderWidth = 1.0f;
    self.button1.layer.borderColor = COLOR_HEX_RGB(0x42B3B1).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onBtnAction:(UIButton *)sender {
}

@end

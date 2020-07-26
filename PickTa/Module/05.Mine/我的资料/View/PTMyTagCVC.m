//
//  PTMyTagCVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyTagCVC.h"

@implementation PTMyTagCVC


- (void)awakeFromNib {
    [super awakeFromNib];

    self.valueBgView.layer.masksToBounds = YES;
    self.valueBgView.layer.borderWidth = 0.8;
    self.valueBgView.layer.borderColor = COLOR_HEX_RGB(0x44BCBA).CGColor;
    self.deleteBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -15);
}

- (IBAction)onDeleteBtn:(id)sender {
    _deleteBtnBlock ? _deleteBtnBlock(sender) : nil;
}

@end

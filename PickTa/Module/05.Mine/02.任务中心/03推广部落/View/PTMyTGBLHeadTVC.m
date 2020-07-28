//
//  PTMyMHGHeadTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyTGBLHeadTVC.h"

@implementation PTMyTGBLHeadTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.profileBgView.layer.masksToBounds = YES;
    self.profileImgView.layer.masksToBounds = YES;
    // self.headBgView.layer.masksToBounds = YES;
    self.headBgView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    self.headBgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11].CGColor;
    self.headBgView.layer.shadowOffset = CGSizeMake(0,4);
    self.headBgView.layer.shadowOpacity = 1;
    self.headBgView.layer.shadowRadius = 12;
    self.headBgView.layer.cornerRadius = 6;
    @weakify(self);
    [[self.statusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (self.changeStatusBlock) {
            self.changeStatusBlock(x.isSelected);
        }
    }];
    [[self.levelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (self.changeLevelBlock) {
            self.changeLevelBlock(x.isSelected);
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

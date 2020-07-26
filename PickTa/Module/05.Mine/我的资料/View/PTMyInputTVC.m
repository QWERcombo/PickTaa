//
//  PTMyInputTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/11.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyInputTVC.h"

@implementation PTMyInputTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgTextView.layer.masksToBounds = YES;
    self.titleLbl.text = kLocalizedString(@"resume", @"个人简介");
    self.textView.placeholder = kLocalizedString(@"input_resume", @"请输入您的个人简介...");
    self.textView.placeholderColor = COLOR_999999;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

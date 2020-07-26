//
//  PTPublishHeadTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishHeadTVC.h"

@implementation PTPublishHeadTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.inputTfl.placeholder = kLocalizedString(@"input_title2", @"   请输入标题");
    self.titleLbl.text = kLocalizedString(@"title", @"标题");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

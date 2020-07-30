//
//  PTAddRequestListCell.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTAddRequestListCell.h"

@implementation PTAddRequestListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.acceptBtn.layer.cornerRadius = 4;
    self.acceptBtn.layer.masksToBounds = YES;
    self.showImg.layer.cornerRadius = 6;
    self.showImg.layer.masksToBounds = YES;
}

@end

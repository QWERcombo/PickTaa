//
//  UITableViewCell+SelectStyle.m
//  CreditInvestigation
//
//  //  Created by SOPOCO_ljt on 2017/4/11.
//  Copyright © 2017年 杨亚坤. All rights reserved.
//

#import "XSWJVAUITableViewCell+SelectStyle.h"

@implementation UITableViewCell (SelectStyle)

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

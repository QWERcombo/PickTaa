//
//  PTPublishImgAddCVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishImgAddCVC.h"

@implementation PTPublishImgAddCVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.btnImg.contentMode = UIViewContentModeScaleAspectFill;
    self.btnImg.layer.cornerRadius = 6.0f;
    self.btnImg.layer.masksToBounds = YES;
}

@end

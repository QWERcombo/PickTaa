//
//  PickTaHeaderView.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaHeaderView.h"

@implementation PickTaHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bannerView.layer.cornerRadius = 4;
}

+(PickTaHeaderView *)createHeaderView{
    PickTaHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"PTCallViews" owner:nil options:nil][1];
    return headerView;
}

@end

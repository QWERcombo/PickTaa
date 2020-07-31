//
//  PTGroupMemberCell.m
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTGroupMemberCell.h"

@implementation PTGroupMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.user_avatar.layer.cornerRadius = 4;
    self.user_avatar.layer.masksToBounds = YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"PTGroupMemberCell" owner:self options:nil].firstObject;
    }
    return self;
}

@end

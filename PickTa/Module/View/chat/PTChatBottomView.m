//
//  PTChatBottomView.m
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatBottomView.h"

@implementation PTChatBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.inputTV.layer.cornerRadius = 6;
    self.inputTV.layer.masksToBounds = YES;
}

@end

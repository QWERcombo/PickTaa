//
//  PTChatBottomView.m
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatBottomView.h"

@implementation PTChatBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.inputTV.layer.cornerRadius = 6;
    self.inputTV.layer.masksToBounds = YES;
    
    
}

@end

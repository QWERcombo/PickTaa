//
//  PTChatCurrentCell.m
//  PickTa
//
//  Created by Stark on 2020/6/23.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatCurrentCell.h"
#import "NSObject+other.h"

@implementation PTChatCurrentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.chatIcon.layer.cornerRadius = 6;
    self.chatIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecordIndexModel:(PTChatRecordModel *)recordIndexModel{
    _recordIndexModel = recordIndexModel;
    [self.chatIcon sd_setImageWithURL:[NSURL URLWithString:recordIndexModel.avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    self.chatNickName.text =recordIndexModel.nickname;
    self.chatDesc.text = recordIndexModel.content;
    self.chatDate.text = [NSObject convertForLongTime:recordIndexModel.time];
}

@end

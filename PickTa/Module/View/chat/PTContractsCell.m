//
//  PTContractsCell.m
//  PickTa
//
//  Created by Stark on 2020/6/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTContractsCell.h"

@implementation PTContractsCell

- (void)contractNewFriendsUI{
    self.contractIcon.image = [UIImage imageNamed:@"chat_newFriend"];
    self.contractType.text = @"新的朋友";
}

-(void)contractGroupUI{
    self.contractIcon.image = [UIImage imageNamed:@"chat_groups"];
    self.contractType.text = @"群聊";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contractIcon.layer.cornerRadius = 6;
    self.contractIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(PickTaUserListModel *)model{
    _model = model;
    [self.contractIcon sd_setImageWithURL:[NSURL URLWithString:model.to_head] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    self.contractType.text = model.to_nickname;
}

@end

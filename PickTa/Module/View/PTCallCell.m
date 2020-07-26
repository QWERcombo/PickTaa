//
//  PTCallCell.m
//  PickTa
//
//  Created by Stark on 2020/6/18.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTCallCell.h"

@implementation PTCallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 6;
    self.inAvdBtn.layer.cornerRadius = 4;
    self.photo.layer.cornerRadius = 4;
    self.photo.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(PickTaAdvDiscoverModel *)model{
    _model = model;
    self.name.text = model.user.nickname;
    self.content.text = model.content;
    self.title.text = model.title;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.img]];
//    RAC(self.name,text) = RACObserve(model.user,nickname);
//    RAC(self.content,text) = RACObserve(model,content);
//    RAC(self.title,text) = RACObserve(model,title);
//    @weakify(self)
//    [RACObserve(model.user,avatar) subscribeNext:^(id x) {
//        @strongify(self)
//        [self.icon sd_setImageWithURL:[NSURL URLWithString:x]];
//    }];
//
//    [RACObserve(model, img) subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:x]];
//    }];
    
}


@end

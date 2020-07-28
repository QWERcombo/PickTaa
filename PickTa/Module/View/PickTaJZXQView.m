//
//  PickTaJZXQView.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaJZXQView.h"

@implementation PickTaJZXQView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.surnBtn.layer.cornerRadius = 22;
    self.surnBtn.layer.masksToBounds = YES;
}

-(void)setModel:(PTTaskJZJSItemModel *)model{
    _model = model;
    self.jzName.text = model.name;
    self.beanCount.text = [NSString stringWithFormat:@"%@颗", model.bean];
    self.activityCount.text = model.activation;
    self.lingquCount.text = [NSString stringWithFormat:@"%@",model.times_receive];
    self.dayCount.text = [NSString stringWithFormat:@"%@脉豆",model.daily];
    self.expDay.text = [NSString stringWithFormat:@"%@天",model.date_term];
}

@end

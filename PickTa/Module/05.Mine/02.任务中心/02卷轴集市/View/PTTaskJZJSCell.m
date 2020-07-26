//
//  PTTaskJZJSCell.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskJZJSCell.h"

@implementation PTTaskJZJSCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    self.layer.cornerRadius = 8;
//    self.layer.masksToBounds = YES;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jZDHBtn.layer.cornerRadius = 16;
    self.jZDHBtn.layer.masksToBounds = YES;
    self.jzxq.layer.cornerRadius = 16;
    self.jzxq.layer.masksToBounds = YES;
    self.jzxq.layer.borderWidth = 1;
    self.jzxq.layer.borderColor = MainBlueColor.CGColor;
    @weakify(self)
//    [[self.jZDHBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
//        [SVProgressHUD showImage:[UIImage imageNamed:PlaceHolder_Logo] status:@"兑换中"];
//        [[PickHttpManager shared]requestPOST:API_TaskJZDH withParam:@{@"id":@(self.model.id)} withSuccess:^(id  _Nonnull obj) {
//            [SVProgressHUD showImage:nil status:obj];
//            [SVProgressHUD dismissWithDelay:0.5];
//        } withFailure:^(NSError * _Nonnull err) {
//            
//        }];
//    }];
    
    [[self.jzxq rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [PickTaAlertFactoryView alertJZXQ:self.viewController andModel:self.model];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(PTTaskJZJSItemModel *)model{
    _model = model;
//    self.jzjsName.text = model.name;
//    self.jzCount.text = model.condition;
//    self.jzSY.text = [NSString stringWithFormat:@"%@脉豆+%@活跃度",model.bean,model.activation];
}

@end

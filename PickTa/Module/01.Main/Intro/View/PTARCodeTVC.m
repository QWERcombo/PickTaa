//
//  PTARCodeTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTARCodeTVC.h"

@interface PTARCodeTVC ()
@property (weak, nonatomic) IBOutlet UIImageView *arcodeImgView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
@implementation PTARCodeTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onBtnAction:(UIButton *)sender {
    if (sender.tag == 101) { // 感兴趣
        _tapBlock1 ? _tapBlock1(sender) : nil;
    } else if (sender.tag == 102) { // 忽略
        _tapBlock2 ? _tapBlock2(sender) : nil;
    }
}

@end

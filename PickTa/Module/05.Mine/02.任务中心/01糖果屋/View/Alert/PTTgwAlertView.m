//
//  PTTgwAlertView.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTgwAlertView.h"

@implementation PTTgwAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn1.layer.masksToBounds = YES;
    self.inputTfl.layer.masksToBounds = YES;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的兑换码" attributes:
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:13.f]
    }];
    self.inputTfl.attributedPlaceholder = attrString;
}

@end

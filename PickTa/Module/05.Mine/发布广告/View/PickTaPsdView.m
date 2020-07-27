//
//  PickTaPsdView.m
//  PickTa
//
//  Created by mac on 2020/7/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaPsdView.h"

@implementation PickTaPsdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PickTaPsdView" owner:self options:nil].firstObject;
        
        self.contentView.layer.cornerRadius = 6;
        
        self.psdView.passwordLength = 6;
        self.psdView.delegate = self;
        [self.psdView becomeFirstResponder];
        self.frame = frame;
//        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//            CGFloat kbHeight = [[x.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//            double duration = [[x.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//            [UIView animateWithDuration:duration animations:^{
//
//            }];
//        }];
    }
    return self;
}
- (IBAction)closeClick:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)passwordInputView:(SLPasswordInputView *)inputView didFinishInputWithPassword:(NSString *)password {
    if (self.finishedBlock) {
        self.finishedBlock(password);
        [self removeFromSuperview];
    }
}

@end

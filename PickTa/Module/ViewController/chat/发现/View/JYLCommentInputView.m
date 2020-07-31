//
//  JYLDiscoverDetailBottomToolView.m
//  捷友联
//
//  Created by 赵越 on 2019/10/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JYLCommentInputView.h"

@interface JYLCommentInputView()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UILabel *textPlaceHolderLabel;
@property (nonatomic, assign) CGRect showFrameDefault;
@property (nonatomic, assign) CGRect sendButtonFrameDefault;
@property (nonatomic, assign) CGRect textViewFrameDefault;

@end

static CGFloat keyboardAnimationDuration = 0.3;

@implementation JYLCommentInputView
/** 输入最大高度 */
#define kInputMaxHeight        45
/** 输入的最大字数 */
#define kInputMaxCount         30

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _sendBtn.backgroundColor = MainBlueColor;
        [_sendBtn addTarget:self action:@selector(sendInputMsg:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.frame = CGRectMake(kScreenWidth-15-50, 7.5, 50, 35);
        _sendBtn.layer.cornerRadius = 5;
        _sendBtn.layer.masksToBounds = YES;
        [self addSubview:_sendBtn];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 7.5, kScreenWidth-30-50-5, 35)];
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_textView];
        
        _textPlaceHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7.5, 150, 20)];
        _textPlaceHolderLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        _textPlaceHolderLabel.textColor = [UIColor colorWithHexString:@"#A2A2A2"];
        _textPlaceHolderLabel.text = @"评论";
        [_textView addSubview:_textPlaceHolderLabel];
        
        
        _sendButtonFrameDefault = _sendBtn.frame;
        _textViewFrameDefault = _textView.frame;
        
        [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
        //        _textView.text = @"221";
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object == _textView && [keyPath isEqualToString:@"contentSize"]) {
        
        __block CGFloat height = _textView.contentSize.height;
        
        CGFloat heightDefault = 35;
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            
            if (height >= heightDefault) {
                if (height > (heightDefault+kInputMaxHeight)) {
                    height = heightDefault+kInputMaxHeight;
                }
                
                CGRect frame = self.showFrameDefault;
                frame.size.height = self.showFrameDefault.size.height + (height-35);
                frame.origin.y = self.showFrameDefault.origin.y - (height-35);
                self.frame = frame;
                
                self.sendBtn.frame = CGRectMake(self.sendButtonFrameDefault.origin.x, self.frame.size.height-7.5-35, 50, 35);
                self.textView.frame = CGRectMake(15, 7.5, self.textViewFrameDefault.size.width, height);
                
            } else {
                
                [self resetFrameDefault];
            }
            
        }];
        
    }
    
}

#pragma mark - TextView
- (void)textViewDidChange:(UITextView *)textView {
    
    _textPlaceHolderLabel.hidden = textView.text.length;
}

- (void)resetFrameDefault{
    self.frame = _showFrameDefault;
    self.sendBtn.frame = _sendButtonFrameDefault;
    self.textView.frame =_textViewFrameDefault;
}

- (void)keyboardWillAppear:(NSNotification *)noti{
    self.hidden = NO;
    if(_textView.isFirstResponder){
        NSDictionary *info = [noti userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGSize keyboardSize = [value CGRectValue].size;
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = kScreenHeight - keyboardSize.height;
            self.frame = frame;
            self.showFrameDefault = self.frame;
        }];
    }
}
- (void)keyboardWillDisappear:(NSNotification *)noti{
    
    if(_textView.isFirstResponder){
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            
            frame.origin.y = kScreenHeight;
            
            self.frame = frame;
        } completion:^(BOOL finished) {
            /** 键盘消失文本清空 */
            self->_textView.text = @"";
            self->_textPlaceHolderLabel.hidden = NO;
            if (finished) {
                self.hidden = YES;
            }
        }];
    }
}

- (void)sendInputMsg:(UIButton *)sender {
    
    if (!_textView.text.length) {
        [_textView resignFirstResponder];
        return;
    }
    //    if (_textView.text.length > kInputMaxCount) {
    //        [JYLTipsHelper.share showError:kTips_Disc_InputMax(kInputMaxCount)];
    //        return;
    //    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCommentMsg:)]) {
        
        [_textView resignFirstResponder];
        
        if (_textView.text.length) {
            [self.delegate addCommentMsg:_textView.text];
        }
    }
}

- (void)dealloc {
    
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}
@end

//
//  PTChatBottomOperateView.m
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatBottomOperateView.h"

@implementation PTChatBottomOperateView {
    NSArray *_titleArr;
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorF8F8F8;
        _titleArr = [NSArray arrayWithArray:titleArr];
        
        CGFloat width = kScreenWidth/_titleArr.count;
        for (NSInteger i=0; i<_titleArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:CompleteLAB forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:_titleArr[i]] forState:UIControlStateNormal];
            btn.frame = CGRectMake(width*i, 0, width, frame.size.height);
            [btn wbc_changeTitleBottom];
            [btn wbc_changeTitleBottomWithPadding:10];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
    }
    return self;
}

- (void)btnClick:(UIButton *)sender {
    
    if (self.completeBlock) {
        self.completeBlock(sender.currentTitle);
    }
}

@end

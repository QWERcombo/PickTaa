//
//  UIButton+SPTUI.m
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/3.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAUIButton+SPTUI.h"

static CGFloat padding = 8;
NSString *endingStr = @"完成";
static id curTimer;

@implementation UIButton (SPTUI)

- (void)wbc_changeTitleLeft {
    CGFloat imgWidth = self.imageView.image.size.width;//image width
    CGFloat titleWidth = [self widthForTitleString:self.titleLabel.text];//titleWidth
    
    // button 设置图片的和标题的边距
    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -(imgWidth + padding / 2),
                                            0,
                                            (imgWidth + padding / 2));
    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                            (titleWidth + padding / 2),
                                            0,
                                            -(titleWidth + padding / 2));
}

- (void)wbc_changeTitleLeftWithPadding:(CGFloat)padding1 {
    CGFloat imgWidth = self.imageView.image.size.width;//image width
    CGFloat titleWidth = [self widthForTitleString:self.titleLabel.text];//titleWidth
    
    // button 设置图片的和标题的边距
    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -(imgWidth + padding1 / 2),
                                            0,
                                            (imgWidth + padding1 / 2));
    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                            (titleWidth + padding1 / 2),
                                            0,
                                            -(titleWidth + padding1 / 2));
}

- (void)wbc_changeTitleBottom {
    CGRect titleRect = self.titleLabel.frame;        //文本控件在按钮中的frame值。
    CGRect imageRect = self.imageView.frame;  //图片控件在按钮中的frame值。
    CGFloat selfWidth = self.frame.size.width;                                   //按钮控件的宽度
    CGFloat selfHeight = self.frame.size.height;                                  //按钮控件的高度
    CGFloat totalHeight = titleRect.size.height + padding + imageRect.size.height;  //图文上下布局时所占用的总高度，注意这里也算上他们之间的间隙值padding
    self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 + imageRect.size.height + padding * 2 - titleRect.origin.y),
                                            (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                            -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                                            -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
    self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 - imageRect.origin.y - padding),
                                            (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                            -((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                            -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
}

- (void)wbc_changeTitleBottomWithPadding:(CGFloat)padding1 {
    CGRect titleRect = self.titleLabel.frame;        //文本控件在按钮中的frame值。
    CGRect imageRect = self.imageView.frame;  //图片控件在按钮中的frame值。
    CGFloat selfWidth = self.frame.size.width; //按钮控件的宽度
    CGFloat selfHeight = self.frame.size.height; //按钮控件的高度
    CGFloat totalHeight = titleRect.size.height + padding1 + imageRect.size.height;  //图文上下布局时所占用的总高度，注意这里也算上他们之间的间隙值padding
    self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 + imageRect.size.height + padding1 * 2 - titleRect.origin.y),
                                            (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                            -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding1 - titleRect.origin.y),
                                            -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
    self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 - imageRect.origin.y - padding1),
                                            (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                            -((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                            -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
}

- (void)wbc_changeTitleEdge:(UIEdgeInsets)edge {
    self.imageEdgeInsets = UIEdgeInsetsMake(5, 23.5, 42, 23.5);
    self.titleEdgeInsets = edge;
}

- (CGFloat)widthForTitleString:(NSString *)title {
    CGRect rect = [title boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil];
    
    return rect.size.width;
}

/**
 倒计时
 
 @param timeLine 倒计时时间
 @param title 正常时显示文字
 @param subTitle 倒计时时显示的文字（不包含秒）
 @param countDoneBlock 倒计时结束时的Block
 @param isInteraction 是否希望倒计时时可交互
 */
- (void)wbc_countDownWithTime:(NSInteger)timeLine
                    withTitle:(NSString *)title
                  normalColor:(UIColor *)normalColor
                 disableColor:(UIColor *)disableColor
                         font:(UIFont *)font
            andCountDownTitle:(NSString *)subTitle
               countDoneBlock:(void (^)(UIButton *button))countDoneBlock
                isInteraction:(BOOL)isInteraction
                   needFormat:(BOOL)needFormat
{
    __block NSInteger timeout = timeLine; // 倒计时时间
  
    if (curTimer) {
        dispatch_source_cancel(curTimer);
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    curTimer = _timer;
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countDoneBlock) {
                    countDoneBlock(self);
                }
                //设置界面的按钮显示 根据自己需求设置
                self.userInteractionEnabled = YES;
                [self setTitle:title forState:UIControlStateNormal];
                if (normalColor) {
                    [self setTitleColor:normalColor forState:UIControlStateNormal];
                }
                
                if (font) {
                    self.titleLabel.font = font;
                }
            });
        } else {
            NSString *strTime;
            //            int minutes = timeout / 60;
            if (needFormat) {
                //重新计算 时/分/秒
                NSString *str_hour = [NSString stringWithFormat:@"%02ld", (long)timeout / 3600];
                
                NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)(timeout % 3600) / 60];
                
                NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)timeout % 60];
                
                strTime = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
            } else {
                int seconds = timeout % 60;
                
                strTime = [NSString stringWithFormat:@"%.2d", seconds];
                if (seconds < 10) {
                    strTime = [NSString stringWithFormat:@"%.1d", seconds];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{// 设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"%@%@", strTime, subTitle] forState:UIControlStateNormal];
                
                if (disableColor) {
                    [self setTitleColor:disableColor forState:UIControlStateNormal];
                }
                
                if (font) {
                    self.titleLabel.font = font;
                }
            });
            
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

@end

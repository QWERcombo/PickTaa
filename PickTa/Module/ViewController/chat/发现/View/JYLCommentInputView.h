//
//  JYLDiscoverDetailBottomToolView.h
//  捷友联
//
//  Created by 赵越 on 2019/10/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JYLCommentInputViewDelegate <NSObject>
/** 发送回调 */
- (void)addCommentMsg:(NSString *)msg;

@end

@interface JYLCommentInputView : UIView

@property (nonatomic, strong) UITextView *textView;
/** delegate */
@property (nonatomic, weak) id<JYLCommentInputViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

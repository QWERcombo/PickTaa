//
//  PTChatBottomOperateView.h
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChatBottomOperateView : UIView

@property (nonatomic, copy) void(^completeBlock)(NSString *selectTitle);

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;
@end

NS_ASSUME_NONNULL_END

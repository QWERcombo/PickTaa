//
//  PickTaPsdView.h
//  PickTa
//
//  Created by mac on 2020/7/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseView.h"
#import "SLPasswordInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaPsdView : PickTaBaseView <SLPasswordInputViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *platName;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet SLPasswordInputView *psdView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, copy) void(^finishedBlock)(NSString *paypsd);
@end

NS_ASSUME_NONNULL_END

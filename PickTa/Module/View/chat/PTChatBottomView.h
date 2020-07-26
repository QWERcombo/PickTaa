//
//  PTChatBottomView.h
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatBottomView : PickTaBaseView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END

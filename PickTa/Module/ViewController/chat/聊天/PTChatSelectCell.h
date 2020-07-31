//
//  PTChatSelectCell.h
//  PickTa
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChatSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIButton *statsuBtn;

@end

NS_ASSUME_NONNULL_END

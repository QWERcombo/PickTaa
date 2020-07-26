//
//  PTChatCurrentCell.h
//  PickTa
//
//  Created by Stark on 2020/6/23.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTChatRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatCurrentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chatIcon;
@property (weak, nonatomic) IBOutlet UILabel *chatNickName;
@property (weak, nonatomic) IBOutlet UILabel *chatDesc;
@property (weak, nonatomic) IBOutlet UILabel *chatDate;
@property (nonatomic,strong) PTChatRecordModel *recordIndexModel;
@end

NS_ASSUME_NONNULL_END

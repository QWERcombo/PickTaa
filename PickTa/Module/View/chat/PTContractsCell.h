//
//  PTContractsCell.h
//  PickTa
//
//  Created by Stark on 2020/6/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaUserListModel.h"


// chat_newFriend、chat_groups

NS_ASSUME_NONNULL_BEGIN

@interface PTContractsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contractType;
@property (weak, nonatomic) IBOutlet UIImageView *contractIcon;
@property (nonatomic,strong)PickTaUserListModel *model;
-(void)contractNewFriendsUI;
-(void)contractGroupUI;

@end

NS_ASSUME_NONNULL_END

//
//  PTDetailCell.h
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaAdvDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *countDown;
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UIView *callAction;
@property (weak, nonatomic) IBOutlet UIView *quanAction;
@property (weak, nonatomic) IBOutlet UIView *shangAction;
@property (weak, nonatomic) IBOutlet UIButton *shangBtn;
@property (weak, nonatomic) IBOutlet UIButton *quanBtn;
@property (nonatomic,strong) PickTaAdvDiscoverModel *model;
@end

NS_ASSUME_NONNULL_END

//
//  PTTaskCell.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMGV;
@property (weak, nonatomic) IBOutlet UILabel *taskTitle;
@property (weak, nonatomic) IBOutlet UILabel *taskDay;
@property (weak, nonatomic) IBOutlet UILabel *activityStatus;
@property (weak, nonatomic) IBOutlet UILabel *taskTime;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,strong) PTTaskModel *taskModel;

@property (weak, nonatomic) IBOutlet UILabel *hydValidityTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *hydTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *taskProduct;

@end

NS_ASSUME_NONNULL_END

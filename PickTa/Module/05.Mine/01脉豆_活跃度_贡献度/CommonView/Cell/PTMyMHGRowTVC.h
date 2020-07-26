//
//  PTMyMHGRowTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTMyMHGRowTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mhgIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;

@end

NS_ASSUME_NONNULL_END

//
//  PTPublishCoverTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTPublishCoverTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addCoverLbl;
@property (weak, nonatomic) IBOutlet UIButton *addCoverBtn;
@property (nonatomic, weak) UIViewController *suVC;
@property (nonatomic, strong) UIImage *coverImg;
@end

NS_ASSUME_NONNULL_END

//
//  PTTgwNumInfoTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTTgwNumInfoTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLeftLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleRightLbl; // 默认隐藏
@property (weak, nonatomic) IBOutlet UILabel *valueRightLbl; // 默认隐藏

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;


@end

NS_ASSUME_NONNULL_END

//
//  PTCallCell.h
//  PickTa
//
//  Created by Stark on 2020/6/18.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaCallVM.h"
// 54 + 20 +18 + 10 + (screenWidth - 63.5 -16 - 11.5*2 )/1.74  + 文本高度

NS_ASSUME_NONNULL_BEGIN

@interface PTCallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *bgView;
//进入广告
@property (weak, nonatomic) IBOutlet UIButton *inAvdBtn;

@property (nonatomic,strong) PickTaAdvDiscoverModel *model;

@end

NS_ASSUME_NONNULL_END

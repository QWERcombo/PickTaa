//
//  PTTaskCenterVC.h
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskCenterVC : PickTaBaseViewController
///糖果屋
@property (weak, nonatomic) IBOutlet UIButton *tgwBtn;
///卷轴集市
@property (weak, nonatomic) IBOutlet UIButton *jzjsBtn;
///推广部落
@property (weak, nonatomic) IBOutlet UIButton *tgblBtn;

@property (weak, nonatomic) IBOutlet UILabel *tgwLbl;
@property (weak, nonatomic) IBOutlet UILabel *gzjsLbl;
@property (weak, nonatomic) IBOutlet UILabel *tgblLbl;


@end

NS_ASSUME_NONNULL_END

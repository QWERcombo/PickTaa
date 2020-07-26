//
//  PTTaskJZJSCell.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTaskJZJSItemModel.h"
#import "PickTaAlertFactoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskJZJSCell : UITableViewCell
///卷轴名称
@property (weak, nonatomic) IBOutlet UILabel *jzjsName;
///卷轴个数
@property (weak, nonatomic) IBOutlet UILabel *jzCount;
///卷轴条件
@property (weak, nonatomic) IBOutlet UILabel *jzTJ;
///卷轴兑换
@property (weak, nonatomic) IBOutlet UIButton *jZDHBtn;
///卷轴详情
@property (weak, nonatomic) IBOutlet UIButton *jzxq;
///卷轴收益
@property (weak, nonatomic) IBOutlet UILabel *jzSY;
///完成收益
@property (weak, nonatomic) IBOutlet UILabel *wcsy;

@property (nonatomic,strong) PTTaskJZJSItemModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  PickTaJZXQView.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseView.h"
#import "PTTaskJZJSItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaJZXQView : PickTaBaseView
@property (weak, nonatomic) IBOutlet UILabel *jzName;
@property (weak, nonatomic) IBOutlet UILabel *beanCount;
@property (weak, nonatomic) IBOutlet UILabel *activityCount;
@property (weak, nonatomic) IBOutlet UILabel *lingquCount;
@property (weak, nonatomic) IBOutlet UILabel *dayCount;
@property (weak, nonatomic) IBOutlet UILabel *expDay;
@property (weak, nonatomic) IBOutlet UIButton *surnBtn;
@property (nonatomic,strong) PTTaskJZJSItemModel *model;
@end

NS_ASSUME_NONNULL_END

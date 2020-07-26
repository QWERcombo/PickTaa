//
//  PickTaAlertFactoryView.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//
#import "PickTaJZXQView.h"
#import "PickTaAlertFactoryView.h"
#import "GKCover.h"

@implementation PickTaAlertFactoryView

+ (void)alertJZXQ:(UIViewController *)vc andModel:(PTTaskJZJSItemModel *)model {
    PickTaJZXQView *alertView = [[NSBundle mainBundle]loadNibNamed:@"PTCallViews" owner:nil options:nil][3];
    alertView.gk_size = CGSizeMake(SCREEN_WIDTH,460);
    alertView.model = model;
    [[alertView.surnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [GKCover hide];
    }];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
       [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:alertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter animStyle:GKCoverAnimStyleNone notClick:NO];
    #pragma clang diagnostic pop
}

@end


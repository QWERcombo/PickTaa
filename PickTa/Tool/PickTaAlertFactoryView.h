//
//  PickTaAlertFactoryView.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTTaskJZJSItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaAlertFactoryView : NSObject
///alert 卷轴详情
+(void)alertJZXQ:(UIViewController*)vc andModel:(PTTaskJZJSItemModel*)model;
@end

NS_ASSUME_NONNULL_END

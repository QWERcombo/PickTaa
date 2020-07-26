//
//  PTARCodeTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/9.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTARCodeTVC : UITableViewCell


@property (nonatomic, copy) void (^tapBlock1)(UIButton *btn);
@property (nonatomic, copy) void (^tapBlock2)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END

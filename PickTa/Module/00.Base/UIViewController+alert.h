//
//  UIViewController+alert.h
//  PickTa
//
//  Created by Stark on 2020/6/22.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (alert)
/**弹出确认取消 自定义 确定，取消文本*/
-(void)alertSureCancle:(NSString*)title andSubTitle:(NSString*)subTitle sureTitle:(NSString*)sureTitle cancleTitle:(NSString*)cancleTitle sureCallBack:(void(^)(void))sure cancleCallBack:(void(^)(void))cancle;

/**弹窗只有确定*/
-(void)alertSure:(NSString*)title andSubTitle:(NSString*)subTitle sureCallBack:(void(^)(void))sure ;

+ (__kindof UIViewController *)initViewControllerFromChatStoryBoardName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END

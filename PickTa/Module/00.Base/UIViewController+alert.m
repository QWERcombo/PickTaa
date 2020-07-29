//
//  UIViewController+alert.m
//  PickTa
//
//  Created by Stark on 2020/6/22.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "UIViewController+alert.h"

@implementation UIViewController (alert)
-(void)alertSureCancle:(NSString *)title andSubTitle:(NSString *)subTitle sureTitle:(NSString *)sureTitle cancleTitle:(NSString *)cancleTitle sureCallBack:(void (^)(void))sure cancleCallBack:(void (^)(void))cancle{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:subTitle
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:sureTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        !sure ?: sure();
    }];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:cancleTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
        !cancle ?: cancle();
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)alertSure:(NSString *)title andSubTitle:(NSString *)subTitle sureCallBack:(void (^)(void))sure{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:subTitle
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        !sure ?: sure();
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

+ (__kindof UIViewController *)initViewControllerFromChatStoryBoardName:(NSString *)className; {
    return [[UIStoryboard storyboardWithName:@"Chat" bundle:nil] instantiateViewControllerWithIdentifier:className];
}
@end

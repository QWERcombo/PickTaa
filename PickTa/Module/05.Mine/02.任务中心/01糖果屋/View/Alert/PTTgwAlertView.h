//
//  PTTgwAlertView.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTTgwAlertView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btViewWidthContraint;
@property (weak, nonatomic) IBOutlet UILabel *tgqNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *codeLbl;
@property (weak, nonatomic) IBOutlet UILabel *tipCopyLbl;
@property (weak, nonatomic) IBOutlet UIButton *btn1; // 复制 确定
@property (weak, nonatomic) IBOutlet UITextField *inputTfl;


@end

NS_ASSUME_NONNULL_END

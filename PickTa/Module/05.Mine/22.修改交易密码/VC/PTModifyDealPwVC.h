//
//  PTModifyDealPwVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTModifyDealPwVC : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLbl1;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl2;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl3;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl4;
@property (weak, nonatomic) IBOutlet UITextField *pwTfl1;
@property (weak, nonatomic) IBOutlet UITextField *pwTfl2;
@property (weak, nonatomic) IBOutlet UITextField *pwTfl3;
@property (weak, nonatomic) IBOutlet UITextField *pwTfl4;

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
@property (weak, nonatomic) IBOutlet JKCountDownButton *codeBtn;

- (IBAction)modifyBtnAction:(id)sender;
- (IBAction)codeBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END

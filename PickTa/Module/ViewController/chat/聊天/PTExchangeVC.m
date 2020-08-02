//
//  PTExchangeVC.m
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTExchangeVC.h"
#import "PickTaPsdView.h"
@interface PTExchangeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *noteTF;

@end

@implementation PTExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"转账";
    
    self.user_name.text = self.name;
    [self.user_avatar sd_setImageWithURL:[NSURL URLWithString:self.avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
}

- (IBAction)submitClick:(UIButton *)sender {
    if (!self.moneyTF.text.length) {
        [SVProgressHUD showErrorWithStatus:self.moneyTF.placeholder];
        return;
    }
    
    MJWeakSelf
    PickTaPsdView *psdView = [[PickTaPsdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    psdView.countLab.text = self.moneyTF.text;
    [psdView setFinishedBlock:^(NSString * _Nonnull paypsd) {
        if (weakSelf.completeExchangeBlock) {
            weakSelf.completeExchangeBlock(weakSelf.moneyTF.text, paypsd);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    [UIApplication.sharedApplication.keyWindow addSubview:psdView];
}


@end

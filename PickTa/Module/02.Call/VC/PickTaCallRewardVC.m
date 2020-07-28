//
//  PickTaCallRewardVC.m
//  PickTa
//
//  Created by mac on 2020/7/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCallRewardVC.h"

@interface PickTaCallRewardVC ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showName;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation PickTaCallRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打赏";
    
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:self.model.user.avatar]];
    self.showName.text = self.model.user.nickname;
    self.submitBtn.layer.cornerRadius = 6;
    self.submitBtn.layer.masksToBounds = YES;
}


- (IBAction)rewardClick:(UIButton *)sender {
    if (!self.inputTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入打赏数量"];
        return;
    }
    [PickHttpManager.shared requestPOST:API_AdvertRewardAvaert withParam:@{
        @"id":@(self.model.id),
        @"money":self.inputTF.text
    } withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

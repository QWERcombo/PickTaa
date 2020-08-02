//
//  PTChatRedPacketCreateVC.m
//  PickTa
//
//  Created by 赵越 on 2020/8/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatRedPacketCreateVC.h"
#import "PickTaPsdView.h"
@interface PTChatRedPacketCreateVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UITextField *noteTF;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2H;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@end

@implementation PTChatRedPacketCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发红包";
    self.view1.layer.cornerRadius = 4;
    self.view1.layer.masksToBounds = YES;
    self.view2.layer.cornerRadius = 4;
    self.view2.layer.masksToBounds = YES;
    self.view3.layer.cornerRadius = 4;
    self.view3.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = 4;
    self.sendBtn.layer.masksToBounds = YES;
    
    if (self.type.intValue == 1) {
        self.countLab.text = @"";
        self.view2.hidden = YES;
        self.view2H.constant = -10;
        self.lab1.text = @"单个金额";
    } else {
        self.countLab.text = [NSString stringWithFormat:@"本群共%@人", @(self.count)];
        self.view2.hidden = NO;
        self.view2H.constant = 60;
        self.lab1.text = @"总金额";
    }
    
    @weakify(self);
    [[self.tf1.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.moneyLab.text = x;
    }];
}

- (IBAction)send:(UIButton *)sender {
    if (!self.tf1.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入金额"];
        return;
    }
    if (self.type.intValue == 1) {
    } else {
        if (!self.tf2.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入个数"];
            return;
        }
    }
    
    MJWeakSelf
    PickTaPsdView *psdView = [[PickTaPsdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    psdView.countLab.text = self.tf1.text;
    [psdView setFinishedBlock:^(NSString * _Nonnull paypsd) {
        if (weakSelf.completeRedBlock) {
            weakSelf.completeRedBlock(weakSelf.tf1.text,
                                      self.type.intValue == 1?@"1":self.tf2.text,
                                      self.noteTF.text.length?self.noteTF.text:self.noteTF.placeholder,
                                      paypsd);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    [UIApplication.sharedApplication.keyWindow addSubview:psdView];
}


@end

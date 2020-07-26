//
//  RegisterDealVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "RegisterDealVC.h"

@interface RegisterDealVC ()

@end

@implementation RegisterDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PICK TA及服务协议";
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *containerView = [UIView new];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.text = kLocalizedString(@"yinsi", @"yinsi");
    [containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView).insets(UIEdgeInsetsMake(20, 15, 20, 15));
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

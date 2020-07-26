//
//  PickTaMeVC.m
//  PickTa
//
//  Created by Stark on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaMeVC.h"

@interface PickTaMeVC ()

@end

@implementation PickTaMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    self.navigationItem.title = @"关系圈";
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chat_relation"]];
    [self.view addSubview:imv];
    imv.frame = CGRectMake(0, 0, 151*Scale_Width, 186*Scale_Width);
    imv.center = self.view.center;
    
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

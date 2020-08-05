//
//  PTRegister3VC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/21.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTRegister3VC.h"
#import "GBTagListView.h"
#import "PickTaRootViewController.h"
#import "PickTaRegosterVM.h"
#import "PTTagModel.h"

@interface PTRegister3VC () {
    NSMutableArray *strArray;   //保存标签数据的数组
    GBTagListView *_tempTag;
    GBTagListView *tagList;
    UIButton *btn;
    NSMutableArray *selectTagArray;
}
@property (nonatomic, strong) PickTaRegosterVM *loginVM;
@end

@implementation PTRegister3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginVM = PickTaRegosterVM.new;
    self.loginVM.tagParam = nil;
    
    self.title = kLocalizedString(@"label", @"标签");
    [self wr_setNavBarShadowImageHidden:YES];
    self.view.backgroundColor = UIColor.whiteColor;
    @weakify(self)
    //    WS(weakSelf)
    strArray = NSMutableArray.new;
    selectTagArray = [NSMutableArray array];
    //    [strArray addObjectsFromArray:@[@"大好人", @"自定义流式标签", @"github", @"code4app", @"已婚", @"阳光开朗", @"慷慨大方帅气身材好", @"仗义", @"值得一交的朋友", @"值得一交的朋友", @"值得的交", @"值得一交的朋友", @"值得一交的朋友", @"大好人", @"自定义流式标签", @"github", @"code4app", @"已婚"]];
    
    tagList = [[GBTagListView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+10, SCREEN_WIDTH, 0)];
    tagList.canTouch = YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum = 5;
    /**控制是否是单选模式 */
    tagList.isSingleSelect = NO;
    tagList.signalTagColor = [UIColor whiteColor];
    [tagList setTagWithTagArray:strArray];
    [tagList setDidselectItemBlock:^(NSArray *arr) {
        NSLog(@"选中的标签%@", arr);
        [self->selectTagArray removeAllObjects];
        [self->selectTagArray addObjectsFromArray:arr];
        //           GBTagListView *selectItems = [[GBTagListView alloc]initWithFrame:CGRectMake(0, tagList.frame.origin.y + tagList.frame.size.height + 40, SCREEN_WIDTH, 0)];
        //           selectItems.signalTagColor = [UIColor whiteColor];
        //           selectItems.canTouch = NO;
        //           [selectItems setMarginBetweenTagLabel:20 AndBottomMargin:20];
        //           [selectItems setTagWithTagArray:arr];
        //           [weakSelf.view addSubview:selectItems];
        //           self->_tempTag = selectItems;
    }];
    
    [self.view addSubview:tagList];
    //       UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(0, tagList.frame.origin.y + tagList.frame.size.height + 10, SCREEN_WIDTH, 20)];
    //       tip.text = @"选中的标签是：";
    //       tip.textAlignment = NSTextAlignmentCenter;
    //       tip.font = [UIFont boldSystemFontOfSize:18];
    //       [self.view addSubview:tip];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH-80)/2.f, tagList.frame.origin.y + tagList.frame.size.height + 20, 80, 20);
    btn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    [btn setTitle:kLocalizedString(@"change_batch", @"  换一批") forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"change_tag_btn"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onChangeTagBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((SCREEN_WIDTH-170)/2.f, SCREEN_HEIGHT - BOTTOM_HEIGHT - 50 - 30, 170, 50);
    btn1.layer.cornerRadius = 6.f;
    btn1.layer.masksToBounds = YES;
    btn1.backgroundColor = [UIColor colorWithRed:68/255.0 green:188/255.0 blue:186/255.0 alpha:1.0];
    btn1.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [btn1 setTitle:kLocalizedString(@"enter_pickta", @"进入Pick Ta") forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onChangeTagBtnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    //提示框，可有可无
    [[self.loginVM.tagCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if([x isEqualToNumber:@(YES)])
            [SVProgressHUD showWithStatus:@"Loading"];
        else
            [SVProgressHUD dismiss];
    }];
    [self.loginVM.tagCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSArray class]]) {
            @strongify(self);
            [self->strArray removeAllObjects];
            [self->strArray addObjectsFromArray:x];
            [self->tagList setTagWithTagArray:self->strArray];
            self->btn.y = self->tagList.frame.origin.y + self->tagList.frame.size.height + 20;
        }
    }];
    [self onChangeTagBtnAction];
}

- (void)onChangeTagBtnAction {
    [self.loginVM.tagCommand execute:nil];
}

// 进入
- (void)onChangeTagBtnAction1 {
    NSMutableString *tagStr = [NSMutableString string];
    if (!selectTagArray.count) {
        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
        return;
    } else {
        for (PTTagModel *tagModel in selectTagArray) {
            [tagStr appendString:tagModel.name];
            [tagStr appendString:@","];
        }
    }
    
    [self.loginVM.usernameSetCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSError class]]) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:((NSError *)x).domain];
        } else if ([x intValue] == -1) {
            [SVProgressHUD showWithStatus:@"load..."];
        } else {
            [SVProgressHUD dismiss];
            [UIApplication.sharedApplication.keyWindow setRootViewController:PickTaRootViewController.new];
        }
    }];
    self.loginVM.usernameSetParam = @{@"nickname":self.nickname,@"sex":self.sex,@"tag":[tagStr substringToIndex:tagStr.length-1]};
    [self.loginVM.usernameSetCommand execute:nil];
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

//
//  PickTaHomeVC.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaHomeVC.h"
#import "DSphereView.h"
#import "DHomeView.h"
#import "DHomeModel.h"
#import "PTIntroVC.h"
#import "PickTaLoginVC.h"
#import "PickTaHomeVM.h"

@interface PickTaHomeVC ()
@property (nonatomic, strong) DSphereView *sphereView;
@property (nonatomic, strong) NSMutableArray *homeViewArray;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) PickTaHomeVM *homeVM;
@end

@implementation PickTaHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupUI {
//    self.navigationItem.title = kLocalizedString(@"home", @"首页");
    self.navigationItem.title = @"HOME";
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"home_bg"];
    [self.view addSubview:imageView];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.tag = 101;
    button1.hidden = YES;
    button1.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [button1 setImage:[UIImage imageNamed:@"home_button_1"] forState:UIControlStateNormal];
    [button1 setTitle:kLocalizedString(@"极速匹配", @"极速匹配") forState:UIControlStateNormal];
    [button1 wbc_changeTitleLeftWithPadding:5];
    button1.frame = CGRectMake(kLeftRightMargin, NAV_HEIGHT, 130, 40);
    [button1 addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.tag = 102;
    button2.hidden = YES;
    button2.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [button2 setImage:[UIImage imageNamed:@"home_button_2"] forState:UIControlStateNormal];
    [button2 setTitle:kLocalizedString(@"精确查找", @"精确查找") forState:UIControlStateNormal];
    [button2 wbc_changeTitleLeftWithPadding:5];
    button2.frame = CGRectMake(SCREEN_WIDTH - kLeftRightMargin - 130, NAV_HEIGHT, 130, 40);
    [button2 addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

//    CGFloat huanBtnHeight = 15;
//    CGFloat platformBgHeight = 200;
//    CGFloat platformPadding = 7.5f;
//    CGFloat platformHeight = 86.2;
//    CGFloat platformRowY = 0.f;
//    CGFloat platformWidth = (SCREEN_WIDTH - kLeftRightMargin * 2.0 - 3.0 * platformPadding) / 4.f;
//    CGFloat platformBtnWidth = 40.f;
//    NSDictionary *platformName = @{
//            @"1": kLocalizedString(@"platform_1", @"Pick Ta"),
//            @"2": kLocalizedString(@"platform_2", @"微信"),
//            @"3": kLocalizedString(@"platform_3", @"QQ"),
//            @"4": kLocalizedString(@"platform_4", @"Telegram"),
//            @"5": kLocalizedString(@"platform_5", @"Facebook"),
//            @"6": kLocalizedString(@"platform_6", @"Twitter"),
//            @"7": kLocalizedString(@"platform_7", @"What's app"),
//            @"8": kLocalizedString(@"platform_8", @"其他")
//    };
//    UIView *platformView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT - platformBgHeight, SCREEN_WIDTH, platformBgHeight)];
//    platformView.backgroundColor = UIColor.clearColor;
//    [self.view addSubview:platformView];
//    for (int i = 0; i < 8; i++) {
//        if (i > 3) {
//            platformRowY = platformPadding + platformHeight;
//        }
//
//        UIView *bgview = [[UIView alloc] init];
//        bgview.frame = CGRectMake(kLeftRightMargin + i % 4 * (platformPadding + platformWidth), platformRowY, platformWidth, platformHeight);
//        bgview.backgroundColor = [UIColor colorWithRed:25 / 255.0 green:16 / 255.0 blue:28 / 255.0 alpha:1.0];
//        bgview.layer.cornerRadius = 6;
//        [platformView addSubview:bgview];
//
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((platformWidth - platformBtnWidth) / 2.f, 14, platformBtnWidth, platformBtnWidth)];
//        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"Platform_%d", i + 1]];
//        [bgview addSubview:img];
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom, platformWidth, platformHeight - img.bottom)];
//        label.numberOfLines = 1;
//        label.textAlignment = NSTextAlignmentCenter;
//        [bgview addSubview:label];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[platformName objectForKey:[NSString stringWithFormat:@"%d", i + 1]] attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1.0] }];
//        label.attributedText = string;
//
//        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        button1.tag = 200 + i;
//        button1.frame = bgview.bounds;
//        [button1 addTarget:self action:@selector(onPlatformButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bgview addSubview:button1];
//    }

    // 换一批
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button3.tag = 103;
    button3.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [button3 setImage:[UIImage imageNamed:@"home_huanBtn"] forState:UIControlStateNormal];
    [button3 setTitle:kLocalizedString(@"换一批", @"换一批") forState:UIControlStateNormal];
    [button3 wbc_changeTitleLeftWithPadding:5];
//    button3.frame = CGRectMake((SCREEN_WIDTH - 60.f) / 2.f, platformView.top - 15 - 20, 60, 15);
    [button3 addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    NSArray *arr = @[kLocalizedString(@"change_batch", @"换一批"),kLocalizedString(@"speed_match", @"极速匹配"),kLocalizedString(@"precise_search", @"精准查找"),kLocalizedString(@"interest_tribe", @"兴趣部落")];
    UIView *subView = nil;
    for (int i=0; i<arr.count; i++) {
        
        UIView *typeView = [self p_getSubTypeOperateViewWithTag:100+i title:arr[i]];
        [self.view addSubview:typeView];
        [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (subView) {
                make.left.equalTo(subView.mas_right).offset(8);
            } else {
                make.left.equalTo(self.view.mas_left).offset(15);
            }
            make.bottom.equalTo(self.view.mas_bottom).offset(-20-50-([UIApplication sharedApplication].statusBarFrame.size.height==20?0:34));
            make.width.mas_equalTo((kScreenWidth-30-24)/4);
            make.height.mas_equalTo((kScreenWidth-30-24)/4/81*104);
        }];
        
        subView = typeView;
    }
    
    
    
}
- (UIView *)p_getSubTypeOperateViewWithTag:(NSInteger)tag title:(NSString *)title {
    
    UIView *subTypeView = [UIView new];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_icon_%ld", tag-100]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [subTypeView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(subTypeView);
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = UIColor.whiteColor;
    label.text = title;
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    [subTypeView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subTypeView);
        make.bottom.equalTo(subTypeView.mas_bottom).offset(-16);
    }];
    
    return subTypeView;
}
 
- (void)onButtonAction:(UIButton *)button {
    if (button.tag == 100) { // 换一批
        [self.sphereView removeFromSuperview];
        [self.homeVM.userHomeCommand execute:nil];
    } else if (button.tag == 101) { //极速匹配
//        [SVProgressHUD showInfoWithStatus:@"极速匹配"];
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
    } else if (button.tag == 102) { //精确查找
//        [SVProgressHUD showInfoWithStatus:@"精确查找"];
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
    } else if (button.tag == 103) { //群聊派对
//        [SVProgressHUD showInfoWithStatus:@"群聊派对"];
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
    }
}
//- (void)onPlatformButtonAction:(UIButton *)button {
//    if (button.tag == 201) { // Pick Ta
//    } else if (button.tag == 202) { // 微信
//    } else if (button.tag == 203) { // QQ
//    } else if (button.tag == 204) { // Telegram
//    } else if (button.tag == 205) { // Facebook
//    } else if (button.tag == 206) { // Twitter
//    } else if (button.tag == 207) { // What's app
//    } else if (button.tag == 208) { //其他
//    }
//}

- (void)createVM {
    self.homeVM = PickTaHomeVM.new;
}

- (void)requestData {
    self.listArray = [NSMutableArray arrayWithArray:@[]];
    self.homeViewArray = [NSMutableArray arrayWithArray:@[]];
    [self.homeVM.userHomeCommand execute:nil];
}

- (void)bindViewModel {
    @weakify(self);
    [[self.homeVM.userHomeCommand.executing skip:1] subscribeNext:^(NSNumber *_Nullable x) {
        if ([x isEqualToNumber:@(YES)]) [SVProgressHUD showWithStatus:@"Loading"];
        else [SVProgressHUD dismiss];
    }];

    //命令结束
    [self.homeVM.userHomeCommand.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        @strongify(self);
        [self.homeViewArray removeAllObjects];
        [self.sphereView removeAllSubviews];
        self.listArray = x;
        if (!Array_IsEmpty(self.listArray)) {
            for (NSInteger i = 0; i < self.listArray.count; i++) {
                DHomeView *homeView = [self initializeHomeView:i];
                [self.homeViewArray addObject:homeView];
                [self.sphereView addSubview:homeView];
            }
            [self.view addSubview:self.sphereView];
            [self.sphereView setCloudTags:self.homeViewArray];
        }
    }];
}

- (DHomeView *)initializeHomeView:(NSInteger)row {
    DHomeView *homeView = [[DHomeView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    DHomeModel *model = self.listArray[row];
    model.homeTitle = model.nickname;
    [homeView setData:model];
    homeView.tag = row;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
    [homeView addGestureRecognizer:tapGes];

    return homeView;
}

- (void)tapGes:(UITapGestureRecognizer *)ges {
    DHomeView *homeView = (DHomeView *)ges.view;
    NSLog(@"%@", homeView.titleLabel.text);
    
    PTIntroVC *vc = [[PTIntroVC alloc] init];
    vc.itemModel = homeView.model;
    [self.navigationController pushViewController:vc animated:true];
}

- (DSphereView *)sphereView {
    if (!_sphereView) {
        _sphereView = [[DSphereView alloc] initWithFrame:CGRectMake(50, NAV_HEIGHT+40, kScreenWidth-100, kScreenWidth-30)];
    }
    return _sphereView;;
}
@end

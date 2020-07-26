//
//  PTMyProfileInfoVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/11.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyProfileInfoVC.h"
#import "PTMyPlatformTVC.h"
#import "PTMyInputTVC.h"
#import "PTMyTagTVC.h"
#import "PTMyVM.h"
//#import "PickTaRegosterVM.h"

@interface PTMyProfileInfoVC () <UITableViewDelegate, UITableViewDataSource, RootCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableDictionary *dicH;

@property (nonatomic, strong) PTMyVM *myVM;
//@property (nonatomic,strong) PickTaRegosterVM *reVM;

@end

@implementation PTMyProfileInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn setTitle:kLocalizedString(@"submit", @"提交") forState:UIControlStateNormal];
    self.dataList = NSMutableArray.new;
//    self.dataList = [NSMutableArray arrayWithArray:@[@"大衣",@"衬衫",@"T-shirt",@"配饰",@"学院风",@"都市风", @"卫衣",@"长裙"]];

    [self setupNavBar];
    [self setupUI];
    // [self.contentTableView.mj_header beginRefreshing];
}

- (void)bindViewModel {
    @weakify(self)
    self.myVM = [PTMyVM new];
//    self.reVM = [PickTaRegosterVM new];
    [self.myVM.myCommand.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        @strongify(self)

        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            self.myModel = x;

            if (self.myModel.tag.length) {
                NSString *tag = [PTMyProfileInfoVC replaceUnicode:self.myModel.tag];
                NSLog(@"self.myModel.tag:%@", tag);
                NSString *tempStr1 = [tag stringByReplacingOccurrencesOfString:@"["withString:@""];
                NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString *tempStr3 = [tempStr2 stringByReplacingOccurrencesOfString:@"]" withString:@""];
                [self.dataList removeAllObjects];
                [self.dataList addObjectsFromArray:[[tempStr3 componentsSeparatedByString:@","] copy]];
            }

            [self.contentTableView reloadData];
        }
    }];
    
    [self.myVM.briefCommand.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        @strongify(self)

        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            [self.view makeToast:x duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        }
    }];
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

#pragma mark - Network Request

- (void)requestData {
//    [self.contentTableView.mj_header endRefreshing];
    [self.myVM.myCommand execute:nil];
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;// self.list.count;
}

//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//    }
//
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 210;
//    } else
    if (indexPath.row == 0) {
        return 155;
    } else {
        NSNumber *num = self.dicH[indexPath];

        return [num floatValue] + 120;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        PTMyPlatformTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyPlatformTVC"];
//
//        return cell;
//    } else
    if (indexPath.row == 0) {
        PTMyInputTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyInputTVC"];
        cell.textView.text = self.myModel.user_brief;

        return cell;
    } else {
        PTMyTagTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTMyTagTVC"];
        cell.dataList = self.dataList;
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell.collectionView reloadData];

        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 10;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - RootTableCellDelegate

- (void)updateTableViewCellHeight:(PTMyTagTVC *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [self.contentTableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
}

#pragma mark - UI

- (void)setupNavBar {
    self.title = kLocalizedString(@"my_profile", @"我的资料");
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
}

- (void)setupUI {
    self.view.backgroundColor = COLOR_F7F8FA;
    self.contentTableView.backgroundColor = COLOR_F7F8FA;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.tableFooterView = UIView.new;
//    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTMyMHGRowTVC class]) bundle:nil] forCellReuseIdentifier:@"PTMyMHGRowTVC"];
//    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTMyMHGRowTVC class]) bundle:nil] forCellReuseIdentifier:@"PTMyMHGRowTVC"];
    // [self.view addSubview:self.contentTableView];
//    _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
}

#pragma mark - Notification

- (void)addNotification {
}

- (void)removeNotification {
}

- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }

    return _dicH;
}

- (IBAction)submitBtnAction:(id)sender {
    PTMyInputTVC *cell = [self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    if (cell.textView.text.length == 0) {
        [self.view makeToast:@"请你先输入个人简介" duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }

    if (self.dataList.count == 0) {
        [self.view makeToast:@"请你先添加标签" duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        return;
    }

//     PTMyTagTVC *cell2 = [self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    UICollectionView *cbb = cell2.collectionView;
//    NSMutableArray *mArray = [NSMutableArray new];
    NSMutableString *mstr = NSMutableString.new;
    [mstr appendString:@"["];

    for (int i = 0; i < self.dataList.count; i++) {
        [mstr appendString:@"\""];
        [mstr appendString:self.dataList[i]];
        [mstr appendString:@"\""];

        if (i != self.dataList.count - 1) {
            [mstr appendString:@","];
        }
    }
    [mstr appendString:@"]"];

    self.myVM.briefParam = @{
        @"desc": cell.textView.text,
        @"tag": mstr
    };
    
    [self.myVM.briefCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if (![x isKindOfClass:NSError.class]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [self.myVM.briefCommand execute:nil];
}

@end

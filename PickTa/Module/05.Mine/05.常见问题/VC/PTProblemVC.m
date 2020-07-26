//
//  PTProblemVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTProblemVC.h"
#import "XSWJVANSString+BH.h"
#import "PTHelpCenterVM.h"

@interface PTProblemVC ()
@property (nonatomic, strong) YUFoldingTableView *foldingTableView;

@property (nonatomic, strong) PTHelpCenterVM *vm;
@property (nonatomic, strong) PTHelpCenterListModel *listModel;
@end
@implementation PTProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = kLocalizedString(@"common_problem", @"常见问题");
    // 创建tableView
    [self setupFoldingTableView];
    [self.foldingTableView.mj_header beginRefreshing];
}

// 创建tableView
- (void)setupFoldingTableView {
    self.arrowPosition = 1;
    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    _foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.bounds.size.width, self.view.bounds.size.height - topHeight)];
    [self.view addSubview:_foldingTableView];
    _foldingTableView.foldingDelegate = self;
    _foldingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _foldingTableView.sectionStateArray = @[@"0", @"0", @"0"];
    _foldingTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    _foldingTableView.tableFooterView = UIView.new;// currentPage

    if (@available(iOS 11.0, *)) {
        _foldingTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        _foldingTableView.contentInset = UIEdgeInsetsMake(-54, 0, 0, 0);
//        _foldingTableView.scrollIndicatorInsets = _foldingTableView.contentInset;
    }
//    else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    if (self.arrowPosition) {
        _foldingTableView.foldingState = YUFoldingSectionStateShow;
    }
}

- (void)bindViewModel {
    @weakify(self)
    self.vm = [PTHelpCenterVM new];

    [self.vm.command1.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.foldingTableView.mj_header endRefreshing];
        
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self.view makeToast:error.domain duration:1.f position:[NSValue valueWithCGPoint:self.view.toastPoint]];
        } else {
            PTHelpCenterListModel *model = (PTHelpCenterListModel *)x;
            self.listModel = model;
            [self.foldingTableView reloadData];
        }
    }];
}

#pragma mark - Network Request

- (void)refreshData {
    self.vm.param1 = @{};
    [self.foldingTableView.mj_header endRefreshing];
    [self.vm.command1 execute:nil];
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）

- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView {
    return self.listModel.data.count;
}

- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section {
    return 1;
}

- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section {
    PTHelpCenterItemModel *model = self.listModel.data[section];
    CGSize size = [model.title sizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] maxW:SCREEN_WIDTH-30];
    
    return size.height+15;
}

- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTHelpCenterItemModel *model = self.listModel.data[indexPath.section];

    CGSize size = [model.desc sizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] maxW:SCREEN_WIDTH-30];

    return size.height+15;
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTHelpCenterItemModel *model = self.listModel.data[indexPath.section];
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = model.desc;
    cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    cell.textLabel.numberOfLines = 0;
    
    CGSize size = [cell.textLabel.text sizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] maxW:SCREEN_WIDTH-30];
    cell.textLabel.frame = CGRectMake(15, 5, SCREEN_WIDTH-30, size.height);

    return cell;
}

#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section {
    PTHelpCenterItemModel *model = self.listModel.data[section];
    
    return model.title;
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView {
    // 没有赋值，默认箭头在左
    return YUFoldingSectionHeaderArrowPositionRight;
}

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section {
    return @"";
}

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section {
    return UIColor.whiteColor;
}

- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForTitleInSection:(NSInteger )section {
    return [UIFont fontWithName:@"PingFang SC" size: 14];
}

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger )section {
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
}

//- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForDescriptionInSection:(NSInteger )section;
//- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForDescriptionInSection:(NSInteger )section;

@end

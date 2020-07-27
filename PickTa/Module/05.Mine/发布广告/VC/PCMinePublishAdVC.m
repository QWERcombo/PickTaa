//
//  PCMinePublishAdVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PCMinePublishAdVC.h"
#import "PTPublishHeadTVC.h"
#import "PTPublishContentTVC.h"
#import "PTPublishCoverTVC.h"
#import "PickTaPsdView.h"

@interface PCMinePublishAdVC () <UITableViewDelegate, UITableViewDataSource, RootCellDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *imageDataList;
@property (nonatomic, strong) NSMutableDictionary *dicH;

@property (nonatomic, strong) PTPublishHeadTVC *cell1;
@property (nonatomic, strong) PTPublishContentTVC *cell2;
@property (nonatomic, strong) PTPublishCoverTVC *cell3;
@end
@implementation PCMinePublishAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kLocalizedString(@"publish_ad", @"发布广告");

    [self setupNavBar];
    [self setupUI];
    [self configSubmit];
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;// self.list.count;
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
    if (indexPath.row == 0) {
        return 97;
    } else if (indexPath.row == 2) {
        return 155;
    } else {
        NSNumber *num = self.dicH[indexPath];
        
        if ([num floatValue] < 0.001) {
            return 103+(330-85);
        }
        return [num floatValue]+(330-85);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PTPublishHeadTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTPublishHeadTVC"];
        self.cell1 = cell;
        return cell;
    } else if (indexPath.row == 1) {
        PTPublishContentTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTPublishContentTVC"];
        cell.tableView = tableView;
        cell.suVC = self;
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.dataList = self.imageDataList;
        [cell.contentCollectionView reloadData];
        self.cell2 = cell;
        return cell;
    } else {
        PTPublishCoverTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"PTPublishCoverTVC"];
//        cell.dataList = self.dataList;
//        cell.delegate = self;
//        cell.indexPath = indexPath;
        cell.suVC = self;
        self.cell3 = cell;
        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 10;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

#pragma mark - RootTableCellDelegate

- (void)updateTableViewCellHeight:(PTPublishCoverTVC *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [self.contentTableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"1" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - UI

- (void)setupNavBar {
    
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
}

- (void)setupUI {
    // self.view.backgroundColor = COLOR_F7F8FA;
    // self.contentTableView.backgroundColor = COLOR_F7F8FA;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.tableFooterView = UIView.new;
    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTPublishHeadTVC class]) bundle:nil] forCellReuseIdentifier:@"PTPublishHeadTVC"];
    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTPublishContentTVC class]) bundle:nil] forCellReuseIdentifier:@"PTPublishContentTVC"];
    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTPublishCoverTVC class]) bundle:nil] forCellReuseIdentifier:@"PTPublishCoverTVC"];
    
    UIImage *image = [UIImage imageNamed:@"mine_add_pic"];
    image.accessibilityIdentifier = @"1000";
    self.imageDataList = [[NSMutableArray alloc] initWithObjects:image, nil];
}

- (void)configSubmit {
    [self.publishBtn setTitle:kLocalizedString(@"release", @"发布") forState:UIControlStateNormal];
    [[self.publishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (!self.cell1.inputTfl.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入标题"];
            return;
        }
        if (!self.cell2.inputTxt.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入发布内容"];
            return;
        }
        if (!(self.cell2.dataList.count-1)) {
            [SVProgressHUD showErrorWithStatus:@"请选择图片"];
            return;
        }
        if (!self.cell3.coverImg) {
            [SVProgressHUD showErrorWithStatus:@"请选择封面图片"];
            return;
        }

        PickTaPsdView *psdView = [[PickTaPsdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        @weakify(self);
        [psdView setFinishedBlock:^(NSString * _Nonnull paypsd) {
            @strongify(self);
            __block NSString *images = @"";
            __block NSString *image = @"";
            [SVProgressHUD showWithStatus:@"loading..."];
            [[PickHttpManager shared] uploadPhone:API_Upload withParam:self.cell2.dataList withPregress:^(id  _Nonnull obj) {
            } withSuccess:^(id  _Nonnull obj) {
                images = obj;
                [[PickHttpManager shared] uploadPhone:API_Upload withParam:@[self.cell3.coverImg] withPregress:^(id  _Nonnull obj) {
                } withSuccess:^(id  _Nonnull obj) {
                    image = obj;
                    [[PickHttpManager shared] requestPOST:API_AdvertPublish withParam:@{
                        @"title":self.cell1.inputTfl.text,
                        @"content":self.cell2.inputTxt.text,
                        @"image":image,
                        @"images":images,
                        @"pay_password":paypsd} withSuccess:^(id  _Nonnull obj) {
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    } withFailure:^(NSError * _Nonnull err) {
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:err.domain];
                    }];
                } withFailure:^(NSError * _Nonnull err) {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:err.domain];
                }];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        }];
        [UIApplication.sharedApplication.keyWindow addSubview:psdView];
         
    }];

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


@end

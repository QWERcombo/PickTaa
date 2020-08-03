//
//  PTChatDetaiVC.m
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatDetaiVC.h"
#import "PTChatViewFactory.h"
#import "PTChatRecordContentVM.h"
#import "SDChatTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "PTChatGroupSettingVC.h"
#import "PTChatBottomOperateView.h"
#import "PTExchangeVC.h"
#import "PTChatRedPacketCreateVC.h"
#import "TZImagePickerController.h"
#import "CSXImageCompressTool.h"
#import "PTChatRecordContentModel.h"
#import "SDPhotoBrowser.h"
@interface PTChatDetaiVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic,strong) PTChatBottomView *bottomView;
@property (nonatomic,strong) PTChatBottomOperateView *operateView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PTChatRecordContentVM *contentVM;
@property (nonatomic,strong) NSArray *contentList;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) NSIndexPath *previewIndexPath;
@end

#define kChatTableViewControllerCellId @"ChatTableViewController"

@implementation PTChatDetaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"chat_bg"];
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-58-HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = imageView;
    [self.tableView registerClass:[SDChatTableViewCell class] forCellReuseIdentifier:kChatTableViewControllerCellId];
    self.tableView.estimatedRowHeight = 213;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.bottomView = [PTChatViewFactory createChatBottomView];
    self.bottomView.frame = CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, 58);
    self.bottomView.inputTV.delegate = self;
    [self.view addSubview:self.bottomView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestData) name:ReceiveMessage object:nil];
    @weakify(self);
    [[self.bottomView.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        [self showOperateView:x.selected];
    }];
    
    self.operateView = [[PTChatBottomOperateView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom+58, kScreenWidth, 110) titleArr:self.type.intValue == 1 ? @[@"图片",@"红包",@"转账"] : @[@"图片",@"红包"]];
    [self.operateView setCompleteBlock:^(NSString * _Nonnull selectTitle) {
        @strongify(self);
        if ([selectTitle isEqualToString:@"图片"]) {
            TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
            picker.allowPickingVideo = NO;
            picker.allowPickingOriginalPhoto = NO;
            picker.minImagesCount = 1;
            picker.alwaysEnableDoneBtn = YES;
            picker.sortAscendingByModificationDate = YES;
            picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
            picker.barItemTextColor = UIColor.blackColor;
            picker.naviBgColor = UIColor.whiteColor;
            [self presentViewController:picker animated:YES completion:nil];
            [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                [PickHttpManager.shared uploadPhone:API_Upload withParam:photos withPregress:^(id  _Nonnull obj) {
                    NSLog(@"%@", obj);
                } withSuccess:^(id  _Nonnull obj) {
                    NSDictionary *dict = @{@"to_id":self.to_id,
                                           @"type":self.type,
                                           @"chat_type":@"2",
                                           @"pic":obj
                    };
                    [self.contentVM.recordSendCommand execute:dict];
                } withFailure:^(NSError * _Nonnull err) {
                    [SVProgressHUD showErrorWithStatus:err.domain];
                }];
            }];
        } else if ([selectTitle isEqualToString:@"红包"]) {
            PTChatRedPacketCreateVC *vc = [[PTChatRedPacketCreateVC alloc] initWithNibName:@"PTChatRedPacketCreateVC" bundle:nil];
            vc.type = self.type;
            [vc setCompleteRedBlock:^(NSString * _Nonnull money, NSString * _Nonnull count, NSString * _Nonnull msg, NSString * _Nonnull paypsd) {
                NSDictionary *dict = @{@"to_id":self.to_id,
                                       @"content":msg,
                                       @"type":self.type,
                                       @"chat_type":@"3",
                                       @"password":paypsd,
                                       @"money":money,
                                       @"total":count
                };
                [self.contentVM.recordSendCommand execute:dict];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([selectTitle isEqualToString:@"转账"]) {
            PTExchangeVC *vc = [[PTExchangeVC alloc] initWithNibName:@"PTExchangeVC" bundle:nil];
            vc.avatar = self.avatar;
            vc.name = self.navigationItem.title;
            [vc setCompleteExchangeBlock:^(NSString * _Nonnull money, NSString * _Nonnull paypsd) {
                NSDictionary *dict = @{@"to_id":self.to_id,
                                       @"content":@"转账",
                                       @"type":self.type,
                                       @"chat_type":@"4",
                                       @"password":paypsd,
                                       @"money":money
                };
                [self.contentVM.recordSendCommand execute:dict];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        [self showOperateView:NO];
    }];
    [self.view addSubview:self.operateView];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"chat_icon_6"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 40, 40);
    [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        PTChatGroupSettingVC *vc = [UIViewController initViewControllerFromChatStoryBoardName:@"PTChatGroupSettingVC"];
        vc.to_id = self.to_id;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
}

- (void)bindViewModel{
    @weakify(self)
    self.contentVM = [[PTChatRecordContentVM alloc]init];
    self.contentVM.fetchContentParam = @{
        @"to_id":self.to_id,
        @"type":self.type,
        @"page":@"1"};
    [self.contentVM.recordContentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.contentList = x;
        [self.tableView reloadData];
    }];
    
    [self.contentVM.recordSendCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.contentVM.recordContentCommand execute:nil];
    }];
}

- (void)requestData{
    [self.contentVM.recordContentCommand execute:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatTableViewControllerCellId forIndexPath:indexPath];
    cell.model = self.contentList[indexPath.row];
    cell.tableView = tableView;
    cell.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self.tableView cellHeightForIndexPath:indexPath model:self.contentList[indexPath.row] keyPath:@"model" cellClass:[SDChatTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTChatRecordContentModel *model = [self.contentList objectAtIndex:indexPath.row];
    if (model.chat_type == 2) {
        self.previewIndexPath = indexPath;
        
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = 0;
        browser.sourceImagesContainerView = tableView;
        browser.imageCount = 1;
        browser.delegate = self;
        [browser show];
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text hasSuffix:@"\n"]) { // 判断是否为发送,就是判断是否有回车符
        [self.view endEditing:YES];
        if ([textView.text isEqualToString:@"\n"]) {
            return;
        }
        NSString *sendStr = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *dict = @{@"to_id":self.to_id,@"content":sendStr,@"type":self.type,@"chat_type":@"1"};
        [self.contentVM.recordSendCommand execute:dict];
        textView.text = nil;
    }
}


- (void)showOperateView:(BOOL)statusValue {
    
    [UIView animateWithDuration:.3 animations:^{
        if (statusValue) {
            self.operateView.y = self.view.height-110;
            self.bottomView.y = self.view.height-110-58;
        } else {
            self.operateView.y = self.tableView.bottom+58;
            self.bottomView.y = self.tableView.bottom;
        }
    }];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    SDChatTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.previewIndexPath];
    return cell.messageImageView.image;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    PTChatRecordContentModel *model = [self.contentList objectAtIndex:self.previewIndexPath.row];
    return [NSURL URLWithString:model.pic];
}
@end

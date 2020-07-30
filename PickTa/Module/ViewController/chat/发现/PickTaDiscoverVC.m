//
//  PickTaDiscoverVC.m
//  PickTa
//
//  Created by Stark on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaDiscoverVC.h"

#import "SDRefreshHeaderView.h"
#import "SDRefreshFooterView.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "LEETheme.h"
#import "PTMyModel.h"

#import "PickTaCircleFriendVM.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"

@interface PickTaDiscoverVC ()<UITableViewDelegate,UITableViewDataSource,SDTimeLineCellDelegate,UITextFieldDelegate>{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) SDTimeLineTableHeaderView *headerView;

@property (nonatomic,strong) PickTaFriendCircleModel *dataSource;
@property (nonatomic,strong) PTMyModel *myModel;

@property (nonatomic,strong) PickTaCircleFriendVM *circleFriendVM;

@end

@implementation PickTaDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)bindViewModel{
    @weakify(self)
    [self.circleFriendVM.friendCircleCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        @strongify(self)
        self.dataSource = x;
        [self.headerView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource.cover_photo]];
        [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:self.myModel.avatar]];
        self.headerView.nameLabel.text = self.myModel.nickname;
        [self.tableView reloadData];
    }];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setImage:[UIImage imageNamed:@"chat_icon_1"] forState:UIControlStateNormal];
    publishBtn.frame = CGRectMake(0, 0, 40, 40);
    [[publishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController pushViewController:[UIViewController initViewControllerFromChatStoryBoardName:@"PTPublishDiscoverVC"] animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData{
    [self.circleFriendVM.friendCircleCommand execute:@{@"type":@"1",@"page":@"1"}];
}

- (void)setupUI{
    self.navigationItem.title = @"发现";
    [self wr_setNavBarBarTintColor:[UIColor clearColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    self.circleFriendVM = [PickTaCircleFriendVM new];
    
    self.tableView = [self createTableViewForFrame:self.view.bounds style:UITableViewStylePlain backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
//    __weak typeof(self) weakSelf = self;
    // 上拉加载
//    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
//    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
//    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
//            
//            /**
//             [weakSelf.tableView reloadDataWithExistedHeightCache]
//             作用等同于
//             [weakSelf.tableView reloadData]
//             只是“reloadDataWithExistedHeightCache”刷新tableView但不清空之前已经计算好的高度缓存，用于直接将新数据拼接在旧数据之后的tableView刷新
//             */
////            [weakSelf.tableView reloadDataWithExistedHeightCache];
//            
//            [weakRefreshFooter endRefreshing];
//        });
//    }];
    
    self.headerView = [SDTimeLineTableHeaderView new];
    self.headerView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT*0.3);
    self.tableView.tableHeaderView = self.headerView;
    
    //添加分隔线颜色设置
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
    [self setupTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (!_refreshHeader.superview) {
        
        _refreshHeader = [SDTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
        _refreshHeader.scrollView = self.tableView;
        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
        __weak typeof(self) weakSelf = self;
        [_refreshHeader setRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                weakSelf.dataArray = [[weakSelf creatModelsWithCount:10] mutableCopy];
                [weakHeader endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            });
        }];
        [self.tableView.superview addSubview:_refreshHeader];
    } else {
        [self.tableView.superview bringSubviewToFront:_refreshHeader];
    }
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, 40);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    
//    [_textField becomeFirstResponder];
//    [_textField resignFirstResponder];
}

- (void)dealloc{
    [_refreshHeader removeFromSuperview];
    [_refreshFooter removeFromSuperview];
    
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
//            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
//            model.isOpening = !model.isOpening;
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataSource.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataSource.data[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
    _textField.placeholder = nil;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];
    
}

- (void)adjustTableViewToFitKeyboard{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
//    SDTimeLineCellModel *model = self.dataSource.data[index.row];
//    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
//    if (!model.isLiked) {
//        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
//        likeModel.userName = @"GSD_iOS";
//        likeModel.userId = @"gsdios";
//        [temp addObject:likeModel];
//        model.liked = YES;
//    } else {
//        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
//        for (SDTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
//            if ([likeModel.userId isEqualToString:@"gsdios"]) {
//                tempLikeModel = likeModel;
//                break;
//            }
//        }
//        [temp removeObject:tempLikeModel];
//        model.liked = NO;
//    }
//    model.likeItemsArray = [temp copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}


- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
//        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
//        NSMutableArray *temp = [NSMutableArray new];
//        [temp addObjectsFromArray:model.commentItemsArray];
//        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
//
//        if (self.isReplayingComment) {
//            commentItemModel.firstUserName = @"GSD_iOS";
//            commentItemModel.firstUserId = @"GSD_iOS";
//            commentItemModel.secondUserName = self.commentToUser;
//            commentItemModel.secondUserId = self.commentToUser;
//            commentItemModel.commentString = textField.text;
//
//            self.isReplayingComment = NO;
//        } else {
//            commentItemModel.firstUserName = @"GSD_iOS";
//            commentItemModel.commentString = textField.text;
//            commentItemModel.firstUserId = @"GSD_iOS";
//        }
//        [temp addObject:commentItemModel];
//        model.commentItemsArray = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];

    CGRect textFieldRect = CGRectMake(0, rect.origin.y - 40, rect.size.width, 40);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }

    [UIView animateWithDuration:0.25 animations:^{
        self->_textField.frame = textFieldRect;
    }];

    CGFloat h = rect.size.height + 40;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

@end

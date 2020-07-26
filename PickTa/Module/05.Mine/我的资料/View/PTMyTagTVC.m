//
//  PTMyTagTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyTagTVC.h"
#import "PTMyTagCVC.h"
#import "EqualSpaceFlowLayout.h"

@interface PTMyTagTVC () <UICollectionViewDelegate, UICollectionViewDataSource, EqualSpaceFlowLayoutDelegate>
@property (nonatomic, assign) CGFloat heightED;
@end
@implementation PTMyTagTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.heightED = 0;
    self.inputBgView.layer.masksToBounds = YES;
    self.titleLbl.text = kLocalizedString(@"label", @"标签");
    self.inputTFd.placeholder = kLocalizedString(@"label_tip", @"请输入自定义标签(不超过10个字)");
    self.addBtn.layer.masksToBounds = YES;
    [self.addBtn setTitle:kLocalizedString(@"add", @"添加") forState:UIControlStateNormal];

    EqualSpaceFlowLayout *flowLayout = [[EqualSpaceFlowLayout alloc] init];
    flowLayout.delegate = self;
    self.collectionView.collectionViewLayout = flowLayout;

//    _flowLayout.minimumLineSpacing = 10;
//    _flowLayout.minimumInteritemSpacing = 10;
//    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [self setupCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupCollectionView {
    @weakify(self)
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        @strongify(self)

        if (String_IsEmpty(self.inputTFd.text)) {
            [[XSWJVASPTHelper getCurrentVC].view makeToast:@"请输入标签内容" duration:1.f position:[NSValue valueWithCGPoint:[XSWJVASPTHelper getCurrentVC].view.toastPoint]];
            return;
        }

        [self.dataList addObject:self.inputTFd.text];
        [self.collectionView reloadData];
        self.inputTFd.text = @"";
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;

    NSString *str = self.dataList[indexPath.row];
    NSDictionary *attrs = @{
            NSFontAttributeName: [UIFont systemFontOfSize:13.f]
    };
    CGSize size1 = [str sizeWithAttributes:attrs];

    CGFloat width = size1.width + 24;
    size = CGSizeMake(width, 44);

    return size;
}

#pragma mark - UICollectionViewLayout

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf)
    PTMyTagCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTMyTagCVC" forIndexPath:indexPath];
    cell.valueLbl.text = _dataList[indexPath.row];
    cell.deleteBtnBlock = ^(UIButton * _Nonnull button) {
        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        [weakSelf.collectionView reloadData];
    };
//    [[cell.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
//        @strongify(self)
//        NSLog(@"\n+++++++++++++:%@", self.dataList);
//        NSLog(@"+++++++++++++:%d, %d\n", self.dataList.count, indexPath.row);
//        [self.dataList removeObjectAtIndex: indexPath.row];
//        [self.collectionView reloadData];
//    }];
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
//        self.collectionView.height = self.heightED;
        self.myTagCellHeightConstraint.constant = self.heightED;
//        self.collectionView.frame = CGRectMake(0, 15, self.collectionView.frame.size.width, height);

        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSIndexPath *selectedIndexPath = [_collectionView indexPathForItemAtPoint:[_longPress locationInView:_collectionView]];
//    //当前cell
//    DragCollectionViewCell *dragCell = [_collectionView cellForItemAtIndexPath:selectedIndexPath];
//    //cell操作
////    dragCell.
//    [self.dataList exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
//    [_collectionView reloadData];
//}

@end

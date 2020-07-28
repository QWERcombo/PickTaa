//
//  PTPublishContentTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishContentTVC.h"
#import "UITextView+Placeholder.h"
#import "PTPublishImgAddCVC.h"
#import "EqualSpaceFlowLayout.h"
#import "TZImagePickerController.h"
#import "CSXImageCompressTool.h"
#import "XSWJVASPTHelper.h"

@interface PTPublishContentTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) CGFloat heightED;
@end
@implementation PTPublishContentTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.inputTxt.placeholder = kLocalizedString(@"input_ad_content", @"请输入发布内容");
    self.titleLbl.text = kLocalizedString(@"publish_content", @"发布内容");
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"PTPublishImgAddCVC" bundle:nil] forCellWithReuseIdentifier:@"PTPublishImgAddCVC"];
    [self setupCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupCollectionView {
//    @weakify(self)
//    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
//        @strongify(self)
//
//        if (String_IsEmpty(self.inputTFd.text)) {
//            [[XSWJVASPTHelper getCurrentVC].view makeToast:@"请输入标签内容" duration:1.f position:[NSValue valueWithCGPoint:[XSWJVASPTHelper getCurrentVC].view.toastPoint]];
//            return;
//        }
//
//        [self.dataList addObject:self.inputTFd.text];
//        [self.collectionView reloadData];
//        self.inputTFd.text = @"";
//    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-30-20)/3.f, (kScreenWidth-30-20)/3.f);
}

#pragma mark - UICollectionViewLayout

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf)
    PTPublishImgAddCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTPublishImgAddCVC" forIndexPath:indexPath];
    cell.btnImg.image = _dataList[indexPath.row];
//    cell.valueLbl.text = _dataList[indexPath.row];
//    cell.deleteBtnBlock = ^(UIButton * _Nonnull button) {
//        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
//        [weakSelf.collectionView reloadData];
//    };

    [self updateCollectionViewHeight:self.contentCollectionView.collectionViewLayout.collectionViewContentSize.height];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataList.count >= 9) return;

    if ((_dataList.count - 1) == indexPath.row) {
        WS(weakSelf)
        TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
        picker.maxImagesCount = 9; // 10 - _dataList.count;
        picker.allowPickingVideo = NO;
        picker.showSelectBtn = NO;
        picker.minImagesCount = 0;             /// 最小照片必选张数,默认是0
        picker.alwaysEnableDoneBtn = YES;             /// 让完成按钮一直可以点击，无须最少选择一张图片
        picker.sortAscendingByModificationDate = YES;
        /// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
        picker.allowPickingVideo = NO;
        picker.allowTakePicture = NO;
        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        picker.barItemTextColor = UIColor.blackColor;
        picker.naviBgColor = UIColor.whiteColor;
        [self.suVC presentViewController:picker animated:YES completion:nil];
        __block int i = 0;
        
        [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isStop) {
            if (weakSelf.dataList.count >= 2 && weakSelf.dataList.count < 9) {
                [weakSelf.dataList removeObjectsInRange:NSMakeRange(0, weakSelf.dataList.count-1)];
            } else if (weakSelf.dataList.count == 9) {
                UIImage *image = [weakSelf.dataList objectAtIndex:8];
                NSString *identifier = image.accessibilityIdentifier;

                if ([identifier isEqualToString:@"1000"]) { // 1000是add
                    [weakSelf.dataList removeObjectsInRange:NSMakeRange(0, 8)];
                } else {
                    [weakSelf.dataList removeAllObjects];
                    UIImage *image = [UIImage imageNamed:@"mine_add_pic"];
                    image.accessibilityIdentifier = @"1000";
                    [weakSelf.dataList addObject:image];
                }
            }
            
//            [weakSelf.dataList removeAllObjects];
//            [weakSelf.dataList addObject:[UIImage imageNamed:@"mine_add_pic"]];
            
            for (UIImage *image in photos) {
                [CSXImageCompressTool compressedImageFiles:image imageKB:200 imageBlock:^(NSData *imageData) {
                    UIImage *headerImage = [UIImage imageWithData:imageData];
                    [weakSelf.dataList insertObject:headerImage atIndex:0];

                    if (i == photos.count - 1) {
                        //[weakSelf.tableView reloadRow:1 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                        [weakSelf.contentCollectionView reloadData];
                    }
                    i++;
                }];
            }
        }];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
        self.myTagCellHeightConstraint.constant = self.heightED;

        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

@end

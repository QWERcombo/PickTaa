//
//  PTPublishDiscoverVC.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishDiscoverVC.h"
#import "TZImagePickerController.h"
#import "CSXImageCompressTool.h"

@interface PTPublishDiscoverVC () <UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation PTPublishDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.images = [NSMutableArray arrayWithCapacity:9];
    [self.images addObject:[UIImage imageNamed:@"mine_add_pic"]];
}

- (void)setupUI {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"发布" forState:UIControlStateNormal];
    addBtn.backgroundColor = MainBlueColor;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.frame = CGRectMake(0, 0, 55, 30);
    @weakify(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"%@", self.inputTV.text);
//        [PickHttpManager.shared requestPOST:API_FriendApply withParam:@{
//            @"to_id":self.userModel.id,
//            @"remarks":myModel.nickname
//        } withSuccess:^(id  _Nonnull obj) {
//            [SVProgressHUD showSuccessWithStatus:@"好友请求已发送"];
//            [self.navigationController popViewControllerAnimated:YES];
//        } withFailure:^(NSError * _Nonnull err) {
//            [SVProgressHUD showErrorWithStatus:err.domain];
//        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.yellowColor;
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.flowLayout.itemSize = CGSizeMake((kScreenWidth-32-20)/3.f, (kScreenWidth-32-20)/3.f);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.sectionInset = UIEdgeInsetsZero;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textLab.hidden = textView.text.length;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.purpleColor;
//    UIImageView *imgv = [UIImageView new];
//    imgv.contentMode = UIViewContentModeScaleAspectFill;
//    imgv.layer.masksToBounds = YES;
//    [cell.contentView addSubview:imgv];
//    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(cell.contentView);
//    }];
//    imgv.image = self.images[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.images.count >= 9) return;
    
    if ((_images.count - 1) == indexPath.row) {
        WS(weakSelf)
        TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
        picker.maxImagesCount = 9; // 10 - _images.count;
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
        [self presentViewController:picker animated:YES completion:nil];
        __block int i = 0;
        
        [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isStop) {
            if (weakSelf.images.count >= 2 && weakSelf.images.count < 9) {
                [weakSelf.images removeObjectsInRange:NSMakeRange(0, weakSelf.images.count-1)];
            } else if (weakSelf.images.count == 9) {
                UIImage *image = [weakSelf.images objectAtIndex:8];
                NSString *identifier = image.accessibilityIdentifier;
                
                if ([identifier isEqualToString:@"1000"]) { // 1000是add
                    [weakSelf.images removeObjectsInRange:NSMakeRange(0, 8)];
                } else {
                    [weakSelf.images removeAllObjects];
                    UIImage *image = [UIImage imageNamed:@"mine_add_pic"];
                    image.accessibilityIdentifier = @"1000";
                    [weakSelf.images addObject:image];
                }
            }
            
            for (UIImage *image in photos) {
                [CSXImageCompressTool compressedImageFiles:image imageKB:200 imageBlock:^(NSData *imageData) {
                    UIImage *headerImage = [UIImage imageWithData:imageData];
                    [weakSelf.images insertObject:headerImage atIndex:0];
                    
                    if (i == photos.count - 1) {
                        [weakSelf.collectionView reloadData];
                    }
                    i++;
                }];
            }
            
        }];
    }
}

@end

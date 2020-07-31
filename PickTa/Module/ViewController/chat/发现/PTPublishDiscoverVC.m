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

@interface PTPublishDiscoverVC () <UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@end

@implementation PTPublishDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        if (!self.inputTV.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入发布内容"];
            return;
        }
        if (!self.images.count) {
            [SVProgressHUD showErrorWithStatus:@"请选择发布图片"];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"Loading"];
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        dispatch_async(dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL), ^{
//            NSMutableArray *imgsArr = [NSMutableArray arrayWithCapacity:9];
//            if (self.images.count != 9) {
//                [self.images removeLastObject];
//            }
//            for (UIImage *image in self.images) {
//
//                [PickHttpManager.shared uploadPhone:API_Upload withParam:@[image] withPregress:^(id  _Nonnull obj) {
//
//                } withSuccess:^(id  _Nonnull obj) {
//                    dispatch_semaphore_signal(sema);
//                    [imgsArr addObject:obj];
//                } withFailure:^(NSError * _Nonnull err) {
//                    dispatch_semaphore_signal(sema);
//                    [SVProgressHUD showErrorWithStatus:err.domain];
//                }];
//
//                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            }
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [PickHttpManager.shared requestPOST:API_FriendPublish withParam:@{
//                    @"content":self.inputTV.text,
//                    @"image":[imgsArr modelToJSONString]
//                } withSuccess:^(id  _Nonnull obj) {
//                    [SVProgressHUD dismiss];
//                    [SVProgressHUD showSuccessWithStatus:@"发布成功"];
//                    [self.navigationController popViewControllerAnimated:YES];
//                } withFailure:^(NSError * _Nonnull err) {
//                    [SVProgressHUD showErrorWithStatus:err.domain];
//                }];
//            });
//        });
        [PickHttpManager.shared uploadPhone:API_Upload withParam:self.images withPregress:^(id  _Nonnull obj) {
        } withSuccess:^(id  _Nonnull obj) {
            [PickHttpManager.shared requestPOST:API_FriendPublish withParam:@{
                @"content":self.inputTV.text,
                @"image":[@[obj] modelToJSONString]
            } withSuccess:^(id  _Nonnull obj) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } withFailure:^(NSError * _Nonnull err) {
                [SVProgressHUD showErrorWithStatus:err.domain];
            }];
        } withFailure:^(NSError * _Nonnull err) {
            
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    self.images = [NSMutableArray arrayWithCapacity:9];
    [self.images addObject:[UIImage imageNamed:@"mine_add_pic"]];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(16, 170+NavigationContentTop, kScreenWidth-32, kScreenHeight-170-20-NavigationContentTop) collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textLab.hidden = textView.text.length;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-32-20)/3.f, (kScreenWidth-32-20)/3.f);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imgv = [UIImageView new];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    imgv.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    imgv.image = self.images[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.images.count >= 9) return;
    
    if ((_images.count - 1) == indexPath.row) {
        WS(weakSelf)
        TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
        picker.allowPickingVideo = NO;
        picker.allowPickingOriginalPhoto = NO;
        picker.minImagesCount = 1;
        picker.alwaysEnableDoneBtn = YES;
        picker.sortAscendingByModificationDate = YES;
        picker.showSelectedIndex = YES;
        picker.selectedAssets = _selectedAssets;
        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        picker.barItemTextColor = UIColor.blackColor;
        picker.naviBgColor = UIColor.whiteColor;
        [self presentViewController:picker animated:YES completion:nil];
       
        [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isStop) {
            weakSelf.selectedAssets = [NSMutableArray arrayWithArray:assets];
            [weakSelf.images removeAllObjects];
            
//            for (UIImage *image in photos) {
//                [CSXImageCompressTool compressedImageFiles:image imageKB:200 imageBlock:^(NSData *imageData) {
//                    UIImage *headerImage = [UIImage imageWithData:imageData];
//                    [weakSelf.images addObject:headerImage];
//                }];
//            }
            [weakSelf.images addObjectsFromArray:photos];
            if (weakSelf.images.count != 9) {
                [weakSelf.images addObject:[UIImage imageNamed:@"mine_add_pic"]];
            }
            [weakSelf.collectionView reloadData];
        }];
    }
}
@end

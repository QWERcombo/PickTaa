//
//  PTPublishCoverTVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTPublishCoverTVC.h"
#import "TZImagePickerController.h"
#import "CSXImageCompressTool.h"

@interface PTPublishCoverTVC ()

@end
@implementation PTPublishCoverTVC

- (void)awakeFromNib {
    [super awakeFromNib];

    self.addCoverLbl.text = kLocalizedString(@"ad_cover", @"添加广告封面");
    self.addCoverBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)addCover:(UIButton *)sender {
    
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    picker.navigationBar.translucent = NO;
    picker.maxImagesCount = 1; // 10 - _dataList.count;
    picker.allowPickingVideo = NO;
    picker.showSelectBtn = NO;
    picker.minImagesCount = 0;             /// 最小照片必选张数,默认是0
    picker.alwaysEnableDoneBtn = YES;             /// 让完成按钮一直可以点击，无须最少选择一张图片
    picker.sortAscendingByModificationDate = YES;             /// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    picker.allowPickingVideo = NO;
    picker.allowTakePicture = NO;
    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;      // UIModalPresentationFullScreen;
    [self.suVC presentViewController:picker animated:YES completion:nil];
    @weakify(self);
    [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isStop) {
        @strongify(self);
        self.coverImg = photos.firstObject;
        [self.addCoverBtn setImage:photos.firstObject forState:UIControlStateNormal];
    }];
}

@end

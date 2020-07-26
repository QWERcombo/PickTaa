//
//  PTMyPlatformQrcodeVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyPlatformQrcodeVC.h"
#import "PECropViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PTMyPlatformQrcodeVC () <PECropViewControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickController;//拍照
@property (nonatomic, strong) UIImage *headIconImg;// 临时保存
@property (nonatomic, assign) BOOL isEdited;// 已经变更
@end
@implementation PTMyPlatformQrcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.qrBgView.layer.masksToBounds = YES;
    self.qrWarnLbl.text = kLocalizedString(@"upload_qrcode", @"点击上传二维码");
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn setTitle:kLocalizedString(@"submit", @"提交") forState:UIControlStateNormal];
    
    if (self.tag == 101) {
        self.title = kLocalizedString(@"platform_1", @"Pick Ta");
      } else if (self.tag == 102) {
          self.title = kLocalizedString(@"platform_2", @"Wechat");
      } else if (self.tag == 103) {
          self.title = kLocalizedString(@"platform_3", @"QQ");
      } else if (self.tag == 104) {
          self.title = kLocalizedString(@"platform_4", @"Telegram");
      } else if (self.tag == 105) {
          self.title = kLocalizedString(@"platform_5", @"Facebook");
      } else if (self.tag == 106) {
          self.title = kLocalizedString(@"platform_6", @"Twitter");
      } else if (self.tag == 107) {
          self.title = kLocalizedString(@"platform_7", @"What's app");
      } else if (self.tag == 108) {
          self.title = kLocalizedString(@"platform_8", @"Others");
      }

    @weakify(self)
    [[self.qrSelectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
       [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"take_a_pic", @"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           [self paizhaoHelper];
       }]];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"select_from_Album", @"从相册中选择") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self xiangceButtonHelper];
        }]];
       [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"cancel", @"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
       [[XSWJVASPTHelper getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // @strongify(self)
        
    }];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.headIconImg = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:nil];
    }];
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect {
    NSData *headImgData;//头像
    CGFloat ImageSize = 0.8; // 0.1 0.5
    double imageSize = [croppedImage spt_getImageSize];
    
    if (imageSize > ImageSize) {
        float scale = ImageSize / imageSize;
        scale = sqrt(scale);
        CGSize imagesize = croppedImage.size;
        imagesize.height = imagesize.height * scale;
        imagesize.width = imagesize.width * scale;
        croppedImage = [croppedImage spt_scaledToSize:imagesize];

        headImgData = UIImagePNGRepresentation(croppedImage);////头像
    } else {
        headImgData = UIImagePNGRepresentation(croppedImage);//头像
    }

    UIImage *headerImage = [UIImage imageWithData:headImgData];
    [self.qrImgView setImage:headerImage];
    self.isEdited = YES;

    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 图片选择

- (void)paizhaoHelper {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您没有访问权限,去设置页面打开吧" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }

    self.imagePickController.delegate = self;
    self.imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePickController animated:YES completion:nil];
}

- (void)xiangceButtonHelper {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"\"足e购\"想要访问您的相册,如果不允许,您将无法选择系统相册里的照片上传头像" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"允许" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    self.imagePickController.delegate = self;
    self.imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickController animated:YES completion:nil];
}

- (void)openEditor:(id)sender {
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.title = @"裁剪";
    controller.rotationEnabled = NO;
    controller.keepingCropAspectRatio = YES;
    controller.delegate = self;
    controller.image = self.headIconImg;
    controller.keepingCropAspectRatio = YES;
    CGFloat width = self.headIconImg.size.width;
    CGFloat height = self.headIconImg.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2, (height - length) / 2, length, length);
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Setter Getter

- (UIImagePickerController *)imagePickController {
    if (!_imagePickController) {
        _imagePickController = [[UIImagePickerController alloc] init];
    }

    return _imagePickController;
}

@end

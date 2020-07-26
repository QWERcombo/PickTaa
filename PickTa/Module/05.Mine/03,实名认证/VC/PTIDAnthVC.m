//
//  PTIDAnthVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTIDAnthVC.h"
#import "PECropViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PTIDAnthVC () <PECropViewControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *contentTableView;

@property (nonatomic, strong) UIImagePickerController *imagePickController;//拍照
@property (nonatomic, strong) UIImage *headIconImg;// 临时保存
@property (nonatomic, assign) BOOL isEdited;// 已经变更
@property (nonatomic, assign) BOOL isFace;// 是否是操作的正面
@property (nonatomic, assign) BOOL isChina;// 国家是否选择了中国
@end
@implementation PTIDAnthVC

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     "country" = "国家";
     "china" = "中国";
     "other_country" = "海外";
     */
    self.isChina = YES;
    self.title = kLocalizedString(@"auth", @"实名认证");
    self.countryTitleLbl.text = kLocalizedString(@"country", @"国家");
    self.countryLbl.text = kLocalizedString(@"china", @"中国");
    self.areaLbl.text = kLocalizedString(@"area", @"地区");
    self.areaTfl.placeholder = kLocalizedString(@"in_truth", @"请如实填写");
    self.nameLbl.text = kLocalizedString(@"real_name", @"真实姓名");
    self.nameTfl.placeholder = kLocalizedString(@"in_truth", @"请如实填写");
    self.idTypeLbl.text = kLocalizedString(@"cer_type", @"证件类型");
    self.idTypeValueLbl.text = kLocalizedString(@"id_card", @"身份证");// "" = "";
    self.idNumLbl.text = kLocalizedString(@"id_number", @"证件号码");
    self.idNumTfl.placeholder = kLocalizedString(@"input_id_number", @"请输入证件号码");
    self.upIdFaceLbl.text = kLocalizedString(@"up_id_face", @"上传护照正面");
    self.upIdBackLbl.text = kLocalizedString(@"up_id_back", @"上传护照反面");
//    [self.upIdFaceBtn setTitle:kLocalizedString(@"", @"") forState:UIControlStateNormal];
//    [self.upIdBackBtn setTitle:kLocalizedString(@"", @"") forState:UIControlStateNormal];
    [self.confirmBtn setTitle:kLocalizedString(@"define", @"确定") forState:UIControlStateNormal];

    @weakify(self)
    [[self.countryBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        @strongify(self)

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"china", @"中国") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.isChina = YES;
            self.countryLbl.text = kLocalizedString(@"china", @"中国");
            self.idTypeValueLbl.text = kLocalizedString(@"id_card", @"身份证");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"other_country", @"海外") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.isChina = false;
            self.countryLbl.text = kLocalizedString(@"other_country", @"海外");
            self.idTypeValueLbl.text = kLocalizedString(@"other_id_card", @"社会安全号");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"cancel", @"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
        [[XSWJVASPTHelper getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }];
    [[self.upIdFaceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        @strongify(self)
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        self.isFace = YES;
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"take_a_pic", @"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self paizhaoHelper];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"select_from_Album", @"从相册中选择") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self xiangceButtonHelper];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"cancel", @"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
        [[XSWJVASPTHelper getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }];
    [[self.upIdBackBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        @strongify(self)
        self.isFace = false;
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
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {
        @strongify(self)
        
        if (self.isChina) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:kLocalizedString(@"tip", @"提示") message:@"\n中国大陆地区的会员，需通过支付宝收取1.5元进行实名认证。\n" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"cancel", @"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
            [alert addAction:[UIAlertAction actionWithTitle:kLocalizedString(@"define", @"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // [self submitAuthHelper];
            }]];
            [[XSWJVASPTHelper getCurrentVC] presentViewController:alert animated:YES completion:nil];
        } else {
            [self submitAuthHelper];
        }
    }];
}

#pragma mark - Action

- (void)submitAuthHelper {
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];

    // Configure the cell...

    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

    if (self.isFace) {
        [self.upIdFaceBtn setBackgroundImage:headerImage forState:UIControlStateNormal];
    } else {
        [self.upIdBackBtn setBackgroundImage:headerImage forState:UIControlStateNormal];
    }

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

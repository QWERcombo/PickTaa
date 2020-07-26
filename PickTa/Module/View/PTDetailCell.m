//
//  PTDetailCell.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDetailCell.h"
#import "SDPhotoBrowser.h"

@interface PTDetailCell ()<SDPhotoBrowserDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timerDown;
@end

@implementation PTDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.photo.layer.cornerRadius = 6;
    self.photo.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.quanBtn.layer.cornerRadius = 6;
    self.quanBtn.layer.masksToBounds = YES;
    self.shangBtn.layer.cornerRadius = 6;
    self.shangBtn.layer.masksToBounds = YES;
    self.shangBtn.backgroundColor = COLOR_HEX_RGB(0xE8E8E8);
    self.shangBtn.enabled = NO;
    [self.shangBtn setTitleColor:COLOR_HEX_RGB(0x999999) forState:UIControlStateNormal];
    self.timerDown = 10;
    
    @weakify(self);
    [self.photo addGestureRecognizer:({
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
        [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            NSString *images = self.model.images;
            images = [images stringByReplacingOccurrencesOfString:@"[" withString:@""];
            images = [images stringByReplacingOccurrencesOfString:@"]" withString:@""];
            images = [images stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSArray *imagesArr = [images componentsSeparatedByString:@","];
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = 0;
            browser.sourceImagesContainerView = nil;
            browser.imageCount = imagesArr.count;
            browser.delegate = self;

            [browser show];
        }];
        tapGes;
    })];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PickTaAdvDiscoverModel *)model{
    _model = model;
    
    self.name.text = model.user.nickname;
    self.desc.text = model.content;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (IBAction)lingQuanClick:(UIButton *)sender {
    
    [[PickHttpManager shared]requestPOST:API_AdvertCollectCouponsNew withParam:@{@"id":@(self.model.id)} withSuccess:^(id  _Nonnull obj) {
        [SVProgressHUD showSuccessWithStatus:@"领取成功"];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
}
- (IBAction)daShangClick:(UIButton *)sender {
    [SVProgressHUD showInfoWithStatus:@"打赏"];
}

- (IBAction)timerClick:(UIButton *)sender {
}


#pragma mark - SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return self.photo.image;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSString *images = self.model.images;
    images = [images stringByReplacingOccurrencesOfString:@"[" withString:@""];
    images = [images stringByReplacingOccurrencesOfString:@"]" withString:@""];
    images = [images stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSArray *imagesArr = [images componentsSeparatedByString:@","];
    return [NSURL URLWithString:[imagesArr objectAtIndex:index]];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            [self startTimer];
        } repeats:YES];
    }
    return _timer;
}
- (void)startTimer {
    self.timerDown --;
    self.countDown.text = [NSString stringWithFormat:@"%lds", self.timerDown];
    
    if (self.timerDown == 0) {
        self.countDown.text = @"可领取";
        self.shangBtn.backgroundColor = COLOR_HEX_RGB(0xFF4747);
        self.shangBtn.enabled = YES;
        [self.shangBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}
@end

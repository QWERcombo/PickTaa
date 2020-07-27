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
    
    self.timerDown = 10;
    @weakify(self);
    [self.photo addGestureRecognizer:({
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
        [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            NSArray *imagesArr = [NSJSONSerialization JSONObjectWithData:[self.model.images dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
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
    NSArray *imagesArr = [NSJSONSerialization JSONObjectWithData:[self.model.images dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if (imagesArr.count) {
        [self.photo sd_setImageWithURL:[NSURL URLWithString:imagesArr.firstObject]];
    }
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (IBAction)timerClick:(UIButton *)sender {
}


#pragma mark - SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return nil;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSArray *imagesArr = [NSJSONSerialization JSONObjectWithData:[self.model.images dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(avaliableToClickQuan)]) {
            [self.delegate avaliableToClickQuan];
        }
        [self.timer invalidate];
    }
}
@end

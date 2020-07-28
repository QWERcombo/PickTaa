//
//  PTDetailCell.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDetailCell.h"
#import "SDPhotoBrowser.h"

@interface PTDetailCell ()<SDPhotoBrowserDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timerDown;
@property (nonatomic, copy) NSArray *imagesArr;
@end

#define kItesmSize ((kScreenWidth-30-10)/3.f)

@implementation PTDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.timerDown = 10;
//    @weakify(self);
//    [self.photo addGestureRecognizer:({
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
//        [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//            @strongify(self);
//            NSArray *imagesArr = [NSJSONSerialization JSONObjectWithData:[self.model.images dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            
//        }];
//        tapGes;
//    })];
    self.flowLayout.itemSize = CGSizeMake(kItesmSize, kItesmSize);
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsZero;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"img_cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"img_cell" forIndexPath:indexPath];
    UIImageView *imgv = [UIImageView new];
    imgv.tag = 999;
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    imgv.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [imgv sd_setImageWithURL:[NSURL URLWithString:[[self.imagesArr objectAtIndex:indexPath.row] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"default_qr_img"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.sourceImagesContainerView = collectionView;
    browser.imageCount = self.imagesArr.count;
    browser.delegate = self;

    [browser show];
}

- (void)setModel:(PickTaAdvDiscoverModel *)model{
    _model = model;
    
    self.name.text = model.user.nickname;
    self.desc.text = model.content;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    self.imagesArr = [NSJSONSerialization JSONObjectWithData:[self.model.images dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSInteger row = self.imagesArr.count%3 == 0 ? self.imagesArr.count/3 :(self.imagesArr.count/3)+1;
    self.collectionHeight.constant = (row*kItesmSize)+(5*(row-1));
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (IBAction)timerClick:(UIButton *)sender {
}


#pragma mark - SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIImageView *imgv = [cell.contentView viewWithTag:999];
    return imgv.image;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    return [NSURL URLWithString:[[self.imagesArr objectAtIndex:index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
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

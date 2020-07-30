//
//  PickTaFriendDiscoverListCell.m
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaFriendDiscoverListCell.h"

@implementation PickTaFriendDiscoverListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"img_cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModel.img.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"img_cell" forIndexPath:indexPath];
    UIImageView *imgv = [UIImageView new];
    [imgv sd_setImageWithURL:[NSURL URLWithString:[self.itemModel.img objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_qr_img"]];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    [cell.contentView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}


- (void)setItemModel:(PTItemModel *)itemModel {
    _itemModel = itemModel;
    
    if (_itemModel.img.count == 1) {
        self.flowLayout.itemSize = CGSizeMake(80, 80);
    } else {
        self.flowLayout.itemSize = CGSizeMake(39.5, 39.5);
        self.flowLayout.minimumLineSpacing = 1;
        self.flowLayout.minimumInteritemSpacing = 1;
    }
    [self.collectionView reloadData];
    
    self.contentLab.text = _itemModel.content;
    self.countLab.text = [NSString stringWithFormat:@"共%ld张",self.itemModel.img.count];
    self.countLab.hidden = !(_itemModel.img.count>1);
    NSDate *date = [NSDate dateWithString:_itemModel.time format:@"yyyy-MM-dd HH:mm:ss"];
    self.dateLab.text = [NSString stringWithFormat:@"%ld %ld月", date.day,date.month];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.dateLab.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:[self.dateLab.text rangeOfString:[NSString stringWithFormat:@"%ld", date.day]]];
    self.dateLab.attributedText = attributedString;
}

@end

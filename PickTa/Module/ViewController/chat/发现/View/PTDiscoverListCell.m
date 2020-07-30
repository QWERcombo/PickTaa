//
//  PTDiscoverListCell.m
//  PickTa
//
//  Created by 赵越 on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDiscoverListCell.h"

#define kItemSize ((kScreenWidth-91)/3.f)

@implementation PTDiscoverListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.flowLayout.itemSize = CGSizeMake(kItemSize, kItemSize);
    self.flowLayout.minimumLineSpacing = 3.5;
    self.flowLayout.minimumInteritemSpacing = 3.5;
    self.flowLayout.sectionInset = UIEdgeInsetsZero;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)setItemModel:(DataItem *)itemModel {
    _itemModel = itemModel;
    
    [self.user_avatar sd_setImageWithURL:[NSURL URLWithString:_itemModel.user_avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
    self.user_name.text = _itemModel.user_name;
    self.user_content.text = _itemModel.content;
    self.user_time.text = _itemModel.time;
    
    NSInteger row = _itemModel.thumbnail.count%3 == 0 ? _itemModel.thumbnail.count/3: (_itemModel.thumbnail.count/3)+1;
    self.collectionH.constant = row*kItemSize+((row-1)*3.5);
    [self.collectionView reloadData];
    
    if (_itemModel.in_like.count) {
        NSMutableString *string = [NSMutableString stringWithCapacity:_itemModel.in_like.count+1];
        [string appendString:@" "];
        for (NSString *name in _itemModel.in_like) {
            [string appendString:name];
            [string appendString:@","];
        }
        NSTextAttachment *attach = [NSTextAttachment new];
        attach.image = [UIImage imageNamed:@"chat_icon_5"];
        attach.bounds = CGRectMake(0, -2, 16, 14);
        NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
        NSMutableAttributedString *like_str = [[NSMutableAttributedString alloc] initWithString:[string substringToIndex:string.length-1]];
        [like_str insertAttributedString:likeIcon atIndex:0];
        self.user_like.attributedText = like_str;
        self.like_top.constant = 12;
        self.like_bottom.constant = 11;
    } else {
        self.user_like.text = @"";
        self.like_top.constant = 0;
        self.like_bottom.constant = 0;
    }
    
    if (_itemModel.comment_list.count) {
        NSMutableString *string = [NSMutableString stringWithCapacity:_itemModel.comment_list.count];
        for (Comment_listItem *comment in _itemModel.comment_list) {
            [string appendString:[NSString stringWithFormat:@"%@: %@", comment.nickname,comment.comments]];
            [string appendString:@"\n"];
        }
        self.user_comment.text = string;
        self.comment_top.constant = 12;
    } else {
        self.user_comment.text = @"";
        self.comment_top.constant = 0;
    }
    
    if (!_itemModel.in_like.count && !_itemModel.comment_list.count) {
        self.infoView.hidden = YES;
        self.info_bottom.constant = 0;
    } else {
        self.infoView.hidden = NO;
        self.info_bottom.constant = 15;
    }
    if (_itemModel.in_like.count || _itemModel.comment_list.count) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModel.thumbnail.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imgv = [UIImageView new];
    imgv.tag = 999;
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    imgv.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    ThumbnailItem *item = [self.itemModel.thumbnail objectAtIndex:indexPath.row];
    [imgv sd_setImageWithURL:[NSURL URLWithString:item.img_thumbnail]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.sourceImagesContainerView = collectionView;
    browser.imageCount = self.itemModel.thumbnail.count;
    browser.delegate = self;

    [browser show];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIImageView *imgv = [cell.contentView viewWithTag:999];
    return imgv.image;
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    ThumbnailItem *item = [self.itemModel.thumbnail objectAtIndex:index];
    return [NSURL URLWithString:item.img];
}
@end

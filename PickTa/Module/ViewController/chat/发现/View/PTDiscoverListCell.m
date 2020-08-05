//
//  PTDiscoverListCell.m
//  PickTa
//
//  Created by 赵越 on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTDiscoverListCell.h"
#import "PTPublishImgAddCVC.h"

#define kItemSize ((kScreenWidth-91)/3.f)
@implementation PTDiscoverListCell {
    JRMenuView * jrMenu;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"PTPublishImgAddCVC" bundle:nil] forCellWithReuseIdentifier:@"PTPublishImgAddCVC"];
    self.flowLayout.itemSize = CGSizeMake(kItemSize, kItemSize);
    self.flowLayout.minimumLineSpacing = 3.5;
    self.flowLayout.minimumInteritemSpacing = 3.5;
    self.flowLayout.sectionInset = UIEdgeInsetsZero;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.user_avatar.layer.masksToBounds = YES;
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
        self.lineView.hidden = NO;
    } else {
        self.lineView.hidden = YES;
    }
    
    PTMyModel *myModel = [PTMyModel modelWithJSON:[PickTaUserDefaults g_getValueForKey:@"user_info"]];
    self.deleteBtn.hidden = !(_itemModel.user_id == myModel.pickID);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModel.thumbnail.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PTPublishImgAddCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTPublishImgAddCVC" forIndexPath:indexPath];
    ThumbnailItem *item = [self.itemModel.thumbnail objectAtIndex:indexPath.row];
    [cell.btnImg sd_setImageWithURL:[NSURL URLWithString:[item.img_thumbnail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"default_qr_img"]];
    
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
    return [NSURL URLWithString:[item.img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (IBAction)deleteClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(operateCellWithType:indexPath:)]) {
        [self.delegate operateCellWithType:0 indexPath:self.indexPath];
    }
}
- (IBAction)operateClick:(UIButton *)sender {
    
    NSArray * itemsArray = self.CLICKMENUBLOCK();
    
    if (!jrMenu) {
        jrMenu = [[JRMenuView alloc] init];
    }
    [jrMenu setTargetView:sender InView:self.contentView];
    [jrMenu setTitleArray:itemsArray];
    jrMenu.delegate = self;
    [self.contentView addSubview:jrMenu];
    [jrMenu show];
}
- (void)hasSelectedJRMenuIndex:(NSInteger)jrMenuIndex {
    
    if (jrMenuIndex == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(operateCellWithType:indexPath:)]) {
            [self.delegate operateCellWithType:self.itemModel.is_in_like+1 indexPath:self.indexPath];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(operateCellWithType:indexPath:)]) {
            [self.delegate operateCellWithType:3 indexPath:self.indexPath];
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [jrMenu dismiss];
}

@end

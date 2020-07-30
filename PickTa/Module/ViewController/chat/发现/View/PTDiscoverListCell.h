//
//  PTDiscoverListCell.h
//  PickTa
//
//  Created by 赵越 on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaFriendCircleModel.h"
#import "SDPhotoBrowser.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTDiscoverListCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_content;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;
@property (weak, nonatomic) IBOutlet UILabel *user_time;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *user_like;
@property (weak, nonatomic) IBOutlet UILabel *user_comment;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *like_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *like_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *info_bottom;

@property (nonatomic, strong) DataItem *itemModel;
@end

NS_ASSUME_NONNULL_END

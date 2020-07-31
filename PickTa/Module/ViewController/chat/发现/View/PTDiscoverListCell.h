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
#import "JRMenuView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PTDiscoverListCellDelegate <NSObject>
/// 0删除 1点赞 2取消点赞 3评论
- (void)operateCellWithType:(NSInteger)operateType indexPath:(NSIndexPath *)indexPath;

@end

@interface PTDiscoverListCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate,JRMenuDelegate>

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
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *like_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *like_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *info_bottom;

@property (nonatomic, strong) DataItem *itemModel;
@property (nonatomic, weak) id<PTDiscoverListCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSArray *(^CLICKMENUBLOCK)(void);
@end

NS_ASSUME_NONNULL_END

//
//  PTDetailCell.h
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickTaAdvDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PTDetailCellDelegate <NSObject>

- (void)avaliableToClickQuan;

@end

@interface PTDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *countDown;
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UIView *callAction;
@property (weak, nonatomic) IBOutlet UIView *quanAction;
@property (weak, nonatomic) IBOutlet UIView *shangAction;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;


@property (nonatomic,strong) PickTaAdvDiscoverModel *model;
@property (nonatomic, weak) id<PTDetailCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

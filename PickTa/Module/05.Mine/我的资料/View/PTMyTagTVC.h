//
//  PTMyTagTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PTMyTagTVC;
@protocol RootCellDelegate <NSObject>
/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(PTMyTagTVC *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;
/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface PTMyTagTVC : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, weak) id<RootCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTagCellHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UITextField *inputTFd;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END

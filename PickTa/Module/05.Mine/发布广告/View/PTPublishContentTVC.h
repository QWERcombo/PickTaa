//
//  PTPublishContentTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/14.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTPublishContentTVC;
@protocol RootCellDelegate <NSObject>
/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(PTPublishContentTVC *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;
/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface PTPublishContentTVC : UITableViewCell

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIViewController *suVC;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, weak) id<RootCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *inputTxt;
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTagCellHeightConstraint;

@end

NS_ASSUME_NONNULL_END

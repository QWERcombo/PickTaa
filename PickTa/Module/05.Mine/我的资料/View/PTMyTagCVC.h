//
//  PTMyTagCVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTMyTagCVC : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *valueBgView;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;

@property (copy, nonatomic) void(^deleteBtnBlock)(UIButton *button);
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)onDeleteBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END

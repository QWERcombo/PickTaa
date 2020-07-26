//
//  PTMyInputTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/11.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTMyInputTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UIView *bgTextView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

NS_ASSUME_NONNULL_END

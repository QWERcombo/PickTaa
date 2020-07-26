//
//  PTMyMHGHeadTVC.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/10.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTMyTGBLHeadTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *profileBgView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;

// 头像
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headBgImgView;
// 五角星
@property (weak, nonatomic) IBOutlet UIImageView *wjxImgView1;
@property (weak, nonatomic) IBOutlet UIImageView *wjxImgView2;
@property (weak, nonatomic) IBOutlet UIImageView *wjxImgView3;
@property (weak, nonatomic) IBOutlet UIImageView *wjxImgView4;
@property (weak, nonatomic) IBOutlet UIImageView *wjxImgView5;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl11;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl11;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl12;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl12;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl21;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl21;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl22;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl22;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl31;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl31;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl32;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl32;

@property (weak, nonatomic) IBOutlet UIView *titleTagView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *titleLLbl1;
@property (weak, nonatomic) IBOutlet UILabel *titleLLbl2;
@property (weak, nonatomic) IBOutlet UILabel *titleLLbl3;
@property (weak, nonatomic) IBOutlet UILabel *titleLLbl4;


@end

NS_ASSUME_NONNULL_END

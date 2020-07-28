//
//  PTTaskCell.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskCell.h"

@implementation PTTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIMGV.layer.cornerRadius = 30;
    self.iconIMGV.layer.masksToBounds = YES;
    self.progressView.layer.cornerRadius = 3.75;
    self.progressView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setTaskModel:(PTTaskModel *)taskModel{
    _taskModel = taskModel;
    self.taskTitle.text = taskModel.name;
    self.taskDay.text = [NSString stringWithFormat:@"%ld天",(long)taskModel.output_time];
    self.activityStatus.text = [NSString stringWithFormat:@"%@",taskModel.activation];
    self.taskTime.text = [NSString stringWithFormat:@"%@",taskModel.start_time];
    self.progressView.progress = taskModel.daily;
    self.taskProduct.text = [NSString stringWithFormat:@"已产出%.f%%",taskModel.daily*100];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.taskProduct.text];
    [attr setAttributes:@{NSForegroundColorAttributeName:MainBlueColor} range:NSMakeRange(3, self.taskProduct.text.length-3)];
    [self.iconIMGV sd_setImageWithURL:[NSURL URLWithString:[taskModel.img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PlaceHolder_Logo]];
}

@end

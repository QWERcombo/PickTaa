//
//  PickTaAdvDiscoverModel.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaAdvDiscoverModel.h"

@implementation AdvDiscoverUser

@end

@implementation PickTaAdvDiscoverModel

- (CGFloat )cellHeight{
    // 54 + 20 +18 + 10 + (screenWidth - 63.5 -16 - 11.5*2 )/1.74  + 文本高度
    CGFloat defaultHeight = 54 + 20 +18 + 10 + (SCREEN_WIDTH - 63.5 -16 - 11.5*2 )/1.74 + 30;
    CGFloat contentHeight = [self.content heightForFont:[UIFont systemFontOfSize:11] width:(SCREEN_WIDTH- (11.5+63.5+11.5+16))];
    CGFloat titleHeight = [self.title heightForFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] width:(SCREEN_WIDTH- (11.5+63.5+11.5+16))];
    return (defaultHeight + contentHeight +titleHeight);
}

@end

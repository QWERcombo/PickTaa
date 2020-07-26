//
//  PTTaskTGBLListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskTGBLListModel.h"

@implementation PTTaskTGBLListModel

- (void)setData:(NSArray<PTTaskTGBLItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTTaskTGBLItemModel class] json:data];
}

@end

//
//  PTHYDListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTHYDListModel.h"

@implementation PTHYDListModel

- (void)setData:(NSArray<PTHYDItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTHYDItemModel class] json:data];
}

- (void)setLevel_list:(NSArray<PTHYDLevelItemModel *> *)data {
    _level_list = [NSArray modelArrayWithClass:[PTHYDLevelItemModel class] json:data];
}

@end

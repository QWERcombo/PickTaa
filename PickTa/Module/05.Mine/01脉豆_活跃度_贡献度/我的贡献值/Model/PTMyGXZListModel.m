//
//  PTMyGXZListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyGXZListModel.h"

@implementation PTMyGXZListModel

- (void)setData:(NSArray<PTMyGXZItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTMyGXZItemModel class] json:data];
}

@end

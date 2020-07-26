//
//  PTMyBeanListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyBeanListModel.h"

@implementation PTMyBeanListModel

- (void)setData:(NSArray<PTMyBeanItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTMyBeanItemModel class] json:data];
}

@end

//
//  PTTaskJZJSListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskJZJSListModel.h"

@implementation PTTaskJZJSListModel

- (void)setData:(NSArray<PTTaskJZJSItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTTaskJZJSItemModel class] json:data];
}

@end

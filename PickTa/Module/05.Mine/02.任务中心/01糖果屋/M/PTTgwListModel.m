//
//  PTTgwListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTgwListModel.h"

@implementation PTTgwListModel

- (void)setData:(NSArray<PTTgwItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTTgwItemModel class] json:data];
}

@end

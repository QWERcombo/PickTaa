//
//  PTHelpCenterListModel.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTHelpCenterListModel.h"

@implementation PTHelpCenterListModel

- (void)setData:(NSArray<PTHelpCenterItemModel *> *)data {
    _data = [NSArray modelArrayWithClass:[PTHelpCenterItemModel class] json:data];
}

@end


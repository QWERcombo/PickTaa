//
//  PickTaBaseModel.m
//  PickTa
//
//  Created by Stark on 2020/6/15.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

@implementation PickTaBaseModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"pickID"  : @"id",
        };
}
@end

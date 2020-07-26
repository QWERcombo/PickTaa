//
//  NSObject+other.h
//  PickTa
//
//  Created by Stark on 2020/6/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (other)
///时间戳转换成日期
+(NSString*)convertForLongTime:(NSInteger)longTime;
@end

NS_ASSUME_NONNULL_END

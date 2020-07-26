//
//  NSObject+other.m
//  PickTa
//
//  Created by Stark on 2020/6/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "NSObject+other.h"

@implementation NSObject (other)
+ (NSString *)convertForLongTime:(NSInteger)longTime{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
//    [formatter setTimeZone:timeZone];

    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"MM-dd"];
    NSString *todayStr = [formatter stringFromDate:date];
    
    
    long long time= longTime;
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSString*timeString=[formatter stringFromDate:d];
    
    if([todayStr isEqualToString:timeString]){
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:d];
    }
    
    return timeString;
}
@end

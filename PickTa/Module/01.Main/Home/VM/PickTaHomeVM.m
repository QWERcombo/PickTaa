//
//  PickTaHomeVM.m
//  PickTa
//
//  Created by Stark on 2020/6/17.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaHomeVM.h"


@implementation PickTaHomeVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUserHomeCommend];
    }
    return self;
}

-(void)initUserHomeCommend{
    NSDictionary *dict = @{@"number":@"50"};
    [dict mj_JSONData];
    self.userHomeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_UserHome withParam:dict withPregress:^(id  _Nonnull obj) {
                       } withSuccess:^(id  _Nonnull obj) {
                           NSArray *array = [NSArray modelArrayWithClass:[DHomeModel class] json:obj[@"data"]];
                           [subscriber sendNext:array];
                           [subscriber sendCompleted];
                       } withFailure:^(NSError * _Nonnull err) {
                           [subscriber sendError:err];
                           [subscriber sendCompleted];
                       }];
            return nil;
        }];
    }];
}



@end

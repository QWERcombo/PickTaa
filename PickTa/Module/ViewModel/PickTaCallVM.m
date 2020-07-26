//
//  PickTaCallVM.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCallVM.h"


@implementation PickTaCallVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAdvDisCommand];
    }
    return self;
}

-(void)initAdvDisCommand{
    self.advDisCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_AdvDiscover withParam:@{} withSuccess:^(id  _Nonnull obj) {
                NSArray <PickTaAdvDiscoverModel*>*list = [NSArray modelArrayWithClass:[PickTaAdvDiscoverModel class] json:obj[@"data"]];
                list[0].banner = obj[@"banner"];
                [subscriber sendNext:list];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendNext:err];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}


@end

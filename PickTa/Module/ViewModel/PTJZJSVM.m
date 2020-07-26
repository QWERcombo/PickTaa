//
//  PTJZJSVM.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTJZJSVM.h"

@implementation PTJZJSVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initZJZSCommand];
    }
    return self;
}

-(void)initZJZSCommand{
    self.jzjsCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_TaskJZJS withParam:input withSuccess:^(id  _Nonnull obj) {
                NSArray *array = [NSArray modelArrayWithClass:[PickTaJZJSModel class] json:obj[@"data"]];
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                
            }];
            return nil;
        }];
    }];
}
@end

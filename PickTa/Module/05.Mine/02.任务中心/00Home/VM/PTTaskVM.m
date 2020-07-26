//
//  PTTaskVM.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskVM.h"

@implementation PTTaskVM

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initTaskCommand];
    }
    return self;
}

- (void)initTaskCommand {
    self.taskCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_TaskCenter withParam:input withSuccess:^(id  _Nonnull obj) {
                NSArray *array= [NSArray modelArrayWithClass:[PTTaskModel class] json:obj[@"data"]];
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                
            }];
            
            return nil;
        }];
    }];
}
@end

//
//  PTUserListVM.m
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTUserListVM.h"

@implementation PTUserListVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUserListCommand];
    }
    return self;
}

-(void)initUserListCommand{
    self.userListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestGET:API_userList withParam:@{} withSuccess:^(id  _Nonnull obj) {
                NSArray <PickTaUserListModel*>*userList = [NSArray modelArrayWithClass:[PickTaUserListModel class] json:obj[@"data"]];
                [subscriber sendNext:userList];
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

//
//  PickTaCircleFriendVM.m
//  PickTa
//
//  Created by Stark on 2020/6/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCircleFriendVM.h"

@implementation PickTaCircleFriendVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initFriendCommand];
    }
    return self;
}

-(void)initFriendCommand{
    self.friendCircleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestGET:API_CircleFriend withParam:input withSuccess:^(id  _Nonnull obj) {
                PickTaFriendCircleModel *model = [PickTaFriendCircleModel modelWithJSON:obj];
                [subscriber sendNext:model];
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

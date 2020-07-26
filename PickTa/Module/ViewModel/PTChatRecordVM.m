//
//  PTChatRecord.m
//  PickTa
//
//  Created by Stark on 2020/6/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatRecordVM.h"

@implementation PTChatRecordVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initChatRecordCommand];
    }
    return self;
}

-(void)initChatRecordCommand{
    self.chatRecordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_RecordIndex withParam:@{} withSuccess:^(id  _Nonnull obj) {
                [subscriber sendNext:[NSArray modelArrayWithClass:[PTChatRecordModel class] json:obj]];
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

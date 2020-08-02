//
//  PTChatRecordContentVM.m
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatRecordContentVM.h"

@implementation PTChatRecordContentVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initRecordContentCommand];
        [self initRecordSendCommand];
    }
    return self;
}
-(void)initRecordContentCommand{
    self.recordContentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_ChatRecord withParam:self.fetchContentParam withSuccess:^(id  _Nonnull obj) {
                NSArray *recordContent = [NSArray modelArrayWithClass:[PTChatRecordContentModel class] json:obj];
                recordContent = [[recordContent reverseObjectEnumerator] allObjects];
                recordContent = [recordContent filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"content.length > 0"]];
                [subscriber sendNext:recordContent];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendError:err];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

-(void)initRecordSendCommand{
    self.recordSendCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"%@",input);
            [[PickHttpManager shared]requestPOST:API_ChatSend withParam:input withSuccess:^(id  _Nonnull obj) {
                [subscriber sendNext:obj];
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

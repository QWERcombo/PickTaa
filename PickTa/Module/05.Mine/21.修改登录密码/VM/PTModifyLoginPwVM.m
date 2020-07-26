//
//  PTModifyLoginPwVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTModifyLoginPwVM.h"

@implementation PTModifyLoginPwVM

- (instancetype)init {
    self = [super init];
   
    if (self) {
        [self initCommand];
    }
   
    return self;
}

- (void)initCommand {
    self.command1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_FindPw withParam:self.param1 withSuccess:^(id  _Nonnull obj) {
                [subscriber sendNext:obj];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendError:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    self.command2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
             [[PickHttpManager shared] requestPOST:API_UserEditPayPw withParam:self.param2 withSuccess:^(id  _Nonnull obj) {
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

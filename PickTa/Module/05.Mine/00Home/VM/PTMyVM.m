//
//  PTMyVM.m
//  PickTa
//
//  Created by Stark on 2020/6/22.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMyVM.h"

@interface PTMyVM() {}
@end
@implementation PTMyVM

- (instancetype)init {
    self = [super init];
   
    if (self) {
        [self initMyCommand];
    }
   
    return self;
}

- (void)initMyCommand {
    self.myCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_UserInfo withParam:@{} withSuccess:^(id  _Nonnull obj) {
                PTMyModel *myModel = [PTMyModel modelWithJSON:obj[@"user"]];
                [subscriber sendNext:myModel];
                [subscriber sendCompleted];
                [PickTaUserDefaults g_setValue:[myModel modelToJSONString]forKey:@"user_info"];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendError:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    // 设置简介
    self.briefCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_BriefSet withParam:self.briefParam withSuccess:^(id  _Nonnull obj) {
                [subscriber sendNext:obj];
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

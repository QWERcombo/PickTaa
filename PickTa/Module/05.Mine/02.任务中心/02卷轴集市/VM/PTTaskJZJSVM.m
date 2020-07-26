//
//  PTTaskJZJSVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskJZJSVM.h"

@implementation PTTaskJZJSVM

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self initCommand];
    }
    
    return self;
}

- (void)initCommand {
    // 卷轴集市
    self.command1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_UserScrollMarket withParam:self->_param1 withSuccess:^(id  _Nonnull obj) {
                PTTaskJZJSListModel *model = [PTTaskJZJSListModel modelWithJSON:obj];
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendNext:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    // 卷轴集市 兑换
    self.command2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_UserChangeMarketExchange withParam:self->_param2 withSuccess:^(id  _Nonnull obj) {
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

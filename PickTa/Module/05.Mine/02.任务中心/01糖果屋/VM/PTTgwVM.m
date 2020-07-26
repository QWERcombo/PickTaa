//
//  PTTgwVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTgwVM.h"

@implementation PTTgwVM

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self initCommand];
    }
    
    return self;
}

- (void)initCommand {
    // 糖果屋
    self.command1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_AdvertCandyHouse withParam:self->_param1 withSuccess:^(id  _Nonnull obj) {
                PTTgwListModel *model = [PTTgwListModel modelWithJSON:obj];
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendNext:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    // 兑换
    self.command2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_AdvertCandyConvertNew withParam:self->_param2 withSuccess:^(id  _Nonnull obj) {
                // NSArray *array= [NSArray modelArrayWithClass:[PTTaskModel class] json:obj[@"data"]];
                [subscriber sendNext:obj];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendNext:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    // 糖果屋-领取
    self.command3 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_AdvertCandyReceive withParam:self->_param3 withSuccess:^(id  _Nonnull obj) {
                PTTgwItemModel *model = [PTTgwItemModel modelWithJSON:obj];
                [subscriber sendNext:model];
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

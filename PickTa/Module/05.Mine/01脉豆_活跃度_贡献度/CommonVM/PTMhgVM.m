//
//  PTMhgVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTMhgVM.h"

@implementation PTMhgVM

- (instancetype)init {
    self = [super init];
   
    if (self) {
        [self initCommand];
    }
   
    return self;
}

- (void)initCommand {
    self.myBean = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared] requestPOST:API_UserMyBean withParam:self.param1 withSuccess:^(id  _Nonnull obj) {
                PTMyBeanListModel *model = [PTMyBeanListModel modelWithJSON:obj];
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                [subscriber sendError:err];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    self.myGX = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
             [[PickHttpManager shared] requestPOST:API_UserMyExpe withParam:self.param2 withSuccess:^(id  _Nonnull obj) {
                 PTMyGXZListModel *model = [PTMyGXZListModel modelWithJSON:obj];
                 [subscriber sendNext:model];
                 [subscriber sendCompleted];
             } withFailure:^(NSError * _Nonnull err) {
                 [subscriber sendError:err];
                 [subscriber sendCompleted];
             }];
             
             return nil;
         }];
     }];
    
    self.myHYD = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
             [[PickHttpManager shared] requestPOST:API_UserMyActive withParam:self.param1 withSuccess:^(id  _Nonnull obj) {
                 PTHYDListModel *model = [PTHYDListModel modelWithJSON:obj];
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

//
//  PTHelpCenterVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTHelpCenterVM.h"

@implementation PTHelpCenterVM

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
            [[PickHttpManager shared] requestPOST:API_ApiHelpCenter withParam:self.param1 withSuccess:^(id  _Nonnull obj) {
                PTHelpCenterListModel *model = [PTHelpCenterListModel modelWithJSON:obj];
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

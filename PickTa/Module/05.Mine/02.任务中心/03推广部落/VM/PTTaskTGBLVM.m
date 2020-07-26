//
//  PTTaskTGBLVM.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskTGBLVM.h"

@implementation PTTaskTGBLVM

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
            [[PickHttpManager shared] requestPOST:API_UserTeamTribes withParam:self->_param1 withSuccess:^(id  _Nonnull obj) {
                PTTaskTGBLListModel *model = [PTTaskTGBLListModel modelWithJSON:obj];
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

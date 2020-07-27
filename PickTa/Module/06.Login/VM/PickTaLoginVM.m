//
//  PickTaLoginVM.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaLoginVM.h"
#import "PTMyVM.h"

@implementation PickTaLoginVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initLoginCommand];
    }
    return self;
}

-(void)initLoginCommand {
    @weakify(self)
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self)
            [[PickHttpManager shared]requestPOST:API_Login withParam:self.loginParam withPregress:^(id  _Nonnull obj) {
//                [subscriber sendNext:@""];
            } withSuccess:^(id  _Nonnull obj) {
                [PickTaUserDefaults g_setToken:obj[@"token"]];
                [PickTaUserDefaults g_setPhoneNum:self.loginParam[@"phone"]];
                [PickTaUserDefaults g_setPSW:self.loginParam[@"password"]];
                [[PickHttpManager shared]setHttpHeaderValue:[PickTaUserDefaults g_getToken] forHTTPHeaderField:@"Authorization"];
                [self requestProfile];

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


- (void)requestProfile {
//    @weakify(self)
    PTMyVM *myVM = [PTMyVM new];
    [myVM.myCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccess object:nil];

        
//        self.myModel = x;
//
//        RAC(self.nickName,text) = RACObserve(self.myModel,nickname);
//        RAC(self.phone,text) = RACObserve(self.myModel, phone);
//        self.ptID.text = [NSString stringWithFormat:@"ID:%ld",self.myModel.my_id];
//        self.level.text = [NSString stringWithFormat:@"LV%ld",(long)self.myModel.user_level];
//        if(String_IsEmpty(self.myModel.avatar)){
//            [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.head_portrait]];
//        }else{
//            [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.avatar]];
//        }
//        self.beenValue.text = self.myModel.cdn_balance;
    }];
    
    [myVM.myCommand execute:nil];
}

@end

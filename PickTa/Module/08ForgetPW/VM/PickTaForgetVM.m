//
//  PickTaLoginVM.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaForgetVM.h"

@implementation PickTaForgetVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initLoginCommand];
    }
    return self;
}

-(void)initLoginCommand{
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_Sendsms withParam:self.loginParam withPregress:^(id  _Nonnull obj) {
                [subscriber sendNext:@""];
            } withSuccess:^(id  _Nonnull obj) {
           
                [subscriber sendNext:obj];
                [subscriber sendCompleted];
            } withFailure:^(NSError * _Nonnull err) {
                NSLog(@"%@",err);
                [subscriber sendNext:err];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    self.forgetCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               [[PickHttpManager shared]requestPOST:API_Passwor withParam:self.forgetParam withPregress:^(id  _Nonnull obj) {
                   [subscriber sendNext:@""];
               } withSuccess:^(id  _Nonnull obj) {
               [[NSNotificationCenter defaultCenter]postNotificationName:RegosterSuccess object:nil];
                   [subscriber sendNext:obj];
                   [subscriber sendCompleted];
               } withFailure:^(NSError * _Nonnull err) {
                   NSLog(@"%@",err);
                   [subscriber sendNext:err];
                   [subscriber sendCompleted];
               }];
               return nil;
           }];
       }];
}
@end

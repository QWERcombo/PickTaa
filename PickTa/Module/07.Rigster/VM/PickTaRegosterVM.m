//
//  PickTaRegosterVM.m
//  PickTa
//
//  Created by sgq on 2020/6/20.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaRegosterVM.h"
#import "PTTagModel.h"

@implementation PickTaRegosterVM
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
    self.completeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               [[PickHttpManager shared]requestPOST:API_Register withParam:self.completeParam withPregress:^(id  _Nonnull obj) {
//                   [subscriber sendNext:@""];
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
    self.tagCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[PickHttpManager shared]requestPOST:API_TagList withParam:self.tagParam withPregress:^(id  _Nonnull obj) {
                [subscriber sendNext:@""];
            } withSuccess:^(id  _Nonnull obj) {
                NSArray *array= [NSArray modelArrayWithClass:[PTTagModel class] json:obj[@"tag"]];
                [subscriber sendNext:array];
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

//
//  fsfsfsf.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/7.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "fsfsfsf.h"

@implementation fsfsfsf

/*
 // 国际化
 kLocalizedString(@"", @"")
 
 //注册通知，用于接收改变语言的通知
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
 
 //    _rightBtn.title = kLocalizedString(@"",@"");

 
 - (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
 }
 
 - (void)setupUI {}
 - (void)createVM {}
 - (void)bindViewModel {}
 - (void)requestData {}
 
 @weakify(self)
 [[self.jzjsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     @strongify(self)
     [self.navigationController pushViewController:[PTTaskJZJSVC new] animated:YES];
 }];
 
 [[XSWJVASPTHelper getCurrentVC].navigationController pushViewController:vc animated:YES];

 
 
 
 //
 @interface PTMyVM : PickTaBaseViewModel
 @property (nonatomic, strong) RACCommand *myCommand;
 @property (nonatomic, strong) NSDictionary *param; // 需要的参数
 @end
 //
 @interface PTMyVM() {}
 @end
 @implementation PTMyVM

 - (instancetype)init {
     self = [super init];
    
     if (self) {
         [self initCommand];
     }
    
     return self;
 }

 // withParam:self.param @{}
  NSArray *array= [NSArray modelArrayWithClass:[PTTaskModel class] json:obj[@"data"]];
   [subscriber sendNext:array];
   [subscriber sendCompleted];
 
 - (void)initCommand {
     self.myCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
             [[PickHttpManager shared] requestPOST:API_UserInfo withParam:self.param withSuccess:^(id  _Nonnull obj) {
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
 }
 @end

 //
 - (void)bindViewModel {
     @weakify(self)
     self.vm = [PTMyVM new];
 self.vm.param = @{@"to_id":self.to_id, @"type":self.type,@"page":@"1"};

     [self.vm.myCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
         @strongify(self)
         self.myModel = x;
         RAC(self.nickName, text) = RACObserve(self.myModel,nickname);
         RAC(self.phone,text) = RACObserve(self.myModel, phone);
         self.ptID.text = [NSString stringWithFormat:@"ID:%ld", self.myModel.my_id];
         self.level.text = [NSString stringWithFormat:@"LV%ld",(long)self.myModel.user_level];
         if(String_IsEmpty(self.myModel.avatar)){
             [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.head_portrait]];
         }else{
             [self.icon sd_setImageWithURL:[NSURL URLWithString:self.myModel.avatar]];
         }
         self.beenValue.text = self.myModel.cdn_balance;
     }];
 }
 
 -(void)requestData{
     [self.myVM.myCommand execute:nil];
 }
 
 
 [self.vm.fetchTeamListCommand.executionSignals subscribeNext:^(id x) {
     // 这里的x是一个RACSignal，即执行Command时返回的那个Signal，所以x也是可以订阅的。收到这个信号，说明网络请求开始。
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     // 这里收到信号是开始发送网络请求
     [x subscribeNext:^(id x) {
         // 这里收到信号是网络请求返回
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         // do something
     }];
     
 }];

 // .executionSignals.switchToLatest subscribeNext:
 - (void)requestData{
     [self.circleFriendVM.friendCircleCommand execute:@{@"type":@"1",@"page":@"1"}];
 }
 -(void)initFriendCommand{
     self.friendCircleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
             [[PickHttpManager shared]requestGET:API_CircleFriend withParam:input withSuccess:^(id  _Nonnull obj) {
                 PickTaFriendCircleModel *model = [PickTaFriendCircleModel modelWithJSON:obj];
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
 
 */

@end

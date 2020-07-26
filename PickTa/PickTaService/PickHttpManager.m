//
//  PickHttpManager.m
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickHttpManager.h"
#import <AFNetworking.h>


//目前仅有 get post 请求
typedef NS_ENUM(NSUInteger ,HttpRequestType)
{
    GET = 0,
    POST
};

@interface PickHttpManager()
/// 请求队列
@property (nonatomic, strong) NSMutableDictionary *taskQueue;
@end

@implementation PickHttpManager

static PickHttpManager *requestManager;
static AFHTTPSessionManager *manager;
+(PickHttpManager*)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[self alloc] init];
    });
    return requestManager;
}

- (instancetype)init
{
//    Authorization: bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC93d3cucGlja3RhLm5ldFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTU5MjQxMTA1NywiZXhwIjoxNTk4NDEwOTk3LCJuYmYiOjE1OTI0MTEwNTcsImp0aSI6IkRvVW1PdWpFOW9VRmpSNlYiLCJzdWIiOjI1MDMwMywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.FW2vcTA6OkPHjP0Tzf9sntdMDGeRrPGNQzA54ngOfVs
    self = [super init];
    if (self) {
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
        forHTTPHeaderField:@"Accept"];
        
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        [manager.requestSerializer setValue:[PickTaUserDefaults g_getToken] forHTTPHeaderField:@"Authorization"];
        manager.requestSerializer.timeoutInterval = 30.0f;
        [manager setValue:[NSURL URLWithString:API_BASE] forKey:@"baseURL"];
        if(ISProduction == NO){
            //无条件的信任服务器上的证书
            AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
            // 客户端是否信任非法证书
            securityPolicy.allowInvalidCertificates = YES;
            // 是否在证书域字段中验证域名
            securityPolicy.validatesDomainName = NO;
            manager.securityPolicy = securityPolicy;
        }else{
            //            manager.securityPolicy.allowInvalidCertificates = YES;
            //            [manager.securityPolicy setValidatesDomainName:NO];
        }
        [self startNetworkStates];
    }
    return self;
}

-(void)startNetworkStates{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
#ifdef DEBUG
#else
#endif
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
#ifdef DEBUG
                [SVProgressHUD showInfoWithStatus:@"蜂窝网络"];
//                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"蜂窝网络"];
                [SVProgressHUD dismissWithDelay:1];
#else
#endif
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showErrorWithStatus:@"请检查网络"];
                [SVProgressHUD dismissWithDelay:1];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [SVProgressHUD showInfoWithStatus:@"未知网络"];
//                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未知网络"];
                [SVProgressHUD dismissWithDelay:1];
                break;
            default:
                break;
        }
    }];
}



-(void)requestGET:(NSString *)url withParam:(NSDictionary * __nullable)param withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure{
    [self requestGET:url withParam:param withPregress:nil withSuccess:sucess withFailure:failure];
}

-(void)requestPOST:(NSString *)url withParam:(NSDictionary * __nullable)param withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure{
    [self requestPOST:url withParam:param withPregress:nil withSuccess:sucess withFailure:failure];
}

-(void)requestGET:(NSString *)url withParam:(NSDictionary * __nullable)param withPregress:(PROGRESS __nullable)progress withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure{
    WeakSelf(self)
    NSURLSessionDataTask *task = [manager GET:url parameters:param headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        !progress ?: progress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        StrongSelf(weakself)
        [strongweakself removeTaskWithUrl:url];
        [strongweakself responseObjectManage:responseObject andCallBack:sucess withFailure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        StrongSelf(weakself)
        [strongweakself removeTaskWithUrl:url];
        !failure ?: failure(error);
    }];
    [self addTask:task withUrl:url];
}

-(void)requestPOST:(NSString *)url withParam:(id)param withPregress:(PROGRESS __nullable)progress withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure
{
    WeakSelf(self)
    NSURLSessionDataTask *task = [manager POST:url parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        !progress ?: progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        StrongSelf(weakself)
        [strongweakself removeTaskWithUrl:url];
        [strongweakself responseObjectManage:responseObject andCallBack:sucess withFailure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        StrongSelf(weakself)
        [strongweakself removeTaskWithUrl:url];
        !failure ?: failure(error);
    }];
    [self addTask:task withUrl:url];
    
}

-(void)requestDownload:(NSString *)url withPath:(NSString *)path withPregress:(PROGRESS)progress withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure{
//    NSURL *downUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",EssAPI_Source,url]];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:downUrl];
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
//        !progress ?: progress(downloadProgress);
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        [[EssFileManager shared]createFilePath:path];
//        ///下载目录
//        NSString *fullPath = [NSString stringWithFormat:@"%@/%@",path,response.suggestedFilename];
//        NSLog(@"fullPath:%@",fullPath);
//        //        NSLog(@"%@",[NSThread currentThread]);
//        return [NSURL fileURLWithPath:fullPath];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if(error){
//            !failure ?: failure(error);
//        }
//        !sucess ?: sucess(filePath);
//    }];
//    [downloadTask resume];
}

-(void)uploadPhone:(NSString *)url withParam:(NSArray *)parameter withPregress:(PROGRESS)progress withSuccess:(SUCESS)sucess withFailure:(FAILURE)failure{
    WeakSelf(self)
    url = [NSString stringWithFormat:@"%@%@",API_BASE,url];

//    NSDictionary *dict = @{@"sign":@"userHeader.png"};

    [manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFormData:parameter name:@"sign"];
        for (UIImage *image in parameter) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        StrongSelf(weakself)
        [strongweakself responseObjectManage:responseObject andCallBack:sucess withFailure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
}



- (void)removeTaskWithUrl:(NSString*)url
{
//    if([url containsString:EssAPI_SaveChoose]){
//        return;
//    }
//    if (self.taskQueue.count) {
//        NSURLSessionTask *task = [self.taskQueue objectForKey:url];
//        [task cancel];
//        [self.taskQueue removeObjectForKey:url];
//    }
}

- (void)addTask:(NSURLSessionDataTask *)task withUrl:(NSString*)url
{
//    if([url containsString:EssAPI_SaveChoose]){
//        return;
//    }
//    if([url containsString:EssAPI_ItemHistory]){
//        return;
//    }
    if([[self.taskQueue allKeys]containsObject:url]){
        [self removeTaskWithUrl:url];
    }
    
    if(task)
        [self.taskQueue setObject:task forKey:url];
    
}

-(void)cancleRequestWithUrl:(NSString *)url{
    [self removeTaskWithUrl:url];
}

- (NSMutableDictionary *)taskQueue
{
    if (!_taskQueue) {
        _taskQueue = NSMutableDictionary.dictionary;
    }
    return _taskQueue;
}


//处理responseObject 获取状态retCode
-(void)responseObjectManage:(id)responseObject andCallBack:(SUCESS)sucess withFailure:(FAILURE)failure{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
    NSString *retCode = dict[@"type"];
    if(![retCode isEqualToString:@"ok"] ){
        NSError *error = [[NSError alloc]initWithDomain:dict[@"message"] code:0 userInfo:nil];
        [SVProgressHUD showErrorWithStatus:dict[@"message"]];
        !failure ?: failure(error);
    }else{
        !sucess ?: sucess(dict[@"message"]);
    }
}


- (void)setHttpHeaderValue:(NSString *)str forHTTPHeaderField:(NSString *)key{
    [manager.requestSerializer setValue:str forHTTPHeaderField:key];
}


@end

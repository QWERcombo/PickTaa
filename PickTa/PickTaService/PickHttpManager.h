//
//  PickHttpManager.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickTaWebSocketManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SUCESS)(id obj);
typedef void(^FAILURE)(NSError *err);
typedef void(^PROGRESS)(id obj);


@interface PickHttpManager : NSObject


+(PickHttpManager*)shared;

/**
Get请求无进度条
url                 网络地址
param           参数
success         成功回调
failure            失败回调
*/
-(void)requestGET:(NSString*)url
        withParam:(NSDictionary* __nullable)param
      withSuccess:(SUCESS)sucess
      withFailure:(FAILURE)failure;

/**
 Get请求有进度条
 url                 网络地址
 param           参数
 progress          加载回调
 success         成功回调
 failure            失败回调
 */
-(void)requestGET:(NSString*)url
        withParam:(NSDictionary* __nullable)param
     withPregress:(PROGRESS __nullable)progress
      withSuccess:(SUCESS)sucess
      withFailure:(FAILURE)failure;

/**
 Post请求无进度条
 url                 网络地址
 param           参数
 success         成功回调
 failure            失败回调
 */
-(void)requestPOST:(NSString*)url
         withParam:(NSDictionary* __nullable)param
       withSuccess:(SUCESS)sucess
       withFailure:(FAILURE)failure;

/**
 Post请求有进度条
 url                 网络地址
 param           参数
 progress          加载回调
 success         成功回调
 failure            失败回调
 */
-(void)requestPOST:(NSString*)url
         withParam:(id)param
      withPregress:(PROGRESS __nullable)progress
       withSuccess:(SUCESS)sucess
       withFailure:(FAILURE)failure;


/**
 下载请求有进度条
 url                 网络地址
 param           参数
 progress          加载回调
 success         成功回调
 failure            失败回调
 */
-(void)requestDownload:(NSString*)url
             withPath:(NSString*)path
          withPregress:(PROGRESS)progress
           withSuccess:(SUCESS)sucess
           withFailure:(FAILURE)failure;

/**
 图片上传
 */
-(void)uploadPhone:(NSString*)url
         withParam:(NSArray *)parameter
      withPregress:(PROGRESS)progress
       withSuccess:(SUCESS)sucess
       withFailure:(FAILURE)failure;

-(void)setHttpHeaderValue:(NSString*)str forHTTPHeaderField:(NSString*)key;

@end

NS_ASSUME_NONNULL_END

//
//  PickTaWebSocketManager.h
//  PickTa
//
//  Created by Stark on 2020/6/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    disConnectByUser ,
    disConnectByServer,
} DisConnectType;


@interface PickTaWebSocketManager : NSObject



+ (instancetype)share;

- (void)connect;
- (void)disConnect;

- (void)sendMsg:(NSString *)msg;

- (void)ping;

@end

NS_ASSUME_NONNULL_END

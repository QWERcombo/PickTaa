//
//  G_MJRefreshProtocol.h
//  PickTa
//
//  Created by Stark on 2020/6/16.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol G_MJRefreshProtocol <NSObject>
@optional
//下拉刷新操作 实现在此方法中
-(void)pullHeaderRefresh;
//上拉更多 实现在x此方法中
-(void)pushFooterRefresh;
@end

NS_ASSUME_NONNULL_END

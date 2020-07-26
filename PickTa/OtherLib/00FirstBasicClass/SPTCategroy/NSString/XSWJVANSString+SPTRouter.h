//
//  NSString+XSWJVASPTRouter.h
//  BFZLShopMall-Test
//
//  Created by SOPOCO_ljt on 2019/5/13.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JUMPE_ROUTER @"JUMPE_ROUTER"



@interface NSString (XSWJVASPTRouter)

- (NSDictionary *)spt_fetchParameterAndRouter;

@end



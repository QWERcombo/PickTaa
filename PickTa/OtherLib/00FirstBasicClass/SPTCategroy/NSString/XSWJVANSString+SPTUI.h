//
//  NSString+SPTUI.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (SPTUI)

- (NSString *)spt_stringMatchedByPattern:(NSString *)pattern;
+ (NSString *)spt_hexStringWithInteger:(NSInteger)integer;


@end



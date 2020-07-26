//
//  SDTimeLineCellOperationMenu.h
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/4/2.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#define DAY @"day"

#define NIGHT @"night"


@interface SDTimeLineCellOperationMenu : UIView

@property (nonatomic, assign, getter = isShowing) BOOL show;

@property (nonatomic, copy) void (^likeButtonClickedOperation)();
@property (nonatomic, copy) void (^commentButtonClickedOperation)();


@end

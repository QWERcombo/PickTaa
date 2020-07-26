//
//  SPTRadianLayerView.h
//  ZYGShopMall
//
//  Created by Sanpintian on 2019/12/26.
//  Copyright © 2019 CodeBuild Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SPTRadianDirection) {
    SPTRadianDirectionBottom     = 0,
    SPTRadianDirectionTop        = 1,
    SPTRadianDirectionLeft       = 2,
    SPTRadianDirectionRight      = 3,
};



@interface SPTRadianLayerView : UIView

@property (nonatomic) SPTRadianDirection direction;// 圆弧方向, 默认在下方
@property (nonatomic) CGFloat radian;// 圆弧高/宽, 可为负值。 正值凸, 负值凹

@end



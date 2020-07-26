//
//  SPTVerticalLabel.h
//  ZYGShopMall
//
//  Created by Sanpintian on 2019/12/22.
//  Copyright © 2019 CodeBuild Tech. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface SPTVerticalLabel : UILabel {
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end



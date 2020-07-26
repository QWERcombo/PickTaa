//
//  PickTaFriendCircleModel.m
//  PickTa
//
//  Created by Stark on 2020/6/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaFriendCircleModel.h"

@implementation ThumbnailItem
@end


@implementation Comment_listItem
@end

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation DataItem
{
    CGFloat _lastContentWidth;
    
}

- (BOOL)shouldShowMoreButton{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [self.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    return _shouldShowMoreButton;
}

- (BOOL)isOpening{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = _isOpening;
    }
    return _isOpening;
}


@end


@implementation PickTaFriendCircleModel

- (void)setData:(NSArray<DataItem *> *)data{
    _data = [NSArray modelArrayWithClass:[DataItem class] json:data];
}

@end

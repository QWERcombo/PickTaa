//
//  XSWJVASPTValue.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVASPTValue.h"

@implementation XSWJVASPTValue

#pragma mark - 无障碍访问

void
AddAccessibilityLabel(NSObject *obj, NSString *label) {
    obj.accessibilityLabel = label;
}

void
AddAccessibilityHint(NSObject *obj, NSString *hint) {
    obj.accessibilityHint = hint;
}

#pragma mark - CGFloat

/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 */
CGFloat
removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = removeFloatMin(floatValue);
    scale = scale ?: ScreenScale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}

/**
 *  类似flat()，只不过 flat 是向上取整，而 floorInPixel 是向下取整
 */
CGFloat
floorInPixel(CGFloat floatValue) {
    floatValue = removeFloatMin(floatValue);
    CGFloat resultValue = floor(floatValue * ScreenScale) / ScreenScale;
    return resultValue;
}

BOOL
between(CGFloat minimumValue, CGFloat value, CGFloat maximumValue) {
    return minimumValue < value && value < maximumValue;
}

BOOL
betweenOrEqual(CGFloat minimumValue, CGFloat value, CGFloat maximumValue) {
    return minimumValue <= value && value <= maximumValue;
}

/**
 *  调整给定的某个 CGFloat 值的小数点精度，超过精度的部分按四舍五入处理。
 *
 *  例如 CGFloatToFixed(0.3333, 2) 会返回 0.33，而 CGFloatToFixed(0.6666, 2) 会返回 0.67
 *
 *  @warning 参数类型为 CGFloat，也即意味着不管传进来的是 float 还是 double 最终都会被强制转换成 CGFloat 再做计算
 *  @warning 该方法无法解决浮点数精度运算的问题
 */
CGFloat
CGFloatToFixed(CGFloat value, NSUInteger precision) {
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f", @(precision)];
    NSString *toString = [NSString stringWithFormat:formatString, value];
#if CGFLOAT_IS_DOUBLE
    CGFloat result = [toString doubleValue];
#else
    CGFloat result = [toString floatValue];
#endif
    return result;
}

/// 用于居中运算
CGFloat
CGFloatGetCenter(CGFloat parent, CGFloat child) {
    return flat((parent - child) / 2.0);
}

/// 检测某个数值如果为 NaN 则将其转换为 0，避免布局中出现 crash
CGFloat
CGFloatSafeValue(CGFloat value) {
    return isnan(value) ? 0 : value;
}

#pragma mark - CGPoint

/// 两个point相加
CGPoint
CGPointUnion(CGPoint point1, CGPoint point2) {
    return CGPointMake(flat(point1.x + point2.x), flat(point1.y + point2.y));
}

/// 获取rect的center，包括rect本身的x/y偏移
CGPoint
CGPointGetCenterWithRect(CGRect rect) {
    return CGPointMake(flat(CGRectGetMidX(rect)), flat(CGRectGetMidY(rect)));
}

CGPoint
CGPointGetCenterWithSize(CGSize size) {
    return CGPointMake(flat(size.width / 2.0), flat(size.height / 2.0));
}

CGPoint
CGPointToFixed(CGPoint point, NSUInteger precision) {
    CGPoint result = CGPointMake(CGFloatToFixed(point.x, precision), CGFloatToFixed(point.y, precision));
    return result;
}

CGPoint
CGPointRemoveFloatMin(CGPoint point) {
    CGPoint result = CGPointMake(removeFloatMin(point.x), removeFloatMin(point.y));
    return result;
}

#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

/// 将两个UIEdgeInsets合并为一个
UIEdgeInsets
UIEdgeInsetsConcat(UIEdgeInsets insets1, UIEdgeInsets insets2) {
    insets1.top += insets2.top;
    insets1.left += insets2.left;
    insets1.bottom += insets2.bottom;
    insets1.right += insets2.right;
    return insets1;
}

UIEdgeInsets
UIEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top) {
    insets.top = flat(top);
    return insets;
}

UIEdgeInsets
UIEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left) {
    insets.left = flat(left);
    return insets;
}
UIEdgeInsets
UIEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom) {
    insets.bottom = flat(bottom);
    return insets;
}

UIEdgeInsets
UIEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right) {
    insets.right = flat(right);
    return insets;
}

UIEdgeInsets
UIEdgeInsetsToFixed(UIEdgeInsets insets, NSUInteger precision) {
    UIEdgeInsets result = UIEdgeInsetsMake(CGFloatToFixed(insets.top, precision), CGFloatToFixed(insets.left, precision), CGFloatToFixed(insets.bottom, precision), CGFloatToFixed(insets.right, precision));
    return result;
}

UIEdgeInsets
UIEdgeInsetsRemoveFloatMin(UIEdgeInsets insets) {
    UIEdgeInsets result = UIEdgeInsetsMake(removeFloatMin(insets.top), removeFloatMin(insets.left), removeFloatMin(insets.bottom), removeFloatMin(insets.right));
    return result;
}

#pragma mark - CGSize

/// 判断一个 CGSize 是否存在 NaN
BOOL
CGSizeIsNaN(CGSize size) {
    return isnan(size.width) || isnan(size.height);
}

/// 判断一个 CGSize 是否存在 infinite
BOOL
CGSizeIsInf(CGSize size) {
    return isinf(size.width) || isinf(size.height);
}

/// 判断一个 CGSize 是否为空（宽或高为0）
BOOL
CGSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

/// 判断一个 CGSize 是否合法（例如不带无穷大的值、不带非法数字）
BOOL
CGSizeIsValidated(CGSize size) {
    return !CGSizeIsEmpty(size) && !CGSizeIsInf(size) && !CGSizeIsNaN(size);
}

/// 将一个 CGSize 像素对齐
CGSize
CGSizeFlatted(CGSize size) {
    return CGSizeMake(flat(size.width), flat(size.height));
}

/// 将一个 CGSize 以 pt 为单位向上取整
CGSize
CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/// 将一个 CGSize 以 pt 为单位向下取整
CGSize
CGSizeFloor(CGSize size) {
    return CGSizeMake(floor(size.width), floor(size.height));
}

CGSize
CGSizeToFixed(CGSize size, NSUInteger precision) {
    CGSize result = CGSizeMake(CGFloatToFixed(size.width, precision), CGFloatToFixed(size.height, precision));
    return result;
}

CGSize
CGSizeRemoveFloatMin(CGSize size) {
    CGSize result = CGSizeMake(removeFloatMin(size.width), removeFloatMin(size.height));
    return result;
}

#pragma mark - CGRect

/// 判断一个 CGRect 是否存在 NaN
BOOL
CGRectIsNaN(CGRect rect) {
    return isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height);
}

/// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
BOOL
CGRectIsInf(CGRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y) || isinf(rect.size.width) || isinf(rect.size.height);
}

/// 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）
BOOL
CGRectIsValidated(CGRect rect) {
    return !CGRectIsNull(rect) && !CGRectIsInfinite(rect) && !CGRectIsNaN(rect) && !CGRectIsInf(rect);
}

/// 检测某个 CGRect 如果存在数值为 NaN 的则将其转换为 0，避免布局中出现 crash
CGRect
CGRectSafeValue(CGRect rect) {
    return CGRectMake(CGFloatSafeValue(CGRectGetMinX(rect)), CGFloatSafeValue(CGRectGetMinY(rect)), CGFloatSafeValue(CGRectGetWidth(rect)), CGFloatSafeValue(CGRectGetHeight(rect)));
}

/// 创建一个像素对齐的CGRect
CGRect
CGRectFlatMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(flat(x), flat(y), flat(width), flat(height));
}

/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CGRect
CGRectFlatted(CGRect rect) {
    return CGRectMake(flat(rect.origin.x), flat(rect.origin.y), flat(rect.size.width), flat(rect.size.height));
}

/// 计算目标点 targetPoint 围绕坐标点 coordinatePoint 通过 transform 之后此点的坐标
CGPoint
CGPointApplyAffineTransformWithCoordinatePoint(CGPoint coordinatePoint, CGPoint targetPoint, CGAffineTransform t) {
    CGPoint p;
    p.x = (targetPoint.x - coordinatePoint.x) * t.a + (targetPoint.y - coordinatePoint.y) * t.c + coordinatePoint.x;
    p.y = (targetPoint.x - coordinatePoint.x) * t.b + (targetPoint.y - coordinatePoint.y) * t.d + coordinatePoint.y;
    p.x += t.tx;
    p.y += t.ty;
    return p;
}

/// 系统的 CGRectApplyAffineTransform 只会按照 anchorPoint 为 (0, 0) 的方式去计算，但通常情况下我们面对的是 UIView/CALayer，它们默认的 anchorPoint 为 (.5, .5)，所以增加这个函数，在计算 transform 时可以考虑上 anchorPoint 的影响
CGRect
CGRectApplyAffineTransformWithAnchorPoint(CGRect rect, CGAffineTransform t, CGPoint anchorPoint) {
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGPoint oPoint = CGPointMake(rect.origin.x + width * anchorPoint.x, rect.origin.y + height * anchorPoint.y);
    CGPoint top_left = CGPointApplyAffineTransformWithCoordinatePoint(oPoint, CGPointMake(rect.origin.x, rect.origin.y), t);
    CGPoint bottom_left = CGPointApplyAffineTransformWithCoordinatePoint(oPoint, CGPointMake(rect.origin.x, rect.origin.y + height), t);
    CGPoint top_right = CGPointApplyAffineTransformWithCoordinatePoint(oPoint, CGPointMake(rect.origin.x + width, rect.origin.y), t);
    CGPoint bottom_right = CGPointApplyAffineTransformWithCoordinatePoint(oPoint, CGPointMake(rect.origin.x + width, rect.origin.y + height), t);
    CGFloat minX = MIN(MIN(MIN(top_left.x, bottom_left.x), top_right.x), bottom_right.x);
    CGFloat maxX = MAX(MAX(MAX(top_left.x, bottom_left.x), top_right.x), bottom_right.x);
    CGFloat minY = MIN(MIN(MIN(top_left.y, bottom_left.y), top_right.y), bottom_right.y);
    CGFloat maxY = MAX(MAX(MAX(top_left.y, bottom_left.y), top_right.y), bottom_right.y);
    CGFloat newWidth = maxX - minX;
    CGFloat newHeight = maxY - minY;
    CGRect result = CGRectMake(minX, minY, newWidth, newHeight);
    return result;
}

/// 为一个CGRect叠加scale计算
CGRect
CGRectApplyScale(CGRect rect, CGFloat scale) {
    return CGRectFlatted(CGRectMake(CGRectGetMinX(rect) * scale, CGRectGetMinY(rect) * scale, CGRectGetWidth(rect) * scale, CGRectGetHeight(rect) * scale));
}

/// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
CGFloat
CGRectGetMinXHorizontallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flat((CGRectGetWidth(parentRect) - CGRectGetWidth(childRect)) / 2.0);
}

/// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
CGFloat
CGRectGetMinYVerticallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flat((CGRectGetHeight(parentRect) - CGRectGetHeight(childRect)) / 2.0);
}

/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持垂直居中时，layoutingRect的originY
CGFloat
CGRectGetMinYVerticallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinY(referenceRect) + CGRectGetMinYVerticallyCenterInParentRect(referenceRect, layoutingRect);
}

/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
CGFloat
CGRectGetMinXHorizontallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinX(referenceRect) + CGRectGetMinXHorizontallyCenterInParentRect(referenceRect, layoutingRect);
}

/// 为给定的rect往内部缩小insets的大小
CGRect
CGRectInsetEdges(CGRect rect, UIEdgeInsets insets) {
    rect.origin.x += insets.left;
    rect.origin.y += insets.top;
    rect.size.width -= UIEdgeInsetsGetHorizontalValue(insets);
    rect.size.height -= UIEdgeInsetsGetVerticalValue(insets);
    return rect;
}

/// 传入size，返回一个x/y为0的CGRect
CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

CGRect
CGRectFloatTop(CGRect rect, CGFloat top) {
    rect.origin.y = top;
    return rect;
}

CGRect
CGRectFloatBottom(CGRect rect, CGFloat bottom) {
    rect.origin.y = bottom - CGRectGetHeight(rect);
    return rect;
}

CGRect
CGRectFloatRight(CGRect rect, CGFloat right) {
    rect.origin.x = right - CGRectGetWidth(rect);
    return rect;
}

CGRect
CGRectFloatLeft(CGRect rect, CGFloat left) {
    rect.origin.x = left;
    return rect;
}

/// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
CGRect
CGRectLimitRight(CGRect rect, CGFloat rightLimit) {
    rect.size.width = rightLimit - rect.origin.x;
    return rect;
}

/// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
/// 先改变origin.x，让其靠在offset上
/// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
CGRect
CGRectLimitLeft(CGRect rect, CGFloat leftLimit) {
    CGFloat subOffset = leftLimit - rect.origin.x;
    rect.origin.x = leftLimit;
    rect.size.width = rect.size.width - subOffset;
    return rect;
}

/// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
CGRect
CGRectLimitMaxWidth(CGRect rect, CGFloat maxWidth) {
    CGFloat width = CGRectGetWidth(rect);
    rect.size.width = width > maxWidth ? maxWidth : width;
    return rect;
}

CGRect
CGRectSetX(CGRect rect, CGFloat x) {
    rect.origin.x = flat(x);
    return rect;
}

CGRect
CGRectSetY(CGRect rect, CGFloat y) {
    rect.origin.y = flat(y);
    return rect;
}

CGRect
CGRectSetXY(CGRect rect, CGFloat x, CGFloat y) {
    rect.origin.x = flat(x);
    rect.origin.y = flat(y);
    return rect;
}

CGRect
CGRectSetWidth(CGRect rect, CGFloat width) {
    if (width < 0) {
        return rect;
    }
    rect.size.width = flat(width);
    return rect;
}

CGRect
CGRectSetHeight(CGRect rect, CGFloat height) {
    if (height < 0) {
        return rect;
    }
    rect.size.height = flat(height);
    return rect;
}

CGRect
CGRectSetSize(CGRect rect, CGSize size) {
    rect.size = CGSizeFlatted(size);
    return rect;
}

CGRect
CGRectToFixed(CGRect rect, NSUInteger precision) {
    CGRect result = CGRectMake(CGFloatToFixed(CGRectGetMinX(rect), precision),
                               CGFloatToFixed(CGRectGetMinY(rect), precision),
                               CGFloatToFixed(CGRectGetWidth(rect), precision),
                               CGFloatToFixed(CGRectGetHeight(rect), precision));
    return result;
}

CGRect
CGRectRemoveFloatMin(CGRect rect) {
    CGRect result = CGRectMake(removeFloatMin(CGRectGetMinX(rect)),
                               removeFloatMin(CGRectGetMinY(rect)),
                               removeFloatMin(CGRectGetWidth(rect)),
                               removeFloatMin(CGRectGetHeight(rect)));
    return result;
}

/// outerRange 是否包含了 innerRange
BOOL
NSContainingRanges(NSRange outerRange, NSRange innerRange) {
    if (innerRange.location >= outerRange.location && outerRange.location + outerRange.length >= innerRange.location + innerRange.length) {
        return YES;
    }
    return NO;
}


@end

//
//  XSWJVASPTValue.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/17.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XSWJVASPTValue : NSObject

void AddAccessibilityLabel(NSObject *obj, NSString *label);
void AddAccessibilityHint(NSObject *obj, NSString *hint);

CGFloat removeFloatMin(CGFloat floatValue);
CGFloat flatSpecificScale(CGFloat floatValue, CGFloat scale);
CGFloat flat(CGFloat floatValue);
CGFloat floorInPixel(CGFloat floatValue);

BOOL between(CGFloat minimumValue, CGFloat value, CGFloat maximumValue);
BOOL betweenOrEqual(CGFloat minimumValue, CGFloat value, CGFloat maximumValue);

CGFloat CGFloatToFixed(CGFloat value, NSUInteger precision);

/// 用于居中运算
CGFloat CGFloatGetCenter(CGFloat parent, CGFloat child);
CGFloat CGFloatSafeValue(CGFloat value);

#pragma mark - CGPoint

/// 两个point相加
CGPoint CGPointUnion(CGPoint point1, CGPoint point2);
/// 获取rect的center，包括rect本身的x/y偏移
CGPoint CGPointGetCenterWithRect(CGRect rect);
CGPoint CGPointGetCenterWithSize(CGSize size);
CGPoint CGPointToFixed(CGPoint point, NSUInteger precision);
CGPoint CGPointRemoveFloatMin(CGPoint point);


#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CGFloat UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets);
/// 获取UIEdgeInsets在垂直方向上的值
CGFloat UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets);
/// 将两个UIEdgeInsets合并为一个
UIEdgeInsets UIEdgeInsetsConcat(UIEdgeInsets insets1, UIEdgeInsets insets2);
UIEdgeInsets UIEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top);
UIEdgeInsets UIEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left);
UIEdgeInsets UIEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom);
UIEdgeInsets UIEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right);
UIEdgeInsets UIEdgeInsetsToFixed(UIEdgeInsets insets, NSUInteger precision);
UIEdgeInsets UIEdgeInsetsRemoveFloatMin(UIEdgeInsets insets);

#pragma mark - CGSize

/// 判断一个 CGSize 是否存在 NaN
BOOL CGSizeIsNaN(CGSize size);
/// 判断一个 CGSize 是否存在 infinite
BOOL CGSizeIsInf(CGSize size);
/// 判断一个 CGSize 是否为空（宽或高为0）
BOOL CGSizeIsEmpty(CGSize size);
/// 判断一个 CGSize 是否合法（例如不带无穷大的值、不带非法数字）
BOOL CGSizeIsValidated(CGSize size);
/// 将一个 CGSize 像素对齐
CGSize CGSizeFlatted(CGSize size);
/// 将一个 CGSize 以 pt 为单位向上取整
CGSize CGSizeCeil(CGSize size);
/// 将一个 CGSize 以 pt 为单位向下取整
CGSize CGSizeFloor(CGSize size);
CGSize CGSizeToFixed(CGSize size, NSUInteger precision);
CGSize CGSizeRemoveFloatMin(CGSize size);

#pragma mark - CGRect

/// 判断一个 CGRect 是否存在 NaN
BOOL CGRectIsNaN(CGRect rect);
/// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
BOOL CGRectIsInf(CGRect rect);
/// 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）
BOOL CGRectIsValidated(CGRect rect);
/// 检测某个 CGRect 如果存在数值为 NaN 的则将其转换为 0，避免布局中出现 crash
CGRect CGRectSafeValue(CGRect rect);
/// 创建一个像素对齐的CGRect
CGRect CGRectFlatMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CGRect CGRectFlatted(CGRect rect);
/// 计算目标点 targetPoint 围绕坐标点 coordinatePoint 通过 transform 之后此点的坐标
CGPoint CGPointApplyAffineTransformWithCoordinatePoint(CGPoint coordinatePoint, CGPoint targetPoint, CGAffineTransform t);
/// 系统的 CGRectApplyAffineTransform 只会按照 anchorPoint 为 (0, 0) 的方式去计算，但通常情况下我们面对的是 UIView/CALayer，它们默认的 anchorPoint 为 (.5, .5)，所以增加这个函数，在计算 transform 时可以考虑上 anchorPoint 的影响
CGRect CGRectApplyAffineTransformWithAnchorPoint(CGRect rect, CGAffineTransform t, CGPoint anchorPoint);
/// 为一个CGRect叠加scale计算
CGRect CGRectApplyScale(CGRect rect, CGFloat scale);
/// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
CGFloat CGRectGetMinXHorizontallyCenterInParentRect(CGRect parentRect, CGRect childRect);
/// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
CGFloat CGRectGetMinYVerticallyCenterInParentRect(CGRect parentRect, CGRect childRect);
/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持垂直居中时，layoutingRect的originY
CGFloat CGRectGetMinYVerticallyCenter(CGRect referenceRect, CGRect layoutingRect);
/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
CGFloat CGRectGetMinXHorizontallyCenter(CGRect referenceRect, CGRect layoutingRect);
/// 为给定的rect往内部缩小insets的大小
CGRect CGRectInsetEdges(CGRect rect, UIEdgeInsets insets);
/// 传入size，返回一个x/y为0的CGRect
CGRect CGRectMakeWithSize(CGSize size);
CGRect CGRectFloatTop(CGRect rect, CGFloat top);
CGRect CGRectFloatBottom(CGRect rect, CGFloat bottom);
CGRect CGRectFloatRight(CGRect rect, CGFloat right);
CGRect CGRectFloatLeft(CGRect rect, CGFloat left);
/// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
CGRect CGRectLimitRight(CGRect rect, CGFloat rightLimit);
/// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
/// 先改变origin.x，让其靠在offset上
/// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
CGRect CGRectLimitLeft(CGRect rect, CGFloat leftLimit);
/// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
CGRect CGRectLimitMaxWidth(CGRect rect, CGFloat maxWidth);
CGRect CGRectSetX(CGRect rect, CGFloat x);
CGRect CGRectSetY(CGRect rect, CGFloat y);
CGRect CGRectSetXY(CGRect rect, CGFloat x, CGFloat y);
CGRect CGRectSetWidth(CGRect rect, CGFloat width);
CGRect CGRectSetHeight(CGRect rect, CGFloat height);
CGRect CGRectSetSize(CGRect rect, CGSize size);
CGRect CGRectToFixed(CGRect rect, NSUInteger precision);
CGRect CGRectRemoveFloatMin(CGRect rect);
/// outerRange 是否包含了 innerRange
BOOL NSContainingRanges(NSRange outerRange, NSRange innerRange);

@end



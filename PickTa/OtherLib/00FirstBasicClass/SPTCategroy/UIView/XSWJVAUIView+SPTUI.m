//
//  UIView+SPTUI.m
//  BFZLShopMall
//
//  Created by Sanpintian on 2019/6/3.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVAUIView+SPTUI.h"
#import "XSWJVAUIView+Extension.h"

@implementation UIView (SPTUI)

- (UIViewController *)spt_parentController {
    UIResponder *responder = [self nextResponder];

    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }

        responder = [responder nextResponder];
    }

    return nil;
}

- (void)spt_addTarget:(id)target tapAction:(SEL)action {
    self.userInteractionEnabled = YES;// 如UIImageView默认没有开启interaction
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    gesture.delegate = self;
    [self addGestureRecognizer:gesture];
}

// 自定义分割线View OffY
- (void)spt_addSeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(offStart, offY, self.width - offStart - offEnd, lineWidth)];

    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    } else {
        lineView.backgroundColor = lineColor;
    }

    [self addSubview:lineView];
}

// 自定义底部分割线View
- (void)spt_addBottomSeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    [self spt_addSeparatorLineOffY:offStart offEnd:offEnd lineWidth:lineWidth lineColor:lineColor offY:self.height - lineWidth];
}

// 通过view，画任意方向的线
- (void)spt_addDrawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    UIView *lineView = [[UIView alloc] init];

    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    } else {
        lineView.backgroundColor = lineColor;
    }

    if (startPoint.x == endPoint.x) {//竖线
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, lineWidth, endPoint.y - startPoint.y);
    } else if (startPoint.y == endPoint.y) {//横线
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, lineWidth);
    }

    [self addSubview:lineView];
}

// 通过layer，画任意方向的线
- (void)spt_addDrawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);//将上下文复制一份到栈中

    //2.绘制图形
    CGContextSetLineWidth(context, lineWidth);//设置线段宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置线条头尾部的样式
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);//设置颜色
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);//设置起点
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);//画线

    //3.显示到View
    CGContextStrokePath(context);//以空心的方式画出
    CGContextRestoreGState(context);//将图形上下文出栈，替换当前的上下文

    [self setNeedsDisplay];
}

- (void)spt_addBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii] bezierPathByReversingPath];
    CAShapeLayer *border = [CAShapeLayer layer];
    // 线条颜色
    border.strokeColor = lineColor.CGColor;
    border.masksToBounds = YES;
    border.fillColor = nil;
    border.path = maskPath.CGPath;
    border.frame = self.bounds;
    border.lineWidth = lineWidth;
    border.lineCap = @"square";
    // 第一个是 线条长度 第二个是间距 nil时为实线
    border.lineDashPattern = @[@2, @2];
    [self.layer addSublayer:border];
}

+ (void)spt_drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/**
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)spt_drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];// 设置虚线颜色
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];// 设置虚线宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];// 设置线宽，线间距

    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);

    [shapeLayer setPath:path];
    CGPathRelease(path);

    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

// 垂直
- (void)spt_drawDashLineForVerWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];// 设置虚线颜色
    [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];// 设置虚线宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    //数组中前一项代表线的宽度，后一项代表每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];// 设置线宽，线间距
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)spt_addCirleViewWithX:(CGFloat)x y:(CGFloat)y {
    UIView *cirleRedView = [[UIView alloc] init];
    cirleRedView.frame = CGRectMake(x, y, 6, 6);
    cirleRedView.backgroundColor = UIColor.redColor;
    cirleRedView.layer.cornerRadius = 6.0f;
    cirleRedView.tag = 1000;
    [self addSubview:cirleRedView];
}

@end

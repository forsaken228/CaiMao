//
//  CMProgressView.m
//  CaiMao
//
//  Created by MAC on 16/10/31.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProgressView.h"

@implementation CMProgressView

+ (void)initialize
{
    if (self == [CMProgressView class])
    {
        id appearance = [self appearance];
        
       
        [appearance setRoundedHead:YES];//用来控制是否对进度两边进行处理
        [appearance setShowShadow:YES];//控制圆环进度条的样式
        
        [appearance setThicknessRatio:0.15f];//圆环进度条的宽度
        
        [appearance setInnerBackgroundColor:nil];
        [appearance setOuterBackgroundColor:nil];
        
       // [appearance setProgressFillColor:[UIColor colorWithWhite:1 alpha:0.4]];//整个进度条颜色
        [appearance setProgressTopGradientColor:[UIColor colorWithWhite:1 alpha:0.3]];//进度条前半部分颜色
        [appearance setProgressBottomGradientColor:[UIColor colorWithWhite:1 alpha:0.5]];//进度条后半部分颜色
        [appearance setBackgroundColor:[UIColor clearColor]];
    }
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    // Calculate position of the circle
    CGFloat progressAngle = _progress * 360.0 - 90;
    CGPoint center = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2.0f;
    
    CGRect square;
    if (rect.size.width > rect.size.height)
    {
        square = CGRectMake((rect.size.width - rect.size.height) / 2.0, 0.0, rect.size.height, rect.size.height);
    }
    else
    {
        square = CGRectMake(0.0, (rect.size.height - rect.size.width) / 2.0, rect.size.width, rect.size.width);
    }
    
    //进度条宽度
    CGFloat circleWidth = radius * _thicknessRatio;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (_innerBackgroundColor)
    {
        //内环
        // Fill innerCircle with innerBackgroundColor
        UIBezierPath *innerCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                   radius:radius - circleWidth
                                                               startAngle:2*M_PI
                                                                 endAngle:0.0
                                                                clockwise:YES];
        
        [_innerBackgroundColor setFill];
        
        [innerCircle fill];
    }
    
    if (_outerBackgroundColor)
    {
        //外环
        // Fill outerCircle with outerBackgroundColor
        UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                   radius:radius
                                                               startAngle:0.0
                                                                 endAngle:2*M_PI
                                                                clockwise:NO];
        [outerCircle addArcWithCenter:center
                               radius:radius - circleWidth
                           startAngle:2*M_PI
                             endAngle:0.0
                            clockwise:YES];
        
        [_outerBackgroundColor setFill];
        
        [outerCircle fill];
    }
    
    if (_showShadow)
    {
        //圆环背景处理
        CGFloat locations[5] = { 0.0f, 0.33f, 0.66f, 1.0f };
      
        NSArray *gradientColors = @[
                                    (id)[[UIColor colorWithWhite:1 alpha:0.5] CGColor],
                                    (id)[[UIColor colorWithWhite:1 alpha:0.5] CGColor],
                                    (id)[[UIColor colorWithWhite:1 alpha:0.5] CGColor],
                                    (id)[[UIColor colorWithWhite:1 alpha:0.5] CGColor],
                                    ];
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)gradientColors, locations);
        CGContextDrawRadialGradient(context, gradient, center, radius - circleWidth, center, radius, 0);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(rgb);
    }
    

    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:center
                                                    radius:radius
                                                startAngle:DEGREES_TO_RADIANS(-90)
                                                  endAngle:DEGREES_TO_RADIANS(progressAngle)
                                                 clockwise:YES]];
    
    if (_roundedHead)
    {
        //终点处理
        CGPoint point;
        point.x = (cos(DEGREES_TO_RADIANS(progressAngle)) * (radius - circleWidth/2)) + center.x;
        point.y = (sin(DEGREES_TO_RADIANS(progressAngle)) * (radius - circleWidth/2)) + center.y;
        
        [path addArcWithCenter:point
                        radius:circleWidth/2
                    startAngle:DEGREES_TO_RADIANS(progressAngle)
                      endAngle:DEGREES_TO_RADIANS(270.0 + progressAngle - 90.0)
                     clockwise:YES];
    }
    
    [path addArcWithCenter:center
                    radius:radius-circleWidth
                startAngle:DEGREES_TO_RADIANS(progressAngle)
                  endAngle:DEGREES_TO_RADIANS(-90)
                 clockwise:NO];

    if (_roundedHead)
    {
        //起始点处理
//                CGPoint point;
//                point.x = (cos(DEGREES_TO_RADIANS(-90)) * (radius - circleWidth/2)) + center.x;
//                point.y = (sin(DEGREES_TO_RADIANS(-90)) * (radius - circleWidth/2)) + center.y;
//        
//                [path addArcWithCenter:point
//                                radius:circleWidth/2
//                            startAngle:DEGREES_TO_RADIANS(0)
//                              endAngle:DEGREES_TO_RADIANS(-90)
//                             clockwise:NO];
    }
    
    [path closePath];
    //进度条颜色处理
    if (_progressFillColor)
    {
        [_progressFillColor setFill];
        [path fill];
    }
    else if (_progressTopGradientColor && _progressBottomGradientColor)
    {
        [path addClip];
        
        NSArray *backgroundColors = @[
                                      (id)[[UIColor colorWithWhite:1 alpha:0.0] CGColor],
                                      (id)[[UIColor colorWithWhite:1 alpha:0.3] CGColor],
                                      (id)[[UIColor colorWithWhite:1 alpha:0.5] CGColor],
                                      (id)[[UIColor colorWithWhite:1 alpha:0.7] CGColor],
                                      ];
        CGFloat backgroudColorLocations[4] = { 0.0f, 0.3f ,0.6f,1.0f};
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef backgroundGradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)(backgroundColors), backgroudColorLocations);
        CGContextDrawLinearGradient(context,
                                    backgroundGradient,
                                    CGPointMake(0.0f, square.origin.y),
                                    CGPointMake(0.0f, square.size.height),
                                    0);
        CGGradientRelease(backgroundGradient);
        CGColorSpaceRelease(rgb);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Setter
//设置进度
- (void)setProgress:(double)progress
{
    _progress = MIN(1.0, MAX(0.0, progress));
    
    [self setNeedsDisplay];
}

#pragma mark - UIAppearance


- (void)setRoundedHead:(NSInteger)roundedHead
{
    _roundedHead = roundedHead;
    
    [self setNeedsDisplay];
}

- (void)setShowShadow:(NSInteger)showShadow
{
    _showShadow = showShadow;
    
    [self setNeedsDisplay];
}
//进度条宽度与半径之比
- (void)setThicknessRatio:(CGFloat)thickness
{
    _thicknessRatio = MIN(MAX(0.0f, thickness), 1.0f);
    
    [self setNeedsDisplay];
}
//内环
- (void)setInnerBackgroundColor:(UIColor *)innerBackgroundColor
{
    _innerBackgroundColor = innerBackgroundColor;
    
    [self setNeedsDisplay];
}
//外环
- (void)setOuterBackgroundColor:(UIColor *)outerBackgroundColor
{
    _outerBackgroundColor = outerBackgroundColor;
    
    [self setNeedsDisplay];
}
//进度条颜色
- (void)setProgressFillColor:(UIColor *)progressFillColor
{
    _progressFillColor = progressFillColor;
    
    [self setNeedsDisplay];
}
//进度条前半部分颜色
- (void)setProgressTopGradientColor:(UIColor *)progressTopGradientColor
{
    _progressTopGradientColor = progressTopGradientColor;
    
    [self setNeedsDisplay];
}
//进度条后半部分颜色
- (void)setProgressBottomGradientColor:(UIColor *)progressBottomGradientColor
{
    _progressBottomGradientColor = progressBottomGradientColor;
    
    [self setNeedsDisplay];
}

@end

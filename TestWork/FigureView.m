//
//  FigureView.m
//  TestWork
//
//  Created by Nikolay Berlioz on 15.04.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "FigureView.h"

@implementation FigureView


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    
    void (^triangleBlock)(void) = ^{
        
        CGPoint upPoint = CGPointMake(CGRectGetMidX(rect), 0);
        CGPoint rightPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGPoint leftPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
        
        CGContextMoveToPoint(context, upPoint.x, upPoint.y);
        CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);
        CGContextAddLineToPoint(context, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(context, upPoint.x, upPoint.y);
        
    };
    
    void (^squareBlock)(void) = ^{
        
        CGPoint upLeftPoint = CGPointMake(0, 0);
        CGPoint upRightPoint = CGPointMake(CGRectGetMaxX(rect), 0);
        CGPoint downRightPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGPoint downLeftPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
        
        CGContextMoveToPoint(context, upLeftPoint.x, upLeftPoint.y);
        CGContextAddLineToPoint(context, upRightPoint.x, upRightPoint.y);
        CGContextAddLineToPoint(context, downRightPoint.x, downRightPoint.y);
        CGContextAddLineToPoint(context, downLeftPoint.x, downLeftPoint.y);
        CGContextAddLineToPoint(context, upLeftPoint.x, upLeftPoint.y);
    };
    
    void (^rhombusBlock)(void) = ^{
        
        CGPoint upPoint = CGPointMake(CGRectGetMidX(rect), 0);
        CGPoint rightPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
        CGPoint leftPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGPoint downPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
        
        CGContextMoveToPoint(context, upPoint.x, upPoint.y);
        CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);
        CGContextAddLineToPoint(context, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(context, downPoint.x, downPoint.y);
        CGContextAddLineToPoint(context, upPoint.x, upPoint.y);
        
    };
    
    void (^ellipseBlock)(void) = ^{
        
        CGContextAddEllipseInRect(context, rect);
        
    };
    
    
    //рандомно выбираем одну из четырех фигур
    NSInteger figureIndex = 0;
    
    figureIndex = arc4random_uniform(4);
    
    switch (figureIndex) {
        case 0:
            triangleBlock();
            break;
        case 1:
            squareBlock();
            break;
        case 2:
            rhombusBlock();
            break;
        case 3:
            ellipseBlock();
            break;
            
        default:
            break;
    }
    
    CGContextFillPath(context);
}

- (UIColor*) randomColor
{
    CGFloat red = (float)(arc4random() % 256) / 255;
    CGFloat green = (float)(arc4random() % 256) / 255;
    CGFloat blue = (float)(arc4random() % 256) / 255;

    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

@end

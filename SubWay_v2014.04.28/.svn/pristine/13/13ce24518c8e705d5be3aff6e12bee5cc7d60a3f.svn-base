//
//  PlacesTag.m
//  SubWay
//
//  Created by Glex on 14-4-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PlacesTag.h"

@implementation PlacesTag
@synthesize array1,array2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor]set];
    UIRectFill([self bounds]);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,100, 0);
    CGContextAddLineToPoint(context,100,30);
    CGContextAddLineToPoint(context,120,15);
    CGContextClosePath(context);
    [self.backgroundColor setFill];
    CGContextDrawPath(context,kCGPathFillStroke);
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(0.0f,1.0f,101.0f,28.0f);
    CGPathAddRect(path,NULL,rectangle);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(currentContext,path);
    [self.backgroundColor setFill];
    [[UIColor brownColor] setStroke];
    CGContextSetLineWidth(currentContext,0.0f);
    CGContextDrawPath(currentContext,kCGPathFillStroke);
    
    CGPathRelease(path);
}


@end

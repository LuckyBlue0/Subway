//
//  LineStationView.m
//  SubWay
//
//  Created by Glex on 14-4-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LineStationView.h"

@implementation LineStationView

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
    [[UIColor whiteColor] set];
    UIRectFill([self bounds]);
}

@end

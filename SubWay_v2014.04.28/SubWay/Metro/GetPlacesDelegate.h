//
//  GetPlacesDelegate.h
//  SubWay
//
//  Created by Glex on 14-4-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetPlacesDelegate <NSObject>
@optional
-(void)getPlaces:(NSMutableArray *)palcesLineArray;
-(void)search;
@end

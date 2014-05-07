//
//  StationPinyin.h
//  SubWay
//
//  Created by Glex on 14-4-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBPageFlowView.h"
#import "SqliteDao.h"

@interface StationPinyin : UIView
<SBPageFlowViewDataSource,SBPageFlowViewDelegate>
{
    NSArray *_imageArray;
    
    NSInteger    _currentPage;
    
    SBPageFlowView  *_flowView;
    
    UIScrollView *sc;
    
    NSArray *letterArray;
}

@property(nonatomic,retain)UIImageView *upView;
@property(nonatomic,retain)UIImageView *downView;

@property(nonatomic,assign)BOOL mark;
@property(nonatomic,retain)UIImageView *lineImage;
@property(nonatomic,retain)UIImageView *imageView1;
@property(nonatomic,retain)UIImageView *imageView2;
@property(nonatomic,retain)UILabel *lab1;

@property(nonatomic,retain)NSMutableArray *allPlacesArray;

@property(nonatomic,retain)UIView *letterView;
@end

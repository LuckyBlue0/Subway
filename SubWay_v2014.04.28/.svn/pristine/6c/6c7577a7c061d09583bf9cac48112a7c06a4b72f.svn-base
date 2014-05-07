//
//  FindMetro.h
//  SubWay
//
//  Created by apple on 14-3-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBPageFlowView.h"
#import "SqliteDao.h"
#import "StationPinyin.h"

@interface FindMetro : UIView
<SBPageFlowViewDataSource,SBPageFlowViewDelegate,
UIScrollViewDelegate>
{
    NSArray *_imageArray;

    NSInteger    _currentPage;
    
    SBPageFlowView  *_flowView;
    
    StationPinyin *stationV;
}

@property(nonatomic,retain)UIView *topView;
@property(nonatomic,retain)UIButton *homeBtn;

@property(nonatomic,retain)UIButton *stationBtn;
@property(nonatomic,retain)UIButton *lineBtn;
@property(nonatomic,retain)UIImageView *upView;
@property(nonatomic,retain)UIImageView *downView;

@property(nonatomic,assign)BOOL mark;
@property(nonatomic,retain)UIImageView *lineImage;
@property(nonatomic,retain)UIImageView *imageView1;
@property(nonatomic,retain)UIImageView *imageView2;
@property(nonatomic,retain)UILabel *lab1;

@property(nonatomic,retain)NSMutableArray *allPlacesArray;

@property(nonatomic,retain)UIScrollView *sc;

-(void)homeBtnAction;
@end

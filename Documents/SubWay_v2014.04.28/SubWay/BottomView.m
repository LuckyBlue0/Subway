//
//  BottomView.m
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BottomView.h"
#define LOCATIONTEXT @"定位图"
#define GOHOME @" 回家"
#define GOWORK @" 上班"
#define FINDSUBWAYTEXT @"查地铁"
#define QUERYTEXT @"查找"

@implementation BottomView
@synthesize locationBtn,findSubWayBtn,goHomeBtn,goWorkBtn;
@synthesize locationLabel,goHomeLabel,findSubWayLabel,goWorkLabel;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rc = CGRectMake(10,10,30,30);
        
        locationBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        locationBtn.frame=rc;
        [locationBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_dingwei_0_0"] forState:UIControlStateNormal];
         [locationBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_dingwei_0_1"] forState:UIControlStateDisabled];
        [locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:locationBtn];
        
        rc.origin.x=rc.origin.x+25;
        locationLabel=[[UILabel alloc]initWithFrame:rc];
        locationLabel.textColor=[UIColor whiteColor];
        locationLabel.font=[UIFont boldSystemFontOfSize:10];
        locationLabel.backgroundColor=[UIColor clearColor];
        locationLabel.text=LOCATIONTEXT;
        [self addSubview:locationLabel];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width/4,self.frame.size.height)];
        view.backgroundColor=[UIColor clearColor];
        view.userInteractionEnabled=YES;
        [self addSubview:view];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        
        
        
        
        goHomeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        rc.origin.x=rc.origin.x+55;
        goHomeBtn.frame=rc;
        [goHomeBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_huijia_0_0"] forState:UIControlStateNormal];
        [goHomeBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_huijia_0_1"] forState:UIControlStateDisabled];
        [goHomeBtn addTarget:self action:@selector(goHomeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goHomeBtn];
        
        rc.origin.x=rc.origin.x+25;
        goHomeLabel=[[UILabel alloc]initWithFrame:rc];
        goHomeLabel.textColor=[UIColor whiteColor];
        goHomeLabel.font=[UIFont boldSystemFontOfSize:10];
        goHomeLabel.text=GOHOME;
        goHomeLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:goHomeLabel];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/4,0,self.frame.size.width/4,self.frame.size.height)];
        view1.backgroundColor=[UIColor clearColor];
        view1.userInteractionEnabled=YES;
        [self addSubview:view1];
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
        [view1 addGestureRecognizer:tap1];
        
        
        
        goWorkBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        rc.origin.x=rc.origin.x+55;
        goWorkBtn.frame=rc;
        [goWorkBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_shangban_0_0"] forState:UIControlStateNormal];
        [goWorkBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_shangban_0_1"] forState:UIControlStateDisabled];
        [goWorkBtn addTarget:self action:@selector(goWorkAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goWorkBtn];
        
        rc.origin.x=rc.origin.x+25;
        goWorkLabel=[[UILabel alloc]initWithFrame:rc];
        goWorkLabel.textColor=[UIColor whiteColor];
        goWorkLabel.font=[UIFont boldSystemFontOfSize:10];
        goWorkLabel.text=GOWORK;
        goWorkLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:goWorkLabel];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/4*2,0,self.frame.size.width/4,self.frame.size.height)];
        view2.backgroundColor=[UIColor clearColor];
        view2.userInteractionEnabled=YES;
        [self addSubview:view2];
        UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
        [view2 addGestureRecognizer:tap2];
        
        
        
        
        findSubWayBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        rc.origin.x=rc.origin.x+55;
        findSubWayBtn.frame=rc;
        [findSubWayBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_zhandian_0_0"] forState:UIControlStateNormal];
        [findSubWayBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_zhandian_0_1"] forState:UIControlStateDisabled];
        [findSubWayBtn addTarget:self action:@selector(findSubWayAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:findSubWayBtn];
        
        rc.origin.x=rc.origin.x+25;
        findSubWayLabel=[[UILabel alloc]initWithFrame:rc];
        findSubWayLabel.textColor=[UIColor whiteColor];
        findSubWayLabel.font=[UIFont boldSystemFontOfSize:10];
        findSubWayLabel.text=FINDSUBWAYTEXT;
        findSubWayLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:findSubWayLabel];
        
        view3=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/4*3,0,self.frame.size.width/4,self.frame.size.height)];
        view3.backgroundColor=[UIColor clearColor];
        view3.userInteractionEnabled=YES;
        [self addSubview:view3];
        tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3:)];
        [view3 addGestureRecognizer:tap3];
        
        
        
        [self setBackgroundColor:[UIColor colorWithRed:0.32 green:0.76 blue:0.86 alpha:0.9]];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(findSubwayEnableAction) name:@"FINDSUBWAY" object:nil];//查找
        
    }
    return self;
}
-(void)findSubwayEnableAction
{
    [findSubWayBtn setEnabled:YES];
    [view3 addGestureRecognizer:tap3];
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    [self locationAction];
}
-(void)tap1:(UITapGestureRecognizer *)tap
{
    [self goHomeAction];
}
-(void)tap2:(UITapGestureRecognizer *)tap
{
    [self goWorkAction];
}
-(void)tap3:(UITapGestureRecognizer *)tap
{
    [self findSubWayAction];
    [view3 removeGestureRecognizer:tap3];
}
#pragma mark -delegate
-(void)locationAction
{
    [self.delegate location];
}
-(void)goHomeAction
{
    [self.delegate goHome];
}
-(void)goWorkAction
{
    [self.delegate goWork];
}
-(void)findSubWayAction
{
    [self.delegate findSubway];
    [findSubWayBtn setEnabled:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

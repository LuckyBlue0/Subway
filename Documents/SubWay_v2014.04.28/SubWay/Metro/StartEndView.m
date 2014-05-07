//
//  StartEndView.m
//  SubWay
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartEndView.h"

@implementation StartEndView

@synthesize paneView;
@synthesize startBtn,endBtn,infoBtn,lineLabel;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        paneView=[[UIView alloc]initWithFrame:CGRectMake(0,100,self.frame.size.width,40)];
        paneView.backgroundColor=[UIColor yellowColor];
        [self addSubview:paneView];
        
        lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,130,40)];
        lineLabel.backgroundColor=[UIColor clearColor];
        lineLabel.font=[UIFont boldSystemFontOfSize:13];
        lineLabel.textColor=[UIColor whiteColor];
        [paneView addSubview:lineLabel];
        
        startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame=CGRectMake(self.center.x-10,5,50, 30);
        [startBtn setTitle:@"起点" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_0"] forState:UIControlStateNormal];
        [startBtn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [paneView addSubview:startBtn];
        
        endBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        endBtn.frame=CGRectMake(startBtn.frame.origin.x+55,5,50, 30);
        [endBtn setTitle:@"终点" forState:UIControlStateNormal];
        [endBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_1"] forState:UIControlStateNormal];
        [endBtn addTarget:self action:@selector(endBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [paneView addSubview:endBtn];
        
        infoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        infoBtn.frame=CGRectMake(endBtn.frame.origin.x+55,5,50, 30);
        [infoBtn setTitle:@"信息" forState:UIControlStateNormal];
        [infoBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_2"] forState:UIControlStateNormal];
        [infoBtn addTarget:self action:@selector(infoBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [paneView addSubview:infoBtn];
        
        [self setBackgroundColor:[UIColor grayColor]];
        [self setAlpha:0.9];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
-(void)startBtnAction
{
    [self removeFromSuperview];
    [self.delegate startStation];
}
-(void)endBtnAction
{
    [self removeFromSuperview];
    [self.delegate endStation];
}
-(void)infoBtnAction
{
    [self removeFromSuperview];
    [self.delegate infoStation];
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

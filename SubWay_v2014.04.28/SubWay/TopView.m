//
//  self.m
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TopView.h"

@implementation TopView

@synthesize homeBtn,gotoBtn;
@synthesize startText,endText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        homeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        homeBtn.frame=CGRectMake(10,20,30, 30);
        [homeBtn addTarget:self action:@selector(homeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [homeBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_search_0_0"] forState:UIControlStateNormal];
        [self addSubview:homeBtn];
        
        gotoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        gotoBtn.frame=CGRectMake(self.frame.size.width/2,20,30, 30);
        [gotoBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_forward"] forState:UIControlStateDisabled];
        [gotoBtn setEnabled:NO];
        [self addSubview:gotoBtn];
        
        startText=[[UITextField alloc]initWithFrame:CGRectMake(homeBtn.frame.size.width+homeBtn.frame.origin.x+10, 20,110,30)];
        startText.borderStyle=UITextBorderStyleRoundedRect;
        startText.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        startText.textColor=[UIColor colorWithRed:0.25 green:0.5 blue:0.36 alpha:1];
        startText.font=[UIFont boldSystemFontOfSize:12];
        //startText.inputView=[[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:startText];
        [startText setDelegate:self];
        
        UILabel *leftV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,20, 20)];
        leftV.text=@"起";
        leftV.textAlignment=NSTextAlignmentCenter;
        leftV.textColor=[UIColor colorWithRed:0.09 green:0.42 blue:0.26 alpha:1];
        startText.leftViewMode=UITextFieldViewModeAlways;
        startText.leftView=leftV;
        
        UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        close.frame=CGRectMake(0, 0, 20, 20);
        [close setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_close_0_0"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        startText.rightViewMode=UITextFieldViewModeAlways;
        startText.rightView=close;
        
        
        endText=[[UITextField alloc]initWithFrame:CGRectMake(gotoBtn.frame.size.width+gotoBtn.frame.origin.x, 20,110,30)];
        endText.borderStyle=UITextBorderStyleRoundedRect;
        endText.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        endText.textColor=[UIColor colorWithRed:0.81 green:0.26 blue:0.24 alpha:1];
        endText.font=[UIFont boldSystemFontOfSize:12];
        //endText.inputView=[[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:endText];
        endText.delegate=self;
        
        UILabel *leftV1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,20, 20)];
        leftV1.text=@"终";
        leftV1.textAlignment=NSTextAlignmentCenter;
        leftV1.textColor=[UIColor colorWithRed:0.88 green:0.21 blue:0.16 alpha:1];
        endText.leftViewMode=UITextFieldViewModeAlways;
        endText.leftView=leftV1;
        
        UIButton *close1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        close1.frame=CGRectMake(0, 0, 20, 20);
        [close1 setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_close_0_0"] forState:UIControlStateNormal];
        [close1 addTarget:self action:@selector(close1Action) forControlEvents:UIControlEventTouchUpInside];
        endText.rightViewMode=UITextFieldViewModeAlways;
        endText.rightView=close1;
        
        [self setBackgroundColor:[UIColor colorWithRed:0.22 green:0.7 blue:0.76 alpha:0.9]];
       
    }
    return self;
}
-(void)homeBtnAction
{
    [self.delegate search];
}
-(void)closeAction
{
    startText.text=@"";
    [startText becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeBegin" object:nil];
}
-(void)close1Action
{
    endText.text=@"";
    [endText becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeEnd" object:nil];
}

#pragma mark 获得view的viewcontroller
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoBoardHidden:) name:UIKeyboardWillShowNotification object:nil];
    return YES;
}

- (void)keyBoBoardHidden:(NSNotification *)Notification{
    [self.startText resignFirstResponder];
    [self.endText resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    AllStationSelectViewController *station=[[AllStationSelectViewController alloc]initWithNibName:@"AllStationSelectViewController" bundle:nil];
    if(textField==startText)
        station.flagStartEndText=@"startText";
    else
        station.flagStartEndText=@"endText";
    
    [[self viewController] presentViewController:station animated:YES completion:^{
        
    }];
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

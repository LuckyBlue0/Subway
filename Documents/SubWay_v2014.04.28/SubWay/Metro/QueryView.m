//
//  QueryView.m
//  SubWay
//
//  Created by apple on 14-3-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "QueryView.h"

extern NSArray *changeStationArray;

extern NSMutableArray *arrLinePub;
extern NSArray *line1;
extern NSArray *line2;
extern NSArray *line3A;
extern NSArray *line3B;
extern NSArray *line4;
extern NSArray *line5;
extern NSArray *line6;
extern NSArray *line8;
extern NSArray *lineAPM;
extern NSArray *lineGF;

@implementation QueryView
@synthesize startImage,
endImage;
@synthesize startPlaceLabel,endPlaceLabel;
@synthesize timeLabel2;
@synthesize detailLabel,startTimeLabel,endTimeLabel;
@synthesize startView,endView,sc;
@synthesize startKuangImage1,startPlace1;
@synthesize startKuangImage2,endPlace2;
@synthesize station,price;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        startImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_location_3"]];
        startImage.frame=CGRectMake(20,10,25,35);
        [self addSubview:startImage];
        
        startPlaceLabel=[[UILabel alloc]initWithFrame:CGRectMake(startImage.frame.origin.x+30,10,100, 30)];
        startPlaceLabel.text=@"xxxx";
        startPlaceLabel.font=[UIFont boldSystemFontOfSize:13];
        startPlaceLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:startPlaceLabel];

        
        endImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_location_2"]];
        endImage.frame=CGRectMake(150,10,25,35);
        [self addSubview:endImage];
        
               
        endPlaceLabel=[[UILabel alloc]initWithFrame:CGRectMake(endImage.frame.origin.x+30,10,100, 30)];
        endPlaceLabel.text=@"xxxx";
        endPlaceLabel.font=[UIFont boldSystemFontOfSize:13];
        endPlaceLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:endPlaceLabel];

        
        detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,55,self.frame.size.width-40,20)];
        //detailLabel.text=@"xx分钟，xx站，换乘1次\t\txx元";
        detailLabel.backgroundColor=[UIColor clearColor];
        detailLabel.font=[UIFont systemFontOfSize:13];
        [self addSubview:detailLabel];
        
#pragma mark -scrollview
        {
            sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0,80, self.frame.size.width, self.frame.size.height-80)];
            sc.showsVerticalScrollIndicator=NO;
            [sc setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:sc];
        }
        [self addView];
        [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.96]];
    }
    return self;
}
-(void)addView
{
    startTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,0, 200, 20)];
    startTimeLabel.text=@"首末班次 xx:xx";
    startTimeLabel.font=[UIFont systemFontOfSize:13];
    [sc addSubview:startTimeLabel];
    
    endTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,startTimeLabel.frame.origin.y+20, 200, 20)];
    endTimeLabel.text=@"首末班次 xx:xx";
    endTimeLabel.font=[UIFont systemFontOfSize:13];
    [sc addSubview:endTimeLabel];
    
    
    startView=[[UIView alloc]initWithFrame:CGRectMake(0,25, self.frame.size.width,20)];
    startView.backgroundColor=[UIColor redColor];
    [sc addSubview:startView];
    
    startKuangImage1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_kuang_0"]];
    startKuangImage1.frame=CGRectMake(60,-5,30,30);
    [startView addSubview:startKuangImage1];
    
    UILabel *start=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    start.text=@"起";
    start.backgroundColor=[UIColor clearColor];
    start.textAlignment=NSTextAlignmentCenter;
    start.textColor=[UIColor colorWithRed:0.11 green:0.42 blue:0.26 alpha:1];
    [startKuangImage1 addSubview:start];
    
    startPlace1=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200,20)];
    startPlace1.font=[UIFont boldSystemFontOfSize:12];
    startPlace1.textColor=[UIColor whiteColor];
    startPlace1.backgroundColor=[UIColor clearColor];
    startPlace1.text=startPlaceLabel.text;
    [startView addSubview:startPlace1];
    
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
    imageV.frame=CGRectMake(startView.frame.size.width-25,0, 20, 20);
    [startView addSubview:imageV];
    
    endView=[[UIView alloc]initWithFrame:CGRectMake(0,sc.frame.size.height-25, self.frame.size.width,20)];
    endView.backgroundColor=[UIColor redColor];
    [sc addSubview:endView];
    
    
    startKuangImage2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_kuang_0"]];
    startKuangImage2.frame=CGRectMake(60,-5,30,30);
    [endView addSubview:startKuangImage2];
    
    UILabel *end=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
    end.text=@"终";
    end.backgroundColor=[UIColor clearColor];
    end.textAlignment=NSTextAlignmentCenter;
    end.textColor=[UIColor colorWithRed:0.11 green:0.42 blue:0.26 alpha:1];
    [startKuangImage2 addSubview:end];
    
    endPlace2=[[UILabel alloc]initWithFrame:CGRectMake(100,0, 200,20)];
    endPlace2.font=[UIFont boldSystemFontOfSize:12];
    endPlace2.textColor=[UIColor whiteColor];
    endPlace2.backgroundColor=[UIColor clearColor];
    endPlace2.text=endPlaceLabel.text;
    [endView addSubview:endPlace2];
    
    UIImageView *imageV1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
    imageV1.frame=CGRectMake(endView.frame.size.width-25,0, 20, 20);
    [endView addSubview:imageV1];

}

#pragma mark -列出路线
-(void)getPlaces:(NSMutableArray *)palcesLineArray
{
    for (UIView *s in [sc subviews]) {
        [s removeFromSuperview];
    }
    
    [self addView];
    price=[Dijkstra price:startPlaceLabel.text end:endPlaceLabel.text array:palcesLineArray];//计算价格已经加上起点和终点了  顺序不能换
    
    changeArray1=[Dijkstra transLine:palcesLineArray s:startPlaceLabel.text s1:endPlaceLabel.text];
    
    NSMutableArray *changeDirectionLineArray=[Dijkstra changeLineDirection:changeArray1 passStation:palcesLineArray str:endPlaceLabel.text];
    
    NSMutableArray *arrayLine=[[NSMutableArray alloc]init];
    if([[palcesLineArray objectAtIndex:0] hasSuffix:@"（未开通）"])
    {
        NSRange range=[[palcesLineArray objectAtIndex:0] rangeOfString:@"（"];
        NSString *str=[[palcesLineArray objectAtIndex:0] substringWithRange:NSMakeRange(0, range.location)];
        arrayLine=[SqliteDao findLineByStationId:str];//得出几号线
    }
    else
    {
        arrayLine=[SqliteDao findLineByStationId:[palcesLineArray objectAtIndex:0]];//得出几号线
    }
    
    
    [palcesLineArray removeObject:startPlaceLabel.text];
    [palcesLineArray removeObject:endPlaceLabel.text];
    
    direction=[Dijkstra direction:palcesLineArray str:startPlaceLabel.text str1:endPlaceLabel.text];
    
    ///////////////////////画线
    stationView=[[LineStationView alloc]initWithFrame:CGRectMake(0,50, sc.frame.size.width,20)];
    [sc addSubview:stationView];
    
    UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sc.frame.size.width,20)];
    im.backgroundColor=[UIColor clearColor];
    [stationView addSubview:im];
    
    UILabel *directionLabel=[[UILabel alloc]initWithFrame:CGRectMake(175,0,200,20)];
    directionLabel.backgroundColor=[UIColor clearColor];
    directionLabel.font=[UIFont systemFontOfSize:10];
    directionLabel.textColor=[UIColor grayColor];
    [im addSubview:directionLabel];
    
    NSString *lineStr;
    if(arrLinePub.count>0)
        lineStr=[[arrLinePub objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
    else
        lineStr=[[arrayLine objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
    
    directionLabel.text=[NSString stringWithFormat:@"%@号线 去往%@方向",lineStr,direction];

    UIGraphicsBeginImageContext(im.frame.size);
    [im.image drawInRect:CGRectMake(0, 0, im.frame.size.width, im.frame.size.height)];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,1);
    CGContextSetRGBStrokeColor(context,0.0, 0.0, 0.0, 1.0);
    CGContextSetShouldAntialias(context, NO);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,75,0);
    CGContextAddLineToPoint(context,75,20);
    CGContextStrokePath(context);
    im.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    for (int i=0;i<[palcesLineArray count];i++)
    {
        //NSLog(@"-----列出路线----个数---%@----%i",[palcesLineArray objectAtIndex:i],palcesLineArray.count);
        if(i==0)
        {
            stationView=[[LineStationView alloc]initWithFrame:CGRectMake(0,70, sc.frame.size.width,40)];
            [sc addSubview:stationView];
            
            UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sc.frame.size.width,40)];
            im.backgroundColor=[UIColor clearColor];
            [stationView addSubview:im];
            
            
            UILabel *stationLabel=[[UILabel alloc]initWithFrame:CGRectMake(85,10,105,20)];
            stationLabel.backgroundColor=[UIColor clearColor];
            stationLabel.textColor=[UIColor grayColor];
            stationLabel.font=[UIFont systemFontOfSize:13];
            stationLabel.text=[palcesLineArray objectAtIndex:i];
            [im addSubview:stationLabel];
            
            UIGraphicsBeginImageContext(im.frame.size);
            [im.image drawInRect:CGRectMake(0, 0, im.frame.size.width, im.frame.size.height)];
            CGContextRef context=UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context,1);
            CGContextSetRGBStrokeColor(context,0.0, 0.0, 0.0, 1.0);
            CGContextSetShouldAntialias(context, NO);
            CGContextBeginPath(context);
            CGContextMoveToPoint(context,75,0);
            CGContextAddLineToPoint(context,75,40);
            CGContextStrokePath(context);
            
            CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextAddArc(context,75,20,3.5, 0,2*PI, 0);
            CGContextFillPath(context);
            
            im.image=UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            for (NSString *s in changeArray1) {
                if([[palcesLineArray objectAtIndex:i] isEqualToString:s])
                {
//                    NSMutableArray *startArray=[SqliteDao findLineByStationId:s];
//                    NSString *color=[[startArray objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    
                    NSString *color=[[arrayPublicLine objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    color=[color substringWithRange:NSMakeRange(5, color.length-6)];
                    NSArray *colorArray=[color componentsSeparatedByString:@","];
                    
                    im.backgroundColor=RGB([colorArray[0] floatValue], [colorArray[1] floatValue], [colorArray[2] floatValue], [colorArray[3] floatValue]);
                    stationLabel.textColor=[UIColor whiteColor];
                    
                    UILabel *directoinLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(175,10,120, 20)];
                    directoinLineLabel.textColor=[UIColor whiteColor];
                    directoinLineLabel.backgroundColor=[UIColor clearColor];
                    directoinLineLabel.font=[UIFont systemFontOfSize:10];
                    [im addSubview:directoinLineLabel];
                    
                    directoinLineLabel.text=[NSString stringWithFormat:@"%@号线 去往%@方向",[changeDirectionLineArray[0] objectAtIndex:0],[changeDirectionLineArray[0] objectAtIndex:1]];
                    
                    UIImageView *imageV1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
                    imageV1.frame=CGRectMake(im.frame.size.width-25,10, 20, 20);
                    [im addSubview:imageV1];
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
                    im.userInteractionEnabled=YES;
                    [im addGestureRecognizer:tap];
                }
            }
        }
        else
        {
            if(i==1)
            {
                stationView=[[LineStationView alloc]initWithFrame:CGRectMake(0,110, sc.frame.size.width,40)];
                [sc addSubview:stationView];
            }
            else if(i==2)
            {
                stationView=[[LineStationView alloc]initWithFrame:CGRectMake(0,150, sc.frame.size.width,40)];
                [sc addSubview:stationView];
            }
            else
            {
                stationView=[[LineStationView alloc]initWithFrame:CGRectMake(0,150+40*(i-2), sc.frame.size.width,40)];
                [sc addSubview:stationView];
            }
            UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sc.frame.size.width,40)];
            im.backgroundColor=[UIColor clearColor];
            [stationView addSubview:im];
            
            UILabel *stationLabel=[[UILabel alloc]initWithFrame:CGRectMake(85,13,105,20)];
            stationLabel.backgroundColor=[UIColor clearColor];
            stationLabel.textColor=[UIColor grayColor];
            stationLabel.font=[UIFont systemFontOfSize:13];
            stationLabel.text=[palcesLineArray objectAtIndex:i];
            [im addSubview:stationLabel];
            
            UIGraphicsBeginImageContext(im.frame.size);
            [im.image drawInRect:CGRectMake(0, 0, im.frame.size.width, im.frame.size.height)];
            CGContextRef context=UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context,1);
            CGContextSetRGBStrokeColor(context,0.0, 0.0, 0.0, 1.0);
            CGContextSetShouldAntialias(context, NO);
            CGContextBeginPath(context);
            CGContextMoveToPoint(context,75,0);
            CGContextAddLineToPoint(context,75,40);
            CGContextStrokePath(context);
            
            CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextAddArc(context,75,22,3.5, 0,2*PI, 0);
            CGContextFillPath(context);
            
            im.image=UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            for (int j=0; j<changeArray1.count;j++) {
                if([[palcesLineArray objectAtIndex:i] isEqualToString:[changeArray1 objectAtIndex:j]])
                {   
                    //NSMutableArray *startArray=[SqliteDao findLineByStationId:[changeArray1 objectAtIndex:j]];
                    //NSString *color=[[startArray objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    
                    NSString *color=[[arrayPublicLine objectAtIndex:j]objectForKey:@"ZCOLOR"];
                    color=[color substringWithRange:NSMakeRange(5, color.length-6)];
                    NSArray *colorArray=[color componentsSeparatedByString:@","];
                    
                    im.backgroundColor=RGB([colorArray[0] floatValue], [colorArray[1] floatValue], [colorArray[2] floatValue], [colorArray[3] floatValue]);
                    stationLabel.textColor=[UIColor whiteColor];
                    
                    UILabel *directoinLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(175,10,120, 20)];
                    directoinLineLabel.textColor=[UIColor whiteColor];
                    directoinLineLabel.backgroundColor=[UIColor clearColor];
                    directoinLineLabel.font=[UIFont systemFontOfSize:10];
                    [im addSubview:directoinLineLabel];
                    directoinLineLabel.text=[NSString stringWithFormat:@"%@号线 去往%@方向",[[changeDirectionLineArray objectAtIndex:j] objectAtIndex:0],[[changeDirectionLineArray objectAtIndex:j] objectAtIndex:1]];
                    
                    UIImageView *imageV1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
                    imageV1.frame=CGRectMake(im.frame.size.width-25,10, 20, 20);
                    [im addSubview:imageV1];
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
                    im.userInteractionEnabled=YES;
                    [im addGestureRecognizer:tap];
                }
            }
        }
    }
    
    LineStationView *stationV=[[LineStationView alloc]initWithFrame:CGRectMake(0,((palcesLineArray.count-1)*40)+110, sc.frame.size.width,20)];
    [sc addSubview:stationV];
    
    UIImageView *im1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sc.frame.size.width, 20)];
    im1.backgroundColor=[UIColor clearColor];
    [stationV addSubview:im1];
    
    UIGraphicsBeginImageContext(im1.frame.size);
    [im1.image drawInRect:CGRectMake(0, 0, im1.frame.size.width, im1.frame.size.height)];
    CGContextRef context1=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context1,1);
    CGContextSetRGBStrokeColor(context1,0.0, 0.0, 0.0, 1.0);
    CGContextSetShouldAntialias(context1, NO);
    CGContextBeginPath(context1);
    CGContextMoveToPoint(context1,75,0);
    CGContextAddLineToPoint(context1,75,20);
    CGContextStrokePath(context1);
    
    im1.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(palcesLineArray.count>0)
        endView.frame=CGRectMake(0, sc.frame.origin.y+((palcesLineArray.count-1)*40)+55,CGRectGetWidth(self.frame), 20);
    else
        endView.frame=CGRectMake(0,95,CGRectGetWidth(self.frame), 20);
    
    endTimeLabel.frame=CGRectMake(20, endView.frame.origin.y+25,CGRectGetWidth(self.frame), 20);
    [sc setContentSize:CGSizeMake(0,((palcesLineArray.count-1)*40)+185)];
    
    if(changeArray1.count==0)
        detailLabel.text=[NSString stringWithFormat:@"%@站\t\t\t%@元",station,price];
    else
        detailLabel.text=[NSString stringWithFormat:@"%@站，换乘%i次\t\t\t%@元",station,changeArray1.count,price];
    
    NSMutableDictionary *dictTime=[SqliteDao findStartAndEndTime1:startPlace1.text str:direction];
    if(dictTime.count==0)
    {
        NSMutableArray *arrayTime1=[SqliteDao findStartAndEndTime:startPlace1.text];
        if(arrayTime1.count==1)
            startTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:0] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:0] objectForKey:@"ZENDTIME"]];
        if(arrayTime1.count>1)
            startTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:1] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:1] objectForKey:@"ZENDTIME"]];
    }
    else
        startTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[dictTime objectForKey:@"ZSTARTTIME"],[dictTime objectForKey:@"ZENDTIME"]];
    
    NSMutableDictionary *dictTime1;
    if(changeDirectionLineArray.count>0)
        dictTime1=[SqliteDao findStartAndEndTime1:endPlaceLabel.text str:changeDirectionLineArray[changeDirectionLineArray.count-1][1]];
    else
        dictTime1=[SqliteDao findStartAndEndTime1:endPlaceLabel.text str:direction];
    
    if(dictTime1.count==0)
    {
        NSMutableArray *arrayTime1=[SqliteDao findStartAndEndTime:endPlaceLabel.text];
        if(arrayTime1.count==1)
            endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:0] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:0] objectForKey:@"ZENDTIME"]];
        if(arrayTime1.count>1)
            endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:1] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:1] objectForKey:@"ZENDTIME"]];
    }
    else
        endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[dictTime1 objectForKey:@"ZSTARTTIME"],[dictTime1 objectForKey:@"ZENDTIME"]];
    
    
}

-(void)getLineAndColor:(NSString *)start str:(NSString *)end
{
    NSMutableArray *startArray=[SqliteDao findLineByStationId:start];
    NSMutableArray *endArray=[SqliteDao findLineByStationId:end];
    
    NSString *color=[[startArray objectAtIndex:0]objectForKey:@"ZCOLOR"];
    color=[color substringWithRange:NSMakeRange(5, color.length-6)];
    NSArray *colorArray=[color componentsSeparatedByString:@","];
    
    float red= ([colorArray[0] floatValue])/255;
    float green= ([colorArray[1] floatValue])/255;
    float blue= ([colorArray[2] floatValue])/255;
    float alpha= ([colorArray[3] floatValue]);
    startView.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    UITapGestureRecognizer *startTapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
    startView.userInteractionEnabled=YES;
    [startView addGestureRecognizer:startTapGestureRecognizer];
    
    
    
    NSString *color1=[[endArray objectAtIndex:0]objectForKey:@"ZCOLOR"];
    color1=[color1 substringWithRange:NSMakeRange(5,color1.length-6)];
    NSArray *colorArray1=[color1 componentsSeparatedByString:@","];
    
    float red1= ([colorArray1[0] floatValue])/255;
    float green1= ([colorArray1[1] floatValue])/255;
    float blue1= ([colorArray1[2] floatValue])/255;
    float alpha1= ([colorArray1[3] floatValue]);
    endView.backgroundColor=[UIColor colorWithRed:red1 green:green1 blue:blue1 alpha:alpha1];
    UITapGestureRecognizer *endTapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
    endView.userInteractionEnabled=YES;
    [endView addGestureRecognizer:endTapGestureRecognizer];
    
    NSString *startFlag=[[startArray objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
    if([startFlag isEqualToString:@"1"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_0"];
    if([startFlag isEqualToString:@"2"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_1"];
    if([startFlag isEqualToString:@"3"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_2"];
    if([startFlag isEqualToString:@"4"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_3"];
    if([startFlag isEqualToString:@"5"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_4"];
    if([startFlag isEqualToString:@"6"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_9"];
    if([startFlag isEqualToString:@"8"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_6"];
    if([startFlag isEqualToString:@"APM"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_8"];
    if([startFlag isEqualToString:@"GF"])
        startKuangImage1.image=[UIImage imageNamed:@"iPhone_kuang_7"];
    
    
    NSString *endFlag=[[endArray objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
    if([endFlag isEqualToString:@"1"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_0"];
    if([endFlag isEqualToString:@"2"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_1"];
    if([endFlag isEqualToString:@"3"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_2"];
    if([endFlag isEqualToString:@"4"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_3"];
    if([endFlag isEqualToString:@"5"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_4"];
    if([endFlag isEqualToString:@"6"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_9"];
    if([endFlag isEqualToString:@"8"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_6"];
    if([endFlag isEqualToString:@"APM"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_8"];
    if([endFlag isEqualToString:@"GF"])
        startKuangImage2.image=[UIImage imageNamed:@"iPhone_kuang_7"];
    
}
#pragma mark -手势事件
-(void)startTap:(UITapGestureRecognizer *)tap
{
    for (UIView *s in [tap view].subviews) {
        if([s isKindOfClass:[UILabel class]])
        {
            NSString *place=((UILabel *)s).text;
            
            InfoViewController *info=[[InfoViewController alloc]init];
            info.place=((UILabel *)s).text;
            info.arrayLine=[SqliteDao findLineByStationId:place];
            
            info.infoArray=[SqliteDao findEntranceByStationId:place];
            
            info.arrayStartAndEndTime=[SqliteDao findStartAndEndTime:place];
            
            [[self viewController] presentViewController:info animated:YES completion:^{
                
            }];
        }
    }
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
@end

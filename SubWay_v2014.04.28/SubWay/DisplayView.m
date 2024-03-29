//
//  DisplayView.m
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DisplayView.h"

extern NSMutableArray *allStationArray;

@implementation DisplayView

@synthesize scrollView,imageView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
        scrollView.backgroundColor=[UIColor whiteColor];
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 4.2;
        scrollView.minimumZoomScale = 1.2;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        [self insertSubview:scrollView atIndex:0];


        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,60,375,375)];
        imageView.image=[UIImage imageNamed:@"map"];
        imageView.userInteractionEnabled=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [scrollView insertSubview:imageView atIndex:0];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLocation:) name:@"Location" object:nil];//定位图
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LocationHome:) name:@"LocationHome" object:nil];//定位当前位置设为家
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LocationCompany:) name:@"LocationCompany" object:nil];//定位当前位置设为公司
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startValueAction:) name:@"StartValue" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endValueAction:) name:@"EndValue" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeBegin:) name:@"closeBegin" object:nil];//点击起点的文本框的叉
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeEnd:) name:@"closeEnd" object:nil];//点击终点的文本框的叉
        
        [scrollView setZoomScale:1.2];
        scrollView.contentSize=CGSizeMake(375*scrollView.zoomScale,375*scrollView.zoomScale+60);
        if(!IS_IPHONE5)
            [scrollView setContentOffset:CGPointMake(40,30)];
        
        startMark=YES;
        endMark=YES;
    }
    return self;
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{
    return imageView;
}
-(void)closeBegin:(NSNotification *)notification
{
    [[self viewWithTag:111]removeFromSuperview];
    startMark=YES;
}
-(void)closeEnd:(NSNotification *)notification
{
    [[self viewWithTag:222]removeFromSuperview];
    endMark=YES;
}
#pragma mark -定位图通知
-(void)getLocation:(NSNotification *)notification
{
    dictLocation=[notification object];
    
    [scrollView setZoomScale:3.2f animated:YES];
    [self.delegate passScaleValue:3.2];
    
    minDistanceDic=[[NSMutableDictionary alloc]init];
    
    for (int i=0; i<[allStationArray count]; i++)
    {
        if([[[allStationArray objectAtIndex:i] objectForKey:@"ZOPEN"]floatValue]==1)
        {
            //查询数据库得到
            float a= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLATITUDE"] floatValue];
            float b= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLONGITUDE"] floatValue];
            //定位得出的
            float c=[[[dictLocation allValues] objectAtIndex:0] floatValue];
            float d=[[[dictLocation allKeys] objectAtIndex:0] floatValue];

            CLLocation *location=[[CLLocation alloc] initWithLatitude:a longitude:b];
            CLLocationDistance distance=[location distanceFromLocation:[[CLLocation alloc] initWithLatitude:c longitude:d]];
            
            [minDistanceDic setValue:[NSNumber numberWithFloat:distance] forKey:[[allStationArray objectAtIndex:i]objectForKey:@"ZNAME"]];
        }
    }
    NSArray *ar=[minDistanceDic allValues];
    ar=[ar sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    [minDistanceDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        float a=[obj floatValue];
        float b=[[ar objectAtIndex:0] floatValue];
        if(a==b)
        {
            NSLog(@"-%@",key);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"passLocationPlace" object:key];
            [self.delegate startFieldText:key];
            
            NSDictionary *dic=[SqliteDao findStationDetailInfo:key];
            
            NSString *str=[dic objectForKey:@"ZMAPX"];
            NSString *str1=[dic objectForKey:@"ZMAPY"];
            
            float a=([str floatValue]*scrollView.zoomScale/4)-5;
            float b=([str1 floatValue]*(scrollView.zoomScale/4)+60)-5;
            [scrollView setContentOffset:CGPointMake(a-self.frame.size.width/2,b-self.frame.size.height/2) animated:YES];
            [self addBeginEndView:@"Begin" f1:a f2:b];
        }
    }];
}
#pragma mark -定位当前位置设为家为终点通知
-(void)LocationHome:(NSNotification *)notification
{
    NSMutableDictionary *locationHome=[notification object];
    
    minDistanceDic=[[NSMutableDictionary alloc]init];
    
    for (int i=0; i<[allStationArray count]; i++)
    {
        if([[[allStationArray objectAtIndex:i] objectForKey:@"ZOPEN"]floatValue]==1)
        {
            //查询数据库得到
            float a= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLATITUDE"] floatValue];
            float b= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLONGITUDE"] floatValue];
            //定位得出的
            float c=[[[locationHome allValues] objectAtIndex:0] floatValue];
            float d=[[[locationHome allKeys] objectAtIndex:0] floatValue];
            
            CLLocation *location=[[CLLocation alloc] initWithLatitude:a longitude:b];
            CLLocationDistance distance=[location distanceFromLocation:[[CLLocation alloc] initWithLatitude:c longitude:d]];
            
            [minDistanceDic setValue:[NSNumber numberWithFloat:distance] forKey:[[allStationArray objectAtIndex:i]objectForKey:@"ZNAME"]];
        }
    }
    NSArray *ar=[minDistanceDic allValues];
    ar=[ar sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    [minDistanceDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        float a=[obj floatValue];
        float b=[[ar objectAtIndex:0] floatValue];
        if(a==b)
        {
            NSLog(@"-%@",key);
            [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"home"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}
-(void)LocationCompany:(NSNotification *)notification
{
    NSMutableDictionary *locationCompany=[notification object];
    
    minDistanceDic=[[NSMutableDictionary alloc]init];
    
    for (int i=0; i<[allStationArray count]; i++)
    {
        if([[[allStationArray objectAtIndex:i] objectForKey:@"ZOPEN"]floatValue]==1)
        {
            //查询数据库得到
            float a= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLATITUDE"] floatValue];
            float b= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLONGITUDE"] floatValue];
            //定位得出的
            float c=[[[locationCompany allValues] objectAtIndex:0] floatValue];
            float d=[[[locationCompany allKeys] objectAtIndex:0] floatValue];
            
            CLLocation *location=[[CLLocation alloc] initWithLatitude:a longitude:b];
            CLLocationDistance distance=[location distanceFromLocation:[[CLLocation alloc] initWithLatitude:c longitude:d]];
            
            [minDistanceDic setValue:[NSNumber numberWithFloat:distance] forKey:[[allStationArray objectAtIndex:i]objectForKey:@"ZNAME"]];
        }
    }
    NSArray *ar=[minDistanceDic allValues];
    ar=[ar sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    [minDistanceDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        float a=[obj floatValue];
        float b=[[ar objectAtIndex:0] floatValue];
        if(a==b)
        {
            NSLog(@"-%@",key);
            [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"company"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}
#pragma mark -点击地图上的站点
-(void)tapAction:(UITapGestureRecognizer *)gest
{
    [scrollView setZoomScale:3.2f animated:YES];
    [self.delegate passScaleValue:3.2];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    pt=[gest locationInView:gest.view.superview];
    pt1=[gest locationInView:gest.view.superview.superview];
    
    //NSLog(@"-在图片上的-%f--%f:",pt.x,pt.y);
    //NSLog(@"-在scrollview上的1-%f-1-%f:",pt1.x,pt1.y);
    
    for (int i=0; i<[allStationArray count]; i++)
    {
        if([[[allStationArray objectAtIndex:i] objectForKey:@"ZOPEN"]floatValue]==1)
        {
            mapx=[[allStationArray objectAtIndex:i] objectForKey:@"ZMAPX"];
            mapy=[[allStationArray objectAtIndex:i] objectForKey:@"ZMAPY"];
            
            if(CGRectContainsPoint(CGRectMake(([mapx floatValue]*scrollView.zoomScale/4)-5,([mapy floatValue]*(scrollView.zoomScale/4)+60)-5,20,20), pt))
            {
                mapx1=[[allStationArray objectAtIndex:i] objectForKey:@"ZMAPX"];
                mapy1=[[allStationArray objectAtIndex:i] objectForKey:@"ZMAPY"];
                
                [scrollView setContentOffset:CGPointMake(pt.x-self.frame.size.width/2,pt.y-self.frame.size.height/2) animated:YES];
                
                StartEndView *s=[[StartEndView alloc]initWithFrame:CGRectMake(0,60,self.frame.size.width,self.frame.size.height-110)];
                s.delegate=self;
                [self addSubview:s];
                
                CATransition * animation = [CATransition animation];
                animation.delegate = self;
                animation.duration = 0.3;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type =kCATransitionFade;
                animation.subtype = kCATransitionFromLeft;
                [self.layer addAnimation:animation forKey:@"animation"];
                
                s.paneView.frame=CGRectMake(0,s.frame.size.height/2-45,self.frame.size.width,40);
                place=[[allStationArray objectAtIndex:i] objectForKey:@"ZNAME"];
                englishName=[[allStationArray objectAtIndex:i] objectForKey:@"ZENGLISHNAME"];
                
//                NSLog(@"places:%@--station id:%@===英文名字：%@",place,[[allStationArray objectAtIndex:i] objectForKey:@"ZSTATIONID"],[[allStationArray objectAtIndex:i] objectForKey:@"ZENGLISHNAME"]);
                
                arrayLine=[SqliteDao findLineByStationId:place];//得出几号线
                if(arrayLine.count>0)
                {
                    NSString *lineStr=[[arrayLine objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
                    NSString *linePlace=[[allStationArray objectAtIndex:i] objectForKey:@"ZNAME"];
                    s.lineLabel.text=[NSString stringWithFormat:@"%@\t%@",lineStr,linePlace];
                    
                    NSString *color=[[arrayLine objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    color=[color substringWithRange:NSMakeRange(5, color.length-6)];
                    NSArray *colorArray=[color componentsSeparatedByString:@","];
                    float red= ([colorArray[0] floatValue])/255;
                    float green= ([colorArray[1] floatValue])/255;
                    float blue= ([colorArray[2] floatValue])/255;
                    float alpha= ([colorArray[3] floatValue]);                    
                    s.paneView.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
                }
                if(arrayLine.count>1)
                {
                    NSString *lineStr=[[arrayLine objectAtIndex:0]objectForKey:@"ZLINENUMBER"];
                    NSString *lineStr1=[[arrayLine objectAtIndex:1]objectForKey:@"ZLINENUMBER"];
                    
                    NSString *linePlace=[[allStationArray objectAtIndex:i] objectForKey:@"ZNAME"];
                    s.lineLabel.text=[NSString stringWithFormat:@"%@  %@\t%@",lineStr,lineStr1,linePlace];
                    
                    NSString *color=[[arrayLine objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    color=[color substringWithRange:NSMakeRange(5, color.length-6)];
                    NSArray *colorArray=[color componentsSeparatedByString:@","];
                    float red= ([colorArray[0] floatValue])/255;
                    float green= ([colorArray[1] floatValue])/255;
                    float blue= ([colorArray[2] floatValue])/255;
                    float alpha= ([colorArray[3] floatValue]);
                    s.paneView.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
                }
            }
        }
    }
}
-(void)startValueAction:(NSNotification *)notification
{
    NSString *str=[notification object];
    [allStationArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
            if([str isEqualToString:[obj objectForKey:@"ZNAME"]]&&[[obj objectForKey:@"ZOPEN"] floatValue]==1)
            {
                [scrollView setZoomScale:3.2f animated:YES];
                [self.delegate passScaleValue:3.2];
                
                NSString *str=[obj objectForKey:@"ZMAPX"];
                NSString *str1=[obj objectForKey:@"ZMAPY"];
                
                float a=([str floatValue]*scrollView.zoomScale/4)-5;
                float b=([str1 floatValue]*(scrollView.zoomScale/4)+60)-5;
                [scrollView setContentOffset:CGPointMake(a-self.frame.size.width/2,b-self.frame.size.height/2) animated:YES];
                [self addBeginEndView:@"Begin" f1:a f2:b];
            }
    }];
}
-(void)endValueAction:(NSNotification *)notification
{
    NSString *str=[notification object];
    [allStationArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if([str isEqualToString:[obj objectForKey:@"ZNAME"]]&&[[obj objectForKey:@"ZOPEN"] floatValue]==1)
        {
            [scrollView setZoomScale:3.2f animated:YES];
            [self.delegate passScaleValue:3.2];


            NSString *str=[obj objectForKey:@"ZMAPX"];
            NSString *str1=[obj objectForKey:@"ZMAPY"];

            float a=([str floatValue]*scrollView.zoomScale/4)-5;
            float b=([str1 floatValue]*(scrollView.zoomScale/4)+60)-5;
            [scrollView setContentOffset:CGPointMake(a-self.frame.size.width/2,b-self.frame.size.height/2) animated:YES];
            [self addBeginEndView:@"End" f1:a f2:b];
        }
    }];
}
-(void)addBeginEndView:(NSString *)str f1:(float)a f2:(float)b
{
    if([str isEqualToString:@"Begin"])
    {
        if(startMark)
        {
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake((a/scrollView.zoomScale)-3.5,(b/scrollView.zoomScale)-(30+15/scrollView.zoomScale)+3,10,15)];
            UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_location_3"]];
            image.frame=CGRectMake(0,0,10,15);
            [view addSubview:image];
            view.tag=111;
            [self.imageView addSubview:view];
            startMark=NO;
        }
        else
        {
            [[self viewWithTag:111]setFrame:CGRectMake((a/scrollView.zoomScale)-3.5,(b/scrollView.zoomScale)-(30+15/scrollView.zoomScale)+3,10,15)];
        }
    }
    else
    {
        if(endMark)
        {
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake((a/scrollView.zoomScale)-3.5,(b/scrollView.zoomScale)-(30+15/scrollView.zoomScale)+3,10,15)];
            UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_location_2"]];
            image.frame=CGRectMake(0,0,10,15);
            [view addSubview:image];
            view.tag=222;
            [self.imageView addSubview:view];
            endMark=NO;
        }
        else
        {
            [[self viewWithTag:222]setFrame:CGRectMake((a/scrollView.zoomScale)-3.5,(b/scrollView.zoomScale)-(30+15/scrollView.zoomScale)+3,10,15)];
        }
    }
}
#pragma mark -设为起点
-(void)startStation
{
    float a=([mapx1 floatValue]*scrollView.zoomScale/4)-5;
    float b=([mapy1 floatValue]*(scrollView.zoomScale/4)+60)-5;
    
    [self addBeginEndView:@"Begin" f1:a f2:b];
    
    [self.delegate startFieldText:place];
}
#pragma mark —设为终点
-(void)endStation
{
    float a=([mapx1 floatValue]*scrollView.zoomScale/4)-5;
    float b=([mapy1 floatValue]*(scrollView.zoomScale/4)+60)-5;
    
    [self addBeginEndView:@"End" f1:a f2:b];
    [self.delegate endFieldText:place];
}
#pragma mark - 查询该站点的信息
-(void)infoStation
{
    InfoViewController *info=[[InfoViewController alloc]init];
    info.place=place;
    info.arrayLine=arrayLine;
    
    infoArray=[SqliteDao findEntranceByStationId:place];
    info.infoArray=infoArray;
    
    arrayStartAndEndTime=[SqliteDao findStartAndEndTime:place];
    info.arrayStartAndEndTime=arrayStartAndEndTime;
    
    [[self viewController] presentViewController:info animated:YES completion:^{
        
    }];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

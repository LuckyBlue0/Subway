//
//  GoHomeViewController.m
//  SubWay
//
//  Created by Gary on 14-4-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "GoHomeViewController.h"

extern NSMutableArray *allStationArray;

@interface GoHomeViewController ()

@end

@implementation GoHomeViewController
@synthesize detailLabel,startTimeLabel,endTimeLabel;
@synthesize startView,endView,sc;
@synthesize startKuangImage1,startPlace1;
@synthesize startKuangImage2,endPlace2;
@synthesize array;
@synthesize price;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    d=[Dijkstra new];
    // Do any additional setup after loading the view from its nib.
    [_titleView setBackgroundColor:[UIColor colorWithRed:0.22 green:0.7 blue:0.76 alpha:0.9]];
    _StartEndVuew.layer.borderWidth = 1;
    _StartEndVuew.layer.borderColor = [[UIColor colorWithRed:0.22 green:0.7 blue:0.76 alpha:0.9] CGColor];
    _StartEndVuew.layer.cornerRadius =5;
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    _endLabel.text=[defaults objectForKey:@"home"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeTextAction:) name:@"homeText" object:nil];//家的位置改变通知
    
    
    detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,170,self.view.frame.size.width-40,20)];
    detailLabel.backgroundColor=[UIColor clearColor];
    detailLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:detailLabel];
#pragma mark -scrollview
    {
        sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0,190, self.view.frame.size.width, self.view.frame.size.height-190)];
        sc.showsVerticalScrollIndicator=NO;
        [sc setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:sc];
    }
    [self addView];
    
    if([CLLocationManager locationServicesEnabled])
    {
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位未开启" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
            [sc setHidden:YES];
            detailLabel.frame=CGRectMake(20,220,self.view.frame.size.width-40,30);
            detailLabel.text=@"没有查询结果";
            detailLabel.textAlignment=NSTextAlignmentCenter;
        }
        else{
            locationManager = [[CLLocationManager alloc]init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            locationManager.distanceFilter = 100.0f;
            homeFlag=@"无";
            [locationManager startUpdatingLocation];
        }
    }
    else{
        NSLog(@"定位未开启。。。。。。。。。");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位未开启" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
        [sc setHidden:YES];
        detailLabel.frame=CGRectMake(20,220,self.view.frame.size.width-40,30);
        detailLabel.text=@"没有查询结果";
        detailLabel.textAlignment=NSTextAlignmentCenter;
    }
    [sc setHidden:YES];
}
-(void)addView
{
    startTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,0, 200, 20)];
    startTimeLabel.text=@"首末班次 xx:xx";
    startTimeLabel.font=[UIFont systemFontOfSize:13];
    [sc addSubview:startTimeLabel];
    
    endTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,720, 200, 20)];
    endTimeLabel.text=@"首末班次 xx:xx";
    endTimeLabel.font=[UIFont systemFontOfSize:13];
    [sc addSubview:endTimeLabel];
    
    
    startView=[[UIView alloc]initWithFrame:CGRectMake(0,25, self.view.frame.size.width,20)];
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
    startPlace1.text=_startLabel.text;
    [startView addSubview:startPlace1];
    
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
    imageV.frame=CGRectMake(startView.frame.size.width-25,0, 20, 20);
    [startView addSubview:imageV];
    
    endView=[[UIView alloc]initWithFrame:CGRectMake(0,sc.frame.size.height-25, self.view.frame.size.width,20)];
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
    endPlace2.text=_endLabel.text;
    [endView addSubview:endPlace2];
    
    UIImageView *imageV1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_forward"]];
    imageV1.frame=CGRectMake(endView.frame.size.width-25,0, 20, 20);
    [endView addSubview:imageV1];
    
}
//通知
-(void)homeTextAction:(NSNotification *)nof
{
    _endLabel.text=[nof object];
    [[NSUserDefaults standardUserDefaults] setObject:[nof object] forKey:@"home"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self query];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark-locationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    NSString *lat = [[NSString alloc] initWithFormat:@"%f",[newLocation coordinate].latitude];
    NSString *lon = [[NSString alloc] initWithFormat:@"%f",[newLocation coordinate].longitude];
    
    CLGeocoder *myGecoder = [[CLGeocoder alloc] init];
    [myGecoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error == nil && [placemarks count]>0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             NSLog(@"Country = %@", placemark.country);
             NSLog(@"administrativeArea = %@",placemark.administrativeArea);
             NSLog(@"locality = %@", placemark.locality);
             NSLog(@"subLocality=%@",placemark.subLocality);
             NSLog(@"thoroughfare = %@", placemark.thoroughfare);
             NSLog(@"subThoroughfare=%@",placemark.subThoroughfare);
             
         }
         else if(error==nil && [placemarks count]==0)
         {
             NSLog(@"No results were returned.");
         }
         else if(error != nil)
         {
             NSLog(@"An error occurred = %@",error);
         }
     }];
    
    //更新定位信息方法
    NSLog(@"定位 经度%@,纬度%@",lat,lon);
    [locationManager stopUpdatingLocation];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:lat,lon,nil];

    NSMutableDictionary *minDistanceDic=[[NSMutableDictionary alloc]init];
    
    for (int i=0; i<[allStationArray count]; i++)
    {
        if([[[allStationArray objectAtIndex:i] objectForKey:@"ZOPEN"]floatValue]==1)
        {
            //查询数据库得到
            float a= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLATITUDE"] floatValue];
            float b= [[[allStationArray objectAtIndex:i] objectForKey:@"ZLONGITUDE"] floatValue];
            //定位得出的
            float c=[[[dict allValues] objectAtIndex:0] floatValue];
            float d1=[[[dict allKeys] objectAtIndex:0] floatValue];
            
            CLLocation *location=[[CLLocation alloc] initWithLatitude:a longitude:b];
            CLLocationDistance distance=[location distanceFromLocation:[[CLLocation alloc] initWithLatitude:c longitude:d1]];
            
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
            if([homeFlag  isEqualToString:@"家"])
            {
                 _startLabel.text=key;
                 _endLabel.text=key;
                [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"home"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self query];
                [sc setHidden:NO];
            }
            else
            {
                _startLabel.text=key;
                [self query];
                [sc setHidden:NO];
            }
        }
    }];
    
    if([_startLabel.text isEqualToString:_endLabel.text]){
         [sc setHidden:YES];
        detailLabel.frame=CGRectMake(20,220,self.view.frame.size.width-40,30);
        detailLabel.text=@"没有查询结果";
        detailLabel.textAlignment=NSTextAlignmentCenter;
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    //定位失败
    [locationManager stopUpdatingLocation];
}

-(void)query
{
    d->StrBegin=_startLabel.text;
    d->StrEnd=_endLabel.text;
    [d BuildGraph];
    
    sortPassStationArray=[[NSMutableArray alloc]init];
    for (NSString *str in [d.passStationArray reverseObjectEnumerator]) {
        [sortPassStationArray addObject:str];
    }
    if([sortPassStationArray count]>0){
        [sortPassStationArray removeObjectAtIndex:0];
    }
    
    [self getPlaces:sortPassStationArray];
    detailLabel.frame=CGRectMake(20,170,self.view.frame.size.width-40,20);
    detailLabel.textAlignment=NSTextAlignmentLeft;
    [sc setHidden:NO];
}

- (IBAction)settingAction:(id)sender {
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"修改家的位置" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"当前位置设为“家" otherButtonTitles:@"自定义",@"清空设置", nil];
    [action showInView:self.view];
}

- (IBAction)moveAction:(id)sender
{
    NSString *start=_startLabel.text;
    NSString *end=_endLabel.text;
    
    _startLabel.text=end;
    _endLabel.text=start;
    
    if([_startLabel.text isEqualToString:_endLabel.text]){
        [sc setHidden:YES];
        detailLabel.frame=CGRectMake(20,220,self.view.frame.size.width-40,30);
        detailLabel.text=@"没有查询结果";
        detailLabel.textAlignment=NSTextAlignmentCenter;
    }
    else if(_startLabel.text.length>0&&_endLabel.text.length>0)
    {
        [self query];
    }
}
#pragma mark actionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if([CLLocationManager locationServicesEnabled])
        {
            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位未开启" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            else
            {
                homeFlag=@"家";
                [locationManager startUpdatingLocation];            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位未开启" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    else if (buttonIndex==1)
    {
        SelectHomeViewController *home=[[SelectHomeViewController alloc]initWithNibName:IS_IPHONE5?@"SelectHomeViewController_4":@"SelectHomeViewController_3.5" bundle:nil];
        home.flag=@"1";
        [self presentModalViewController:home animated:YES];
    }
    else if (buttonIndex==2)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此操作会将原有的设置和数据进行清空，确定么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
#pragma mark -alert delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"home"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view.superview addSubview:HUD];
        HUD.labelText = @"清空成功";
        HUD.mode = MBProgressHUDModeText;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1.5);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark -列出路线
-(void)getPlaces:(NSMutableArray *)palcesLineArray
{
    for (UIView *s in [sc subviews]) {
        [s removeFromSuperview];
    }
    
    [self addView];
    price=[Dijkstra price:_startLabel.text end:_endLabel.text array:palcesLineArray];//计算价格已经加上起点和终点了  顺序不能换
    
    changeArray1=[Dijkstra transLine:palcesLineArray s:_startLabel.text s1:_endLabel.text];

    [Dijkstra getLineAndColor:_startLabel.text str:_endLabel.text startV:startView endV:endView imageV:startKuangImage1 imageV1:startKuangImage2];
    UITapGestureRecognizer *startTapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
    startView.userInteractionEnabled=YES;
    [startView addGestureRecognizer:startTapGestureRecognizer];
    
    UITapGestureRecognizer *endTapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTap:)];
    endView.userInteractionEnabled=YES;
    [endView addGestureRecognizer:endTapGestureRecognizer];
    
    
    NSMutableArray *changeDirectionLineArray=[Dijkstra changeLineDirection:changeArray1 passStation:palcesLineArray str:_endLabel.text];
    
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
    
    
    [palcesLineArray removeObject:_startLabel.text];
    [palcesLineArray removeObject:_endLabel.text];
    

    direction=[Dijkstra direction:palcesLineArray str:_startLabel.text str1:_endLabel.text];
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
                    
                    UILabel *directoinLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(175,20,120, 20)];
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
//                    NSMutableArray *startArray=[SqliteDao findLineByStationId:[changeArray1 objectAtIndex:j]];
//                    NSString *color=[[startArray objectAtIndex:0]objectForKey:@"ZCOLOR"];
                    
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
        endView.frame=CGRectMake(0, sc.frame.origin.y+((palcesLineArray.count-1)*40)-55,CGRectGetWidth(self.view.frame), 20);
    else
        endView.frame=CGRectMake(0,95,CGRectGetWidth(self.view.frame), 20);
    
    endTimeLabel.frame=CGRectMake(20, endView.frame.origin.y+25,CGRectGetWidth(self.view.frame), 20);
    [sc setContentSize:CGSizeMake(0,((palcesLineArray.count-1)*40)+185)];
    
    if(changeArray1.count==0)
        detailLabel.text=[NSString stringWithFormat:@"%i站\t\t\t%@元",d->length-1,price];
    else
        detailLabel.text=[NSString stringWithFormat:@"%i站，换乘%i次\t\t\t%@元",d->length-1,changeArray1.count,price];
    
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
        dictTime1=[SqliteDao findStartAndEndTime1:_endLabel.text str:changeDirectionLineArray[changeDirectionLineArray.count-1][1]];
    else
        dictTime1=[SqliteDao findStartAndEndTime1:_endLabel.text str:direction];
    
    if(dictTime1.count==0)
    {
        NSMutableArray *arrayTime1=[SqliteDao findStartAndEndTime:_endLabel.text];
        if(arrayTime1.count==1)
            endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:0] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:0] objectForKey:@"ZENDTIME"]];
        if(arrayTime1.count>1)
            endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[[arrayTime1 objectAtIndex:1] objectForKey:@"ZSTARTTIME"],[[arrayTime1 objectAtIndex:1] objectForKey:@"ZENDTIME"]];
    }
    else
        endTimeLabel.text=[NSString stringWithFormat:@"首末班次：%@/%@",[dictTime1 objectForKey:@"ZSTARTTIME"],[dictTime1 objectForKey:@"ZENDTIME"]];
    
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
            
            [self  presentViewController:info animated:YES completion:^{
                
            }];
        }
    }
}

@end

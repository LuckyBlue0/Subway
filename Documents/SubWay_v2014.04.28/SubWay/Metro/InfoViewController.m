//
//  InfoViewController.m
//  SubWay
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
{
    UIImageView *exitImage;
    UIImageView *serveImage;
}
@end

@implementation InfoViewController
@synthesize topView,titleLabel,backBtn;
@synthesize tagV,placeLabel,showLabel,
time1Label,time2Label,direction1Label,direction2Label;

@synthesize line;
@synthesize exitInfoBtn,serveInfoBtn,
exitInfoLabel,serveInfoLabel;
@synthesize line1;

@synthesize place;
@synthesize table;
@synthesize infoArray,serveDeviceDict,iconArray;
@synthesize arrayLine;
@synthesize flag;
@synthesize arrayStartAndEndTime;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
#pragma mark -topView
    {
        topView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,60)];
        [topView setBackgroundColor:[UIColor colorWithRed:0.22 green:0.7 blue:0.76 alpha:1]];
        [self.view addSubview:topView];
    }
#pragma mark-backBtn
    {
        backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame=CGRectMake(10,20,30,30);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"iPhone_btn_back_0_0"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }
#pragma mark-title
    {
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 30)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.font=[UIFont boldSystemFontOfSize:18];
        [self.view addSubview:titleLabel];
    }
#pragma mark -placeLabel
    {
        tagV=[[PlacesTag alloc]initWithFrame:CGRectMake(0,68,120,30)];
        tagV.backgroundColor=[UIColor blueColor];
        [self.view addSubview:tagV];
        
        placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,110,30)];
        placeLabel.text=place;
        placeLabel.textAlignment=NSTextAlignmentCenter;
        placeLabel.font=[UIFont boldSystemFontOfSize:18];
        placeLabel.backgroundColor=[UIColor clearColor];
        [tagV addSubview:placeLabel];
    }
    showLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,100,self.view.frame.size.width-20, 20)];
    showLabel.text=@"首末班车时间";
    showLabel.backgroundColor=[UIColor clearColor];
    showLabel.font=[UIFont boldSystemFontOfSize:13];
    showLabel.textColor=[UIColor colorWithRed:0.22 green:0.38 blue:0.43 alpha:1];
    [self.view addSubview:showLabel];
    
#pragma mark-方向 和 起始时间
{
    direction1Label=[[UILabel alloc]initWithFrame:CGRectMake(20,120,self.view.frame.size.width-185, 20)];
    direction1Label.backgroundColor=[UIColor clearColor];
        
    NSMutableDictionary *dict=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:0] objectForKey:@"ZENDSTATION"]];
    NSString *endStation=[dict objectForKey:@"ZNAME"];
        
    direction1Label.text=[NSString stringWithFormat:@"开往%@方向",endStation];
    direction1Label.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:direction1Label];
    
    time1Label=[[UILabel alloc]initWithFrame:CGRectMake(160,120,self.view.frame.size.width-160, 20)];
    time1Label.backgroundColor=[UIColor clearColor];
    time1Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:0] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:0] objectForKey:@"ZENDTIME"]];
    time1Label.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:time1Label];
    
    if (arrayStartAndEndTime.count>1)
    {
        direction2Label=[[UILabel alloc]initWithFrame:CGRectMake(20,140,self.view.frame.size.width-185, 20)];
        time2Label=[[UILabel alloc]initWithFrame:CGRectMake(160,140,self.view.frame.size.width-160, 20)];
        time2Label.text=@"xx:xx/xx:xx";
        direction2Label.backgroundColor=[UIColor clearColor];
        direction2Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:direction2Label];
        
        NSMutableDictionary *dict1=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:1] objectForKey:@"ZENDSTATION"]];
        NSString *endStation1=[dict1 objectForKey:@"ZNAME"];
        direction2Label.text=[NSString stringWithFormat:@"开往%@方向",endStation1];
        
        time2Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:1] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:1] objectForKey:@"ZENDTIME"]];
        
        time2Label.backgroundColor=[UIColor clearColor];
        time2Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:time2Label];
    }
    
}
#pragma mark-existbtn,serveBtn
    {
        line=[[UIView alloc]initWithFrame:CGRectMake(0,170,self.view.frame.size.width,1)];
        line.backgroundColor=[UIColor colorWithRed:0.97 green:0.73 blue:0.22 alpha:1];
        [self.view addSubview:line];
        
        
        exitInfoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        exitInfoBtn.frame=CGRectMake(10,175,120,40);
        [exitInfoBtn addTarget:self action:@selector(exitInfoBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:exitInfoBtn];
        
        exitImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_ic_0_1"]];
        [exitInfoBtn addSubview:exitImage];
        
        
        
        exitInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(exitInfoBtn.frame.origin.x+30,177,100, 30)];
        exitInfoLabel.text=@"出口信息";
        exitInfoLabel.font=[UIFont boldSystemFontOfSize:16];
        exitInfoLabel.backgroundColor=[UIColor clearColor];
        exitInfoLabel.textColor=[UIColor colorWithRed:0.07 green:0.36 blue:0.38 alpha:1];
        [self.view addSubview:exitInfoLabel];
        
        
        serveInfoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        serveInfoBtn.frame=CGRectMake(190,175,120,40);
        [serveInfoBtn addTarget:self action:@selector(serveInfoBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [serveInfoBtn setSelected:YES];
        [self.view addSubview:serveInfoBtn];
        
        serveImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPhone_btn_ic_1_0"]];
        [serveInfoBtn addSubview:serveImage];
        
        
        serveInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(serveInfoBtn.frame.origin.x+30,177,100, 30)];
        serveInfoLabel.text=@"服务设施";
        serveInfoLabel.font=[UIFont boldSystemFontOfSize:16];
        serveInfoLabel.backgroundColor=[UIColor clearColor];
        serveInfoLabel.textColor=[UIColor colorWithRed:0.07 green:0.36 blue:0.38 alpha:1];
        [self.view addSubview:serveInfoLabel];
        
        
        line1=[[UIView alloc]initWithFrame:CGRectMake(0,212,self.view.frame.size.width,1)];
        line1.backgroundColor=[UIColor colorWithRed:0.97 green:0.73 blue:0.22 alpha:1];
        [self.view addSubview:line1];
    }
#pragma mark-table
    {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0,215,self.view.frame.size.width, self.view.frame.size.height-215) style:UITableViewStylePlain];
        table.separatorStyle=UITableViewCellSeparatorStyleNone;
        table.delegate=self;
        table.dataSource=self;
        [self.view addSubview:table];
    }
    
    if (arrayStartAndEndTime.count>2)
    {
        UILabel *direction3Label=[[UILabel alloc]initWithFrame:CGRectMake(20,160,self.view.frame.size.width-185, 20)];
        UILabel *time3Label=[[UILabel alloc]initWithFrame:CGRectMake(160,160,self.view.frame.size.width-160, 20)];
        time3Label.text=@"xx:xx/xx:xx";
        direction3Label.backgroundColor=[UIColor clearColor];
        direction3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:direction3Label];
        
        NSMutableDictionary *dict1=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:2] objectForKey:@"ZENDSTATION"]];
        NSString *endStation1=[dict1 objectForKey:@"ZNAME"];
        direction3Label.text=[NSString stringWithFormat:@"开往%@方向",endStation1];
        
        time3Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:2] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:2] objectForKey:@"ZENDTIME"]];
        
        time3Label.backgroundColor=[UIColor clearColor];
        time3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:time3Label];
        
        line.frame=CGRectMake(0,190,self.view.frame.size.width,1);
        exitInfoBtn.frame=CGRectMake(10,195,120,40);
        exitInfoLabel.frame=CGRectMake(exitInfoBtn.frame.origin.x+30,197,100, 30);
        serveInfoBtn.frame=CGRectMake(190,195,120,40);
        serveInfoLabel.frame=CGRectMake(serveInfoBtn.frame.origin.x+30,197,100, 30);
        line1.frame=CGRectMake(0,230,self.view.frame.size.width,1);
        table.frame=CGRectMake(0,231,self.view.frame.size.width, self.view.frame.size.height-231);
    }
    if (arrayStartAndEndTime.count>3)
    {
        UILabel *direction3Label=[[UILabel alloc]initWithFrame:CGRectMake(20,180,self.view.frame.size.width-185, 20)];
        UILabel *time3Label=[[UILabel alloc]initWithFrame:CGRectMake(160,180,self.view.frame.size.width-160, 20)];
        time3Label.text=@"xx:xx/xx:xx";
        direction3Label.backgroundColor=[UIColor clearColor];
        direction3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:direction3Label];
        
        NSMutableDictionary *dict1=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:3] objectForKey:@"ZENDSTATION"]];
        NSString *endStation1=[dict1 objectForKey:@"ZNAME"];
        direction3Label.text=[NSString stringWithFormat:@"开往%@方向",endStation1];
        
        time3Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:3] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:3] objectForKey:@"ZENDTIME"]];
        
        time3Label.backgroundColor=[UIColor clearColor];
        time3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:time3Label];
        
        line.frame=CGRectMake(0,210,self.view.frame.size.width,1);
        exitInfoBtn.frame=CGRectMake(10,215,120,40);
        exitInfoLabel.frame=CGRectMake(exitInfoBtn.frame.origin.x+30,217,100, 30);
        serveInfoBtn.frame=CGRectMake(190,215,120,40);
        serveInfoLabel.frame=CGRectMake(serveInfoBtn.frame.origin.x+30,217,100, 30);
        line1.frame=CGRectMake(0,250,self.view.frame.size.width,1);
        table.frame=CGRectMake(0,251,self.view.frame.size.width, self.view.frame.size.height-251);
    }
    if(arrayStartAndEndTime.count>4)
    {
        UILabel *direction3Label=[[UILabel alloc]initWithFrame:CGRectMake(20,200,self.view.frame.size.width-185, 20)];
        UILabel *time3Label=[[UILabel alloc]initWithFrame:CGRectMake(160,200,self.view.frame.size.width-160, 20)];
        time3Label.text=@"xx:xx/xx:xx";
        direction3Label.backgroundColor=[UIColor clearColor];
        direction3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:direction3Label];
        
        NSMutableDictionary *dict1=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:4] objectForKey:@"ZENDSTATION"]];
        NSString *endStation1=[dict1 objectForKey:@"ZNAME"];
        direction3Label.text=[NSString stringWithFormat:@"开往%@方向",endStation1];
        
        time3Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:4] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:4] objectForKey:@"ZENDTIME"]];
        
        time3Label.backgroundColor=[UIColor clearColor];
        time3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:time3Label];
        
        line.frame=CGRectMake(0,230,self.view.frame.size.width,1);
        exitInfoBtn.frame=CGRectMake(10,235,120,40);
        exitInfoLabel.frame=CGRectMake(exitInfoBtn.frame.origin.x+30,237,100, 30);
        serveInfoBtn.frame=CGRectMake(190,235,120,40);
        serveInfoLabel.frame=CGRectMake(serveInfoBtn.frame.origin.x+30,237,100, 30);
        line1.frame=CGRectMake(0,270,self.view.frame.size.width,1);
        table.frame=CGRectMake(0,271,self.view.frame.size.width, self.view.frame.size.height-271);
    }
    if(arrayStartAndEndTime.count>5)
    {
        UILabel *direction3Label=[[UILabel alloc]initWithFrame:CGRectMake(20,220,self.view.frame.size.width-185, 20)];
        UILabel *time3Label=[[UILabel alloc]initWithFrame:CGRectMake(160,220,self.view.frame.size.width-160, 20)];
        time3Label.text=@"xx:xx/xx:xx";
        direction3Label.backgroundColor=[UIColor clearColor];
        direction3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:direction3Label];
        
        NSMutableDictionary *dict1=[SqliteDao findPlaceByEndStation:[[arrayStartAndEndTime objectAtIndex:5] objectForKey:@"ZENDSTATION"]];
        NSString *endStation1=[dict1 objectForKey:@"ZNAME"];
        direction3Label.text=[NSString stringWithFormat:@"开往%@方向",endStation1];
        
        time3Label.text=[NSString stringWithFormat:@"%@/%@",[[arrayStartAndEndTime objectAtIndex:5] objectForKey:@"ZSTARTTIME"],[[arrayStartAndEndTime objectAtIndex:4] objectForKey:@"ZENDTIME"]];
        
        time3Label.backgroundColor=[UIColor clearColor];
        time3Label.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:time3Label];
        
        line.frame=CGRectMake(0,250,self.view.frame.size.width,1);
        exitInfoBtn.frame=CGRectMake(10,255,120,40);
        exitInfoLabel.frame=CGRectMake(exitInfoBtn.frame.origin.x+30,257,100, 30);
        serveInfoBtn.frame=CGRectMake(190,255,120,40);
        serveInfoLabel.frame=CGRectMake(serveInfoBtn.frame.origin.x+30,257,100, 30);
        line1.frame=CGRectMake(0,290,self.view.frame.size.width,1);
        table.frame=CGRectMake(0,291,self.view.frame.size.width, self.view.frame.size.height-291);
    }
    
    
    
    
    flag=0;//标记是出口信息 还是 服务设施
#pragma mark -设置tagView的颜色和标题
    if(arrayLine.count>0)
    {
        NSString *lineStr=[[arrayLine objectAtIndex:0]objectForKey:@"ZLINENAME"];
        titleLabel.text=[NSString stringWithFormat:@"%@车站信息",lineStr];
        
        NSString *color=[[arrayLine objectAtIndex:0]objectForKey:@"ZCOLOR"];
        color=[color substringWithRange:NSMakeRange(5, color.length-6)];
        NSArray *colorArray=[color componentsSeparatedByString:@","];
        tagV.backgroundColor=RGB([colorArray[0] floatValue], [colorArray[1] floatValue], [colorArray[2] floatValue], [colorArray[3] floatValue]);
    }
    if(arrayLine.count>1)
    {
        NSString *lineStr=[[arrayLine objectAtIndex:0]objectForKey:@"ZLINENAME"];
        NSString *lineStr1=[[arrayLine objectAtIndex:1]objectForKey:@"ZLINENAME"];
        titleLabel.text=[NSString stringWithFormat:@"%@、%@车站信息",lineStr,lineStr1];
        
        NSString *color=[[arrayLine objectAtIndex:0]objectForKey:@"ZCOLOR"];
        color=[color substringWithRange:NSMakeRange(5, color.length-6)];
        NSArray *colorArray=[color componentsSeparatedByString:@","];
        
        tagV.backgroundColor=RGB([colorArray[0] floatValue], [colorArray[1] floatValue], [colorArray[2] floatValue], [colorArray[3] floatValue]);
    }
    iconArray=[[NSMutableArray alloc]initWithObjects:@"iPhone_ic_1",@"iPhone_ic_2",@"iPhone_ic_3",@"iPhone_ic_4",@"iPhone_ic_5", nil];
    
    NSMutableArray *categoryArray=[[NSMutableArray alloc]init];
    serveDeviceDict=[[NSMutableDictionary alloc]init];
    infoArray=[SqliteDao findEntranceByStationId:place];
#pragma mark -把出口关闭的从数组中移除
    for (int i=0; i<[infoArray count]; i++)
    {
        if([[[infoArray objectAtIndex:i] objectForKey:@"ZOPEN"] integerValue]==0)
            [infoArray removeObjectAtIndex:i];
    }
#pragma mark -查出并且分类显示设施
    NSMutableArray *deviceArray=[SqliteDao findDeviceByStationId:place];
    for (int i=0; i<[deviceArray count]; i++)
    {
        NSMutableDictionary *d=[SqliteDao findCategoryByCategoryId:[[deviceArray objectAtIndex:i] objectForKey:@"ZCATEGORY"]];
        
        [categoryArray addObject:[d objectForKey:@"ZNAME"]];
        
        [[deviceArray objectAtIndex:i] setObject:[d objectForKey:@"ZNAME"] forKey:@"DZNAME"];
        
    }
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    for (NSString *s in categoryArray)
    {
        if(![array containsObject:s])
        {
            [array addObject:s];
        }
    }
    
    for (NSString *str in array)
    {
        
        NSMutableString *ss=[[NSMutableString alloc]init];
        for (NSMutableDictionary *s in deviceArray)
        {
            if([str isEqualToString:[s objectForKey:@"DZNAME"]])
            {
                [ss appendString:[s objectForKey:@"ZNAME"]];
                [ss appendFormat:@" "];
                
            }
        }
        [serveDeviceDict setObject:ss forKey:str];
    }
//    dispatch_queue_t queue = dispatch_queue_create("com.gary.subway", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        
//        });
//    dispatch_async(queue, ^{
//       
//    });
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)exitInfoBtnAction
{
    exitImage.image=[UIImage imageNamed:@"iPhone_btn_ic_0_1"];
    serveImage.image=[UIImage imageNamed:@"iPhone_btn_ic_1_0"];
    flag=0;
    [table reloadData];
    
}
-(void)serveInfoBtnAction
{
    serveImage.image=[UIImage imageNamed:@"iPhone_btn_ic_1_1"];
    exitImage.image=[UIImage imageNamed:@"iPhone_btn_ic_0_0"];
    flag=1;
    [table reloadData];

}
#pragma mark -table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return flag==0?[infoArray count]:[[serveDeviceDict allKeys] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(flag==0)
    {
        static NSString *CustomCell = @"EntranceCell";
        UINib *nib = [UINib nibWithNibName:@"EntranceCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCell];
        EntranceCell *cell= [tableView dequeueReusableCellWithIdentifier:CustomCell];
    
        NSString *left=[[infoArray objectAtIndex:indexPath.row]objectForKey:@"ZLETTER"];
        NSString *number=[[infoArray objectAtIndex:indexPath.row]objectForKey:@"ZNUMBER"];
        cell.letter.text=[NSString stringWithFormat:@"%@%@",left,number];
        cell.detail.text=[[infoArray objectAtIndex:indexPath.row] objectForKey:@"ZNAME"];

        
        cell.detail.lineBreakMode=UILineBreakModeWordWrap;
        cell.detail.numberOfLines=0;
        return cell;
    }
    else
    {
        static NSString *CustomCell = @"DeviceCell";
        UINib *nib = [UINib nibWithNibName:@"DeviceCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCell];
        DeviceCell *cell= [tableView dequeueReusableCellWithIdentifier:CustomCell];
        
        cell.category.text=[[serveDeviceDict allKeys] objectAtIndex:indexPath.row];
        if ([cell.category.text isEqualToString:@"羊城通充值点"]) {
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:0]];
        }
        else if ([cell.category.text isEqualToString:@"专用电梯"])
        {
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:1]];
        }
        else if ([cell.category.text isEqualToString:@"M-Touch"])
        {
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:3]];
        }
        else if ([cell.category.text isEqualToString:@"公厕"])
        {
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:2]];
        }
        else if ([cell.category.text isEqualToString:@"盲道"])
        {
            //cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:1]];
        }
        else if ([cell.category.text isEqualToString:@"自动照相机"])
        {
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:4]];
        }
        
        cell.detail.text=[[serveDeviceDict allValues] objectAtIndex:indexPath.row];
        cell.detail.lineBreakMode=UILineBreakModeWordWrap;
        cell.detail.numberOfLines=0;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return flag==0?60:80;
}
@end

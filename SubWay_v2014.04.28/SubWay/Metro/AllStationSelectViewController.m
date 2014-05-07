//
//  AllStationSelectViewController.m
//  SubWay
//
//  Created by Glex on 14-4-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AllStationSelectViewController.h"
#import "SqliteDao.h"
extern NSMutableArray *allStationArray;

@interface AllStationSelectViewController ()

@end

@implementation AllStationSelectViewController
@synthesize flagStartEndText;
@synthesize letterArray,pinyinStationArray;
@synthesize letterDic;

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
    // Do any additional setup after loading the view from its nib.
    [_titleView setBackgroundColor:[UIColor colorWithRed:0.22 green:0.7 blue:0.76 alpha:0.9]];
    letterArray=@[@"B",@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    letterDic=[[NSMutableDictionary alloc] init];
    
    for (NSString *s in letterArray) {
        pinyinStationArray=[SqliteDao findPlaceByPinyin:s];
        [letterDic setObject:pinyinStationArray forKey:s];
    }
    
//    self.table.sectionIndexColor = [UIColor blueColor];
//    self.table.sectionIndexTrackingBackgroundColor = [UIColor grayColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [letterDic allKeys].count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSMutableArray *)[letterDic objectForKey:[letterArray objectAtIndex:section]]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *TableSampleIdentifier =[NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:TableSampleIdentifier];
    }
    NSString *station= [[[letterDic objectForKey:[letterArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"ZNAME"];
    NSDictionary *dict=[SqliteDao findStationDetailInfo:station];
    if([[dict objectForKey:@"ZOPEN"] integerValue]==0)
    {
        cell.userInteractionEnabled=NO;
        cell.textLabel.textColor=[UIColor grayColor];
        cell.detailTextLabel.text=@"(未开通)";
    }
    cell.textLabel.text=station;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d=[[NSDictionary alloc]initWithObjectsAndKeys:[[[letterDic objectForKey:[letterArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"ZNAME"],flagStartEndText, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedStation" object:d];
    
    [self backAction:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedStationRoute" object:nil];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return letterArray;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [letterArray objectAtIndex:section];
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count=0;
    for (NSString *s in letterArray)
    {
        if([s isEqualToString:title])
        {
            return count;
        }
        count++;
    }
    return 0;
}
- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}
@end
//
//  MainViewController.h
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "BottomView.h"
#import "ToolsView.h"
#import "DisplayView.h"
#import "FindMetro.h"
#import "SqliteDao.h"
#import "QueryView.h"
#import <MapKit/MapKit.h>
#import "GetPlacesDelegate.h"
#import "Dijkstra.h"
#import "GoWorkViewController.h"
#import "GoHomeViewController.h"
#import "SelectHomeViewController.h"
#import "SelectCompanyViewController.h"

@interface MainViewController : UIViewController
<ZoomDelegate,TouchBottomDelegate,
StartAndEndTextValueDelegate,CLLocationManagerDelegate,
GetPlacesDelegate,UIActionSheetDelegate>
{
    float scale;//放大放小的参数
    DisplayView *display;
    TopView *topView;
    BottomView *bottomView;
    ToolsView *toolsView;
    QueryView *query;
    
    FindMetro *metro;
    StationPinyin *pinyin;
    
    CLLocationManager *locationManager;
    
    NSMutableArray *sortPassStationArray;
    NSMutableArray *changeArray1;
    Dijkstra *d;
}
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)UIActionSheet *actionSheet1;
@property(nonatomic,retain)NSString *homeCompany;

@property(nonatomic,assign)id<GetPlacesDelegate>delegate;
@end

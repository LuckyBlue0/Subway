//
//  SelectCompanyViewController.h
//  SubWay
//
//  Created by Gary on 14-4-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "APIKey.h"
#import<SystemConfiguration/SCNetworkReachability.h>
#import "Constants.h"

@interface SelectCompanyViewController : UIViewController
<CLLocationManagerDelegate,
MAMapViewDelegate,AMapSearchDelegate,
UIGestureRecognizerDelegate,AMapSearchDelegate,MAMapViewDelegate,UIAlertViewDelegate>
{
    CLLocationManager *locationManager;
    MAMapView *maMapView;
    AMapSearchAPI *searchAPI;
    MAPointAnnotation *userLongPressAnnotation;
    MAPointAnnotation *homeOrWorkAnnotation;
    
    NSMutableDictionary *dict;
}
@property(nonatomic, strong) AMapSearchAPI *searchAPI;

@property(nonatomic,retain)NSString *flag;//标识是从主页面进来的 还是子界面

@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)backAction:(id)sender;
- (IBAction)sureAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *companyText;

@end

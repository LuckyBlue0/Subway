//
//  TopView.h
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllStationSelectViewController.h"
#import "GetPlacesDelegate.h"

@interface TopView : UIView
<UITextFieldDelegate,GetPlacesDelegate>

@property(nonatomic,retain)UIButton *homeBtn;
@property(nonatomic,retain)UIButton *gotoBtn;

@property(nonatomic,retain)UITextField *startText;
@property(nonatomic,retain)UITextField *endText;

@property(nonatomic,assign)id<GetPlacesDelegate>delegate;
@end

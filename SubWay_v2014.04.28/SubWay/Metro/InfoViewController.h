//
//  InfoViewController.h
//  SubWay
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqliteDao.h"
#import "PlacesTag.h"
#import "EntranceCell.h"
#import "DeviceCell.h"

@interface InfoViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UIView *topView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *backBtn;

@property(nonatomic,retain)PlacesTag *tagV;
@property(nonatomic,retain)UILabel *placeLabel;
@property(nonatomic,retain)UILabel *showLabel;

@property(nonatomic,retain)UILabel *direction1Label;
@property(nonatomic,retain)UILabel *direction2Label;
@property(nonatomic,retain)UILabel *time1Label;
@property(nonatomic,retain)UILabel *time2Label;

@property(nonatomic,retain)UIView *line;
@property(nonatomic,retain)UIButton *exitInfoBtn;
@property(nonatomic,retain)UIButton *serveInfoBtn;
@property(nonatomic,retain)UILabel *exitInfoLabel;
@property(nonatomic,retain)UILabel *serveInfoLabel;
@property(nonatomic,retain)UIView *line1;

@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)NSMutableArray *infoArray;
@property(nonatomic,retain)NSMutableDictionary *serveDeviceDict;
@property(nonatomic,retain)NSMutableArray *iconArray;
//参数
@property(nonatomic,assign)int flag;
@property(nonatomic,retain)NSString *place;

@property(nonatomic,retain)NSMutableArray *arrayLine;
@property(nonatomic,retain)NSMutableArray *arrayStartAndEndTime;
@end

//
//  StartEndView.h
//  SubWay
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartEndInfoDelegate <NSObject>

@optional
-(void)startStation;
-(void)endStation;
-(void)infoStation;
@end

@interface StartEndView : UIView

@property(nonatomic,retain)UIView *paneView;

@property(nonatomic,retain)UIButton *startBtn;
@property(nonatomic,retain)UIButton *endBtn;
@property(nonatomic,retain)UIButton *infoBtn;
@property(nonatomic,retain)UILabel *lineLabel;

@property(nonatomic,assign)id<StartEndInfoDelegate>delegate;
@end

//
//  ToolsView.h
//  SubWay
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZoomDelegate <NSObject>

@optional
-(void)zoomIn;
-(void)zoomOut;
@end

@interface ToolsView : UIView
@property(nonatomic,retain)UIButton *narrowBtn;
@property(nonatomic,retain)UIButton *wideBtn;
@property(nonatomic,retain)id<ZoomDelegate>delegate;
@end
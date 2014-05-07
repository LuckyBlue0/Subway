//
//  UICellHistory.m
//  KTBrowser
//
//  Created by David on 14-3-12.
//  Copyright (c) 2014年 KOTO Inc. All rights reserved.
//

#import "UICellHistory.h"

@implementation UICellHistory

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = YES;
}

@end

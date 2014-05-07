//
//  EntranceCell.m
//  SubWay
//
//  Created by Glex on 14-4-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "EntranceCell.h"

@implementation EntranceCell
@synthesize letter,imageView,detail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end

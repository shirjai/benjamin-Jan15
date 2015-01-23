//
//  workbookCell.m
//  bw4
//
//  Created by Srinivas on 10/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "workbookCell.h"

@implementation workbookCell

@synthesize wbname = _wbname;
@synthesize desc = _desc;


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

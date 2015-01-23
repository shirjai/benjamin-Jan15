//
//  AllUpdCell.m
//  bw4
//
//  Created by Srinivas on 10/21/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "AllUpdCell.h"

@implementation AllUpdCell

@synthesize UpdBy = _UpdBy;
@synthesize UpdOn = _UpdOn;
@synthesize Comment = _Comment;
@synthesize Txid = _Txid;

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

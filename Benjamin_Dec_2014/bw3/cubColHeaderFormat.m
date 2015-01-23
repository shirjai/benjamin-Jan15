//
//  cubColHeaderFormat.m
//  bw3
//
//  Created by Shirish Jaiswal on 11/18/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "cubColHeaderFormat.h"
#import "CellViewController.h"

const NSString *colHdrViewStr = @"CubColHdr";

@implementation cubColHeaderFormat

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setBackgroundColor:[UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:1.0]];
        
        [self setBackgroundColor:[UIColor brownColor]];
        
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0,5);

    }
    return self;
}


- (void)layoutSubviews
{
    CGRect shadowBounds = CGRectMake(0, -5, self.bounds.size.width, self.bounds.size.height + 5);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowBounds].CGPath;
}


+ (NSString *)kind
{
    return (NSString *)colHdrViewStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end

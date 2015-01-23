//
//  watchCellViewController.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/3/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "watchCellViewController.h"


@implementation watchCellViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cellLabel = [[UILabel alloc] initWithFrame:self.bounds];
           
        self.autoresizesSubviews = YES;
        self.cellLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                       UIViewAutoresizingFlexibleHeight);
        
        //self.cellLabel.font = [UIFont boldSystemFontOfSize:42];
       // self.cellLabel.textAlignment = NSTextAlignmentCenter;
        //self.cellLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.cellLabel];
        
        
        
       // self.cellLabel.frame = CGRectMake(12, 13, 76, 0);
     /*   NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"watchCellView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0]; */
    }
    

    return self;
}

/*
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay]; // force drawRect:
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
} */

/*
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.cellLabel.lineBreakMode=NSLineBreakByWordWrapping;
    self.cellLabel.preferredMaxLayoutWidth = 100;
    [self.cellLabel  setNumberOfLines:4];
    [self.cellLabel sizeToFit];
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

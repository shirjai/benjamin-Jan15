//
//  CellViewController.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/3/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//


#import "CellViewController.h"

/*for new header layout*/
#import "hdrLayout.h"

@implementation CellViewController

@synthesize watchCellValue;


- (void)awakerFromNib {
    
    
    self.contentView.autoresizingMask= (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
}
/*
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
    self.contentView.autoresizingMask= (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        watchCellValue = [[UITextView alloc] initWithFrame:self.bounds];
        //self.watchCellValue.userInteractionEnabled = NO;
        [self addSubview:watchCellValue];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
       // tap.delaysTouchesBegan = YES;
       // tap.numberOfTapsRequired = 2;
        
        [watchCellValue addGestureRecognizer:tap];
       
        //watchCellValue.backgroundColor = [UIColor brownColor];
        
        self.autoresizesSubviews = YES;
       // self.contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
       // self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
        
         //self.watchCellValue.font = [UIFont systemFontOfSize:10];
        
      
        // self.watchCellValue.adjustsFontSizeToFitWidth = YES;
        

        
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

-(void) tapped {
    
    //[self textViewDidBeginEditing:watchCellValue];
    UICollectionView *collectionView = (UICollectionView*)self.superview;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    [collectionView.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    [self.watchCellValue becomeFirstResponder];
    NSLog(@"Back to tapped");
}



/*
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay]; // force drawRect:
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
} */

/*for new header layout*/


- (void)applyLayoutAttributes:(hdrLayout *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc] init];
    }
    self.backgroundView.backgroundColor = layoutAttributes.bkgrndClr;
    self.watchCellValue.font = layoutAttributes.dataFont;
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

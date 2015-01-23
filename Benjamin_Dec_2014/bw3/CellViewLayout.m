//
//  CellViewLayout.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/5/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "CellViewLayout.h"
#import "CellViewController.h"
#import "CuboidViewController.h"


/*for new header layout*/
#import "hdrLayout.h"

static NSString * const cellWatch = @"cellWatch";

@interface CellViewLayout ()

    @property (nonatomic, strong) NSDictionary *layoutInfo;

@end





@implementation CellViewLayout

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];

    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
        self.rowColors = @[
                                  [UIColor lightGrayColor],
                                  [UIColor cyanColor],
                                  ];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.itemSize = CGSizeMake(80.0f, 60.0f);
    self.interItemSpacingY = 0.0f;
    self.numberOfColumns = 4;//[self.collectionView numberOfItemsInSection:[self.collectionView numberOfSections]] ;//3;
}

#pragma mark - Layout

/*for new header layout*/
+ (Class)layoutAttributesClass {
    return [hdrLayout class];
}


- (void)prepareLayout
{
    // NSLog(@"**** Inside prepareLayout ****");
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSInteger item = 0;
        
        for (;item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            hdrLayout *itemAttributes =
            [hdrLayout layoutAttributesForCellWithIndexPath:indexPath];
            
            itemAttributes.frame = [self frameForCellWatchAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
            
        }
        
    }
    
    newLayoutInfo[cellWatch] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attributes = [self layoutAttributesForElementsInRect_old:rect];
    //[self assignBackgroundColorsToPoses:attributes];
    return attributes;
    
}



- (NSMutableArray *)layoutAttributesForElementsInRect_old:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop)
     {
         [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                           hdrLayout *attributes,
                                                           BOOL *innerStop)
          {
              if (CGRectIntersectsRect(rect, attributes.frame))
              {
                  // set the header color.
                  if(indexPath.section == 0 )
                      attributes.bkgrndClr = [UIColor brownColor];
                  [allAttributes addObject:attributes];
              }
          }];
     }];
    
    return allAttributes;
    
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

   return self.layoutInfo[cellWatch][indexPath];
    
}


- (CGSize)collectionViewContentSize
{
   // NSLog(@"**** Inside collectionViewContentSize ****");
   /* NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns)
        rowCount++;
    
    CGFloat height = self.itemInsets.top +
    (rowCount + 2) * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom; */
    
    NSInteger rowCount = [self.collectionView numberOfSections];// / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    //if ([self.collectionView numberOfSections] % self.numberOfColumns)
    //    rowCount++;
    
    CGFloat height = self.itemInsets.top +
    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - Private

- (CGRect)frameForCellWatchAtIndexPath:(NSIndexPath *)indexPath
{
  
    //NSInteger row = indexPath.section / self.numberOfColumns;
   // NSInteger column = indexPath.section % self.numberOfColumns;
     NSInteger row = indexPath.section;
     NSInteger column = indexPath.item;
    float cellWidth = self.itemSize.width;
   // NSLog(@"frameForCellWatchAtIndexPath- section[%ld]item[%ld]",row,column);
   /*
    if (column == 0)
        cellWidth -= 10;
    if (column == 1)
        cellWidth -= 30;
    if (column == 2)
        cellWidth += 18;
    */
    /*
   NSLog(@"***Calculating cell size** ");
    NSLog(@"self.collectionView.bounds.size.width=%f",self.collectionView.bounds.size.width);
    NSLog(@"self.itemInsets.left =%f",self.itemInsets.left);
    NSLog(@"self.itemInsets.right =%f",self.itemInsets.right);
    NSLog(@"self.numberOfColumns=%ld",(long)self.numberOfColumns);
    NSLog(@"self.itemSize.width=%f",cellWidth);
    */
    
    CGFloat spacingX =  self.collectionView.bounds.size.width -
                        self.itemInsets.left -
                        self.itemInsets.right -
                        (self.numberOfColumns * cellWidth);
    
    if (self.numberOfColumns > 1)
        spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (cellWidth + spacingX) * column);

    
    CGFloat originY = floor(self.itemInsets.top +(self.itemSize.height + self.interItemSpacingY) * row);

    
    return CGRectMake(originX, originY, cellWidth, self.itemSize.height);
}

@end











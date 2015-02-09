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

//const CGFloat kScaleBoundLower = 0.5;
//const CGFloat kScaleBoundUpper = 2.0;
//CGFloat cellWidth = 40.0;
//CGFloat cellHt = 35.0;
//int colCnt = 8;


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

    }
    
    return self;
}


- (void)setup
{
    //self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 1.0f);
    self.itemWidth = 40.0;
    self.itemHt = 35.0;
    //self.itemSize = CGSizeMake(_itemWidth, _itemHt);
    self.interItemSpacingY = 0.0f;
    self.numberOfColumns = 8;//[self.collectionView numberOfItemsInSection:[self.collectionView numberOfSections]] ;//3;
   
}

- (void)setCellItemSize :(CGSize)size :(int)colCntParam{

    
    //cellHt = size.height;
    //cellWidth = size.width;
    //colCnt = colCntParam;
    //[self invalidateLayout];
    
    //return size;
    
}


/*

#pragma mark - Layout

//for new header layout
+ (Class)layoutAttributesClass {
    return [hdrLayout class];
}
*/

- (void)prepareLayout
{
    // NSLog(@"**** Inside prepareLayout ****");
    
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 1.0f);
    self.itemSize = CGSizeMake(_itemWidth, _itemHt);
    self.interItemSpacingY = 0.0f;
    //self.numberOfColumns = colCnt;
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSInteger item = 0;
        
        for (;item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            hdrLayout *itemAttributes = [hdrLayout layoutAttributesForCellWithIndexPath:indexPath];
 
            
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
                  if(indexPath.section == 0 ){
                      attributes.bkgrndClr = [UIColor brownColor];
                      attributes.dataFont = [UIFont italicSystemFontOfSize:11];
                     // CellViewController *cell = (CellViewController *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"CuboidCell" forIndexPath:indexPath];
                     // cell.watchCellValue.font = [UIFont boldSystemFontOfSize:12];
                  }
                  else
                      attributes.dataFont = [UIFont systemFontOfSize:10];
                  
                  [allAttributes addObject:attributes];
              }
          }];
     }];
    
    return allAttributes;
    
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{


    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    return attributes;
    //return self.layoutInfo[cellWatch][indexPath];

    
}


/*
#pragma mark - Accessors
- (void)setScale:(CGFloat)scale
{
    // Make sure it doesn't go out of bounds
    if (scale < kScaleBoundLower)
    {
        _scale = kScaleBoundLower;
    }
    else if (scale > kScaleBoundUpper)
    {
        _scale = kScaleBoundUpper;
    }
    else
    {
        _scale = scale;
    }
}
*/
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
    
    //NSLog(@"self.collectionView.bounds.size.width=%f",self.collectionView.bounds.size.width);
    return CGSizeMake(self.itemSize.width * 9, height);
    //return CGSizeMake(self.collectionView.contentSize.width, height);
    
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











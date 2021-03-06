        //
//  CellViewLayout.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/5/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "CellViewLayout.h"

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
// to set the initial size of cell only 1 time
Boolean initFlag = 0;

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

    //self.itemWidth = 40.0;
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 1.0f);
    self.interItemSpacingY = 0.0f;
    
    self.itemWidth = 0.0;
    self.itemHt   = 0.0;
    
    self.initItemWidth = 0.0;
    self.initItemHt = 0.0;
    //self.itemHt = 35.0;//35.0;
    //_cellFontSize = 11; //8
    
    //self.itemSize = CGSizeMake(_itemWidth, _itemHt);

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
     //NSLog(@"**** Inside prepareLayout ****");

    
    // 320 is the fixed width of the phone in potrait mode.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //NSLog(@"**** _itemWidth **** ::: %f",_itemWidth);
    //self.numberOfColumns =  floor(screenWidth / self.itemWidth);

    self.numberOfColumns = [self.collectionView numberOfItemsInSection:0];
    
    if (self.itemWidth == 0.0) {
        self.itemWidth = floor(screenWidth / self.numberOfColumns);
        if (self.itemWidth < 53)
            self.itemWidth = 53.0;
        
    }


    _itemHt = _itemWidth;
    self.itemSize = CGSizeMake(_itemWidth, _itemHt);
    
    // 5 is the factor by which we want to set the fontsize based on itemwidth
    _cellFontSize = ceil(_itemWidth/5);
    
    // get the initialvalue for width for zoom in/out
    if (self.initItemWidth == 0.0)
        self.initItemWidth = self.itemWidth;
    
    // get the initialvalue for height for zoom in/out
    if (self.initItemHt == 0.0)
        self.initItemHt = self.itemHt ;
    
    
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
            
            // UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            itemAttributes.frame = [self frameForCellWatchAtIndexPath:indexPath];

            /*
            if (section == 0) { // We stick the first row
                CGRect frame = itemAttributes.frame;
                frame.origin.y = 0;
                itemAttributes.frame = frame;
                
            }
            if (item == 0) { // We stick the first column
                CGRect frame = itemAttributes.frame;
                frame.origin.x = self.collectionView.contentOffset.x;
                itemAttributes.frame = frame;
            } */
            cellLayoutInfo[indexPath] = itemAttributes;
            
        }
        
    }
    
    newLayoutInfo[cellWatch] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
    

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop)
     {
         [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                           //UICollectionViewLayoutAttributes *attributes,
                                                           hdrLayout *attributes,
                                                           BOOL *innerStop)
          {
              if (CGRectIntersectsRect(rect, attributes.frame))
              {
                  
/*
                      UICollectionView * const cv = self.collectionView;
                      CGPoint const contentOffset = cv.contentOffset;
                      CGPoint origin = attributes.frame.origin;
                      if(indexPath.item==0)
                      {
                          origin.x = contentOffset.x;
                          attributes.zIndex = 1022;
                          
                          //attributes.bkgrndClr = [UIColor lightGrayColor];
                      }
                      if(indexPath.section==0)
                      {
                          origin.y = contentOffset.y;
                          attributes.zIndex = 1023;
                          if(indexPath.item==0)
                              attributes.zIndex = 1024;
                          
                          attributes.bkgrndClr = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:1.0];
                          
                          attributes.dataFont = [UIFont italicSystemFontOfSize:_cellFontSize+1];
                      }
                      else
                          attributes.dataFont = [UIFont systemFontOfSize:_cellFontSize];
                  
                      attributes.frame = (CGRect)
                      {
                          .origin = origin,
                          .size = attributes.frame.size
                      };
                  */
                  
                  
                   // set the header color.
                   if(indexPath.section == 0 ){
                   attributes.bkgrndClr = [UIColor colorWithRed:0 green:175/255.0 blue:1 alpha:1.0];
                       
                   attributes.dataFont = [UIFont italicSystemFontOfSize:_cellFontSize+1];

                   // CellViewController *cell = (CellViewController *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"CuboidCell" forIndexPath:indexPath];
                   // cell.watchCellValue.font = [UIFont boldSystemFontOfSize:12];
                   }
                   else
                       attributes.dataFont = [UIFont systemFontOfSize:_cellFontSize]; 
                  

                  [allAttributes addObject:attributes];
              }
          }];
     }];
    
    return [allAttributes copy];
    
}


/*
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{


    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    return attributes;
    //return self.layoutInfo[cellWatch][indexPath];

    
} */


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
    //NSLog(@"**** Inside collectionViewContentSize ****");
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
    
    // set to 0.0 to calculate correct spacing on zoom
    CGFloat spacingX =  0.0;// self.collectionView.bounds.size.width -
    
    // commented as the spacing was calculated incorrectly on zoom
     /*CGFloat spacingX =   self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right - (self.numberOfColumns * cellWidth);
    if (self.numberOfColumns > 1)
        spacingX = spacingX / (self.numberOfColumns - 1); */
    
    
    
    CGFloat originX = floorf(self.itemInsets.left + (cellWidth + spacingX) * column);
    
    
    CGFloat originY = floor(self.itemInsets.top +(self.itemSize.height + self.interItemSpacingY) * row);
    
    
    
    return CGRectMake(originX, originY, cellWidth, self.itemSize.height);
}
@end











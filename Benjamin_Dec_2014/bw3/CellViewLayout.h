//
//  CellViewLayout.h
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/5/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewLayout : UICollectionViewLayout

    @property (nonatomic) UIEdgeInsets itemInsets;
    @property (nonatomic) CGSize itemSize;
    @property (nonatomic) CGFloat itemWidth;
    @property (nonatomic) CGFloat itemHt;
    @property (nonatomic) CGFloat interItemSpacingY;
    @property (nonatomic) NSInteger numberOfColumns;
    @property (nonatomic) float cellFontSize;
    /*for new header layout*/
    @property (nonatomic, copy) NSArray *rowColors;

  //  @property (nonatomic,assign) CGFloat scale;
   -(void)setCellItemSize :(CGSize)size :(int)colCntParam;

@end

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
    @property (nonatomic) CGFloat interItemSpacingY;
    @property (nonatomic) NSInteger numberOfColumns;

    /*for new header layout*/
    @property (nonatomic, copy) NSArray *rowColors;
@end

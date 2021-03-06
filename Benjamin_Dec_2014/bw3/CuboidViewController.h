//
//  CuboidViewController.h
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 10/31/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuboidViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout,UITextViewDelegate>

@property (strong, nonatomic) NSMutableArray *watchArray;

@property (nonatomic,assign) CGFloat scale;


@property (nonatomic,assign) BOOL fitCells;
@property (nonatomic,assign) BOOL animatedZooming;
@property (strong, nonatomic) IBOutlet UICollectionView *CuboidCollectionView;

@property (nonatomic,strong) NSString *CuboidName;
@end

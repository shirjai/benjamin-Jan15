//
//  watchViewController.h
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 10/31/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface watchViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *watchArray;

@end

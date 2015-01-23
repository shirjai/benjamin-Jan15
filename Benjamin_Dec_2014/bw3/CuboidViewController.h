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


@end

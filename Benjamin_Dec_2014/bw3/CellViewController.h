//
//  CellViewController.h
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 11/3/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewController : UICollectionViewCell<UITextViewDelegate> {
    
    IBOutlet UITextView *watchCellValue;
    
}

//@property (nonatomic,strong) IBOutlet UILabel *cellLabel;
@property (nonatomic,strong) IBOutlet UITextView *watchCellValue;
@property (nonatomic,assign) CGFloat scale;
@end

//
//  NotesDetailsViewController.h
//  bw3
//
//  Created by Shirish Jaiswal on 9/24/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notesDetail.h"

@interface NotesDetailsViewController : UIViewController{
    
    
    //IBOutlet UIScrollView *notesScrollView;
    //IBOutlet UITextView *notesDetailTextView;
    IBOutlet notesDetail *notesDetailTextView;
    
}

@property (nonatomic,strong) notesDetail *notesDetailTextView;
//@property(nonatomic, strong) UIScrollView *notesScrollView;
//@property(nonatomic, strong) UITextView *notesDetailTextView;
@property(nonatomic, strong) NSMutableArray *notesDetailArray;
@property(nonatomic, strong) NSDictionary *notesDetailDict;

@end

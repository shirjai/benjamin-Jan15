//
//  NotesTableViewController.h
//  bw3
//
//  Created by Shirish Jaiswal on 9/23/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *notesAddBtn;
@property (strong, nonatomic) NSMutableArray *NotesRootArray;

- (IBAction)notesAddBtnPressed:(id)sender;

@end

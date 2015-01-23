//
//  wbdetailVC.h
//  Benjamin
//
//  Created by Srinivas on 10/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wbdetailVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic,weak) IBOutlet UILabel *WorkBookName;
@property (weak, nonatomic) IBOutlet UILabel *WBName;
@property (weak,nonatomic) NSString *wb;
@property (weak, nonatomic) IBOutlet UITableView *WbSheetdetails;

- (IBAction)missingupdates:(id)sender;
- (IBAction)msgs:(id)sender;
- (IBAction)alerts:(id)sender;
- (IBAction)allupdates:(id)sender;



@end

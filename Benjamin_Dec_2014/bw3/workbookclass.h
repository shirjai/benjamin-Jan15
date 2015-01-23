//
//  workbookclass.h
//  bw3
//
//  Created by Srinivas on 8/26/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface workbookclass : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *WBList;
- (IBAction)BackClick:(id)sender;

@end

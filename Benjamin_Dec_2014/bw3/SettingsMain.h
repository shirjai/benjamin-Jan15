//
//  SettingsMain.h
//  bw3
//
//  Created by Srinivas on 9/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsMain : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *SettingsM;
//@property (weak, nonatomic) IBOutlet UITableViewCell *tblview;
//@property (weak, nonatomic) IBOutlet UITextField *txt;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *Save;
- (IBAction)SaveClick:(id)sender;
- (IBAction)BackClick:(id)sender;

@end

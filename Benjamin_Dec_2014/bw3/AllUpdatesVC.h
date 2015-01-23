//
//  AllUpdatesVC.h
//  bw4
//
//  Created by Srinivas on 10/21/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllUpdatesVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int TableID;
@property (nonatomic) NSString * period;


@property (nonatomic) NSString *sheetname;
@property (weak, nonatomic) IBOutlet UITableView *AllUpd;
@property (weak, nonatomic) IBOutlet UILabel *CuboidN;

@end

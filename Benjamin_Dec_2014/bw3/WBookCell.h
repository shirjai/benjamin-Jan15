//
//  WBookCell.h
//  bw4
//
//  Created by Srinivas on 10/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBookCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *WorkbookName;
@property (nonatomic,weak) IBOutlet UILabel *Desc;
@property (nonatomic,weak) IBOutlet UILabel *LastRefresh;
@property (nonatomic,weak) IBOutlet UILabel *lastSubmit;


@end

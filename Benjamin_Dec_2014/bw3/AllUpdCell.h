//
//  AllUpdCell.h
//  bw4
//
//  Created by Srinivas on 10/21/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AllUpdCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *UpdBy;
@property(nonatomic,weak) IBOutlet UILabel *UpdOn;
@property(nonatomic,weak) IBOutlet UILabel *Comment;
@property(nonatomic,weak) IBOutlet UILabel *Txid;

@end

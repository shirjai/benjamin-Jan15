//
//  MissingUpdatesVC.h
//  bw4
//
//  Created by Srinivas on 10/23/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissingUpdatesVC : UIViewController
@property (nonatomic) int TableID;

@property (weak, nonatomic) IBOutlet UILabel *CuboidName;
@property (weak, nonatomic) IBOutlet UILabel *TblId;
@property (weak, nonatomic) IBOutlet UILabel *MsingUpd;
@property (weak, nonatomic) IBOutlet UILabel *LstImId;
@property (weak, nonatomic) IBOutlet UILabel *lstImAt;
@property (weak, nonatomic) IBOutlet UILabel *LstUpdId;
@property (weak, nonatomic) IBOutlet UILabel *LstUpdAt;
@property (weak, nonatomic) IBOutlet UILabel *LstUpdOn;
@property (weak, nonatomic) IBOutlet UILabel *LstExId;
@property (weak, nonatomic) IBOutlet UILabel *LstExAt;
@property (weak, nonatomic) IBOutlet UILabel *Cmnt;

@end

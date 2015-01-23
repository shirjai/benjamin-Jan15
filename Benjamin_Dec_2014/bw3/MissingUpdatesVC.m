//
//  MissingUpdatesVC.m
//  bw4
//
//  Created by Srinivas on 10/23/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "MissingUpdatesVC.h"
#import "MissingUpdates.h"
#import "ViewController.h"
#import "MainVC.h"

@interface MissingUpdatesVC ()

@end

@implementation MissingUpdatesVC

@synthesize CuboidName = _CuboidName;
@synthesize TableID = _TableID;
@synthesize TblId = _TblId;
@synthesize MsingUpd = _MsingUpd;

@synthesize lstImAt = _lstImAt;
@synthesize LstImId = _LstImId;

@synthesize LstUpdAt = _LstUpdAt;
@synthesize LstUpdId = _LstUpdId;
@synthesize LstUpdOn = _LstUpdOn;

@synthesize LstExAt = _LstExAt;
@synthesize LstExId = _LstExId;

@synthesize Cmnt = _Cmnt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MissingUpdates *MU = [[MissingUpdates alloc] init];
    
    if (self.TableID <= 0) {
        UIAlertView *uiav = [[UIAlertView alloc] initWithTitle:@"Cuboid ID error" message:@"Missing cuboid ID in WIC" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil ];
        [uiav show];
        MainVC *mvc = [[MainVC alloc]init];
        [self presentViewController:mvc animated:YES completion:nil];
    }
    else{
    NSArray *MUArr = [MU GetArrayAllUpdates:self.TableID];
    
    if([MUArr count] ==0)
    {
    ViewController *VC = [[ViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
    }
    else{
    
    if([MUArr count] > 10)
    {
        self.TblId.text = [NSString stringWithFormat:@"TableId : %@",[MUArr objectAtIndex:0]];
        self.CuboidName.text = [NSString stringWithFormat:@"%@",[MUArr objectAtIndex:1]];
        self.MsingUpd.text = [NSString stringWithFormat:@"Number of Updates Missing : %@",[MUArr objectAtIndex:7]];
        
        self.LstUpdOn.text = [NSString stringWithFormat:@"Created On      : "];//%@",[MUArr objectAtIndex:5]];
        self.LstUpdId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:3]];
        self.LstUpdAt.text = [NSString stringWithFormat:@"Created By      : %@",[MUArr objectAtIndex:4]];
        self.Cmnt.text =     [NSString stringWithFormat:@"Comment         : %@",[MUArr objectAtIndex:6]];
        
        self.LstImId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:8]];
        self.lstImAt.text = [NSString stringWithFormat:@"Created On      : %@",[MUArr objectAtIndex:9]];
        
        self.LstExId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:10]];
        self.LstExAt.text = [NSString stringWithFormat:@"Created On      : %@",[MUArr objectAtIndex:11]];
        
    }
    else
    {
        self.TblId.text = [NSString stringWithFormat:@"TableId : %@",[MUArr objectAtIndex:0]];
        self.MsingUpd.text = [NSString stringWithFormat:@"Number of Updates Missing : 0"];
        self.LstUpdOn.text = [NSString stringWithFormat:@"Created On      : 12"];//%@",[MUArr objectAtIndex:5]];
        self.LstUpdId.text = [NSString stringWithFormat:@"Transaction Id  : "];
        self.LstUpdAt.text = [NSString stringWithFormat:@"Created By      : "];
        self.Cmnt.text =     [NSString stringWithFormat:@"Comment         : "];
        
        self.LstImId.text = [NSString stringWithFormat:@"Transaction Id  : "];
        self.lstImAt.text = [NSString stringWithFormat:@"Created On      : "];
        
        self.LstExId.text = [NSString stringWithFormat:@"Transaction Id  : "];
        self.LstExAt.text = [NSString stringWithFormat:@"Created On      : "];

    }
    }
    }
    self.navigationItem.title = @"Missing Updates";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

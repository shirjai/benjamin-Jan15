//
//  AllUpdatesVC.m
//  bw4
//
//  Created by Srinivas on 10/21/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "AllUpdatesVC.h"
#import "AllUpdates.h"
#import "AllUpdCell.h"

@interface AllUpdatesVC ()

@end

@implementation AllUpdatesVC
{
    NSArray *AllUpdatesArr;
}
@synthesize TableID = _TableID;
@synthesize CuboidN = _CuboidN;
@synthesize sheetname = _sheetname;
@synthesize period = _period;

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
    // Do any additional setup after loading the view from its nib.
    [[self AllUpd]setDelegate:self];
    [[self AllUpd]setDataSource:self];
    
    AllUpdates *AUpds = [[AllUpdates alloc]init];
    NSString *view = @"LATEST";
    //NSString *period = @"Year";
    [AUpds SetAllupdatesArray:(self.TableID) :view :self.period];
    AllUpdatesArr = [AUpds GetArrayAllUpdates];
    
    self.CuboidN.text = self.sheetname;
    self.navigationItem.title = @"All Updates";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-------------------------------------------


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AllUpdatesArr count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 130;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllUpdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllUpdCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllUpdCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    NSArray * UpdateArr = [AllUpdatesArr objectAtIndex:indexPath.row];
    /*
     0 - transaction id
     1 - updated by
     2 - updated on
     3 - comment
     4 - row added
     5 - row deleted
     6 - col added
     7 - cell updated
     8 - formula changed
     9 - baseline created
     10 - transaction gtm time
     */
    NSString *updon = [NSString stringWithFormat:@"%@", [UpdateArr objectAtIndex:2]];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    long long int dblupdon = [[numberFormatter numberFromString:updon] longLongValue];
    dblupdon = dblupdon/1000;
    NSDate *UpdDate = [NSDate dateWithTimeIntervalSince1970:dblupdon];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm MM-dd-yyyy"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:UpdDate];
    
    cell.UpdOn.text = [NSString stringWithFormat:@" %@", formattedDateString];
    cell.UpdBy.text = [NSString stringWithFormat:@" %@", [UpdateArr objectAtIndex:1]];
    cell.Comment.text = [NSString stringWithFormat:@" Comment : %@", [UpdateArr objectAtIndex:3]];
    cell.Txid.text = [NSString stringWithFormat:@" %@", [UpdateArr objectAtIndex:0]];

    //cell.layer.cornerRadius = 5.0;
    //cell.layer.masksToBounds = YES;
    return cell;
}


@end

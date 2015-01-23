//
//  wbdetailVC.m
//  Benjamin
//
//  Created by Srinivas on 10/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "wbdetailVC.h"
#import "workbookCell.h"
#import "WBclass.h"
#import "WBDetails.h"
#import "LinkImport.h"
#import "Cuboid.h"
#import "viewMsgs.h"
#import "AppDelegate.h"
#import "WIC.h"
#import "AllUpdatesVC.h"
#import "MissingUpdatesVC.h"

@interface wbdetailVC ()
{
    NSMutableArray *SheetNames;
    NSMutableArray *UpdateBy;
    NSMutableArray *UpdateOn;
    NSMutableArray *CuboidIds;
}

@end

@implementation wbdetailVC
@synthesize WBName = _WBName;
@synthesize wb = _wb;
//@synthesize WorkBookName = _WorkBookName;

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
    [[self WbSheetdetails] setDelegate:self];
    [[self WbSheetdetails] setDataSource:self];
    
    /*
    SheetNames = [[NSMutableArray alloc]init];
    SheetNames = [NSArray arrayWithObjects:@"Budget", @"Item Master", @"Customer List",@"Forecast",@"Messages",@"Notes",@"Salary Change",@"Demand Planner", nil];
    
    UpdateBy = [[NSMutableArray alloc]init];
    UpdateBy = [NSArray arrayWithObjects:@"Sam", @"Mark", @"Mike",@"Sam", @"Mark", @"Mike", @"Mark", @"Mike", nil];
    
    UpdateOn = [[NSMutableArray alloc]init];
    UpdateOn = [NSArray arrayWithObjects:@"10.00 pm: 12 oct, 2014", @"10.00 pm: 12 oct, 2014", @"10.00 pm: 12 oct, 2014",@"10.00 pm: 12 oct, 2014", @"10.00 pm: 12 oct, 2014", @"10.00 pm: 12 oct, 2014",@"10.00 pm: 12 oct, 2014", @"10.00 pm: 12 oct, 2014", nil];
    */
    
    
    NSLog(@"inside wbdetails");
    NSLog(self.wb);
    self.WBName.text = self.wb;
    NSLog(@"----");
    //self.WBName.text = self.WorkBookName.text;
    
    WBclass *WBC = [[WBclass alloc]init];
    WBDetails *WBD = [[WBDetails alloc]init];
    WBD = [WBC GetWorkbookDetails:self.wb];
    
    SheetNames = WBD.GetCuboidName;
    UpdateBy = WBD.GetUpdatedBy;
    UpdateOn = WBD.GetupdatedOn;
    CuboidIds = WBD.GetCuboidId;
    
   self.navigationItem.title = @"WorkBook Detail";
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SheetNames count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    workbookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workbookCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"workbookCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.wbname.text = [SheetNames objectAtIndex:indexPath.row];
    cell.desc.text = [NSString stringWithFormat:@"Updated By %@ on %@",[UpdateBy objectAtIndex:indexPath.row],[UpdateOn objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)missingupdates:(id)sender
{
    workbookCell *cell;
    NSIndexPath *selectedIndexPath = [[self WbSheetdetails] indexPathForSelectedRow];
    if (selectedIndexPath)
    {
        cell = (workbookCell *) [[self WbSheetdetails] cellForRowAtIndexPath:selectedIndexPath];
        NSString *wbname = [[cell wbname] text];
        NSLog(@"----select Cuboid name-----");
        NSLog(wbname);
        
        NSLog(@"----select Cuboid id-----");
        NSLog([CuboidIds objectAtIndex:selectedIndexPath.row]);
        
        MissingUpdatesVC *MUVC = [[MissingUpdatesVC alloc]init];
        MUVC.TableID = [[CuboidIds objectAtIndex:selectedIndexPath.row] integerValue];
        
        [self.navigationController pushViewController:MUVC animated:YES];
        
       // NSLog(@"%@",self.navigationController);

        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Selection Error" message:@"Please select a Sheet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)msgs:(id)sender
{
    WIC *wic = [[WIC alloc]init];
    
    NSInteger *IntMsgId = [wic GetWBProperty:@"" :self.WBName.text :@"Messages"]; //2000281;
        LinkImport *linkImportMsg = [[LinkImport alloc]init];
        Cuboid *cubMsg = [[Cuboid alloc] init];
        cubMsg = [linkImportMsg LinkImportApi:IntMsgId];
        
        viewMsgs *viewMsgsObj = [[viewMsgs alloc] initWithNibName:nil bundle:nil];
        viewMsgsObj.msgCubId = IntMsgId;
        
        
        if (cubMsg != Nil)
        {
            NSLog(@"Data returned from server");
            
            NSMutableArray *rowArray =[cubMsg GetRow];
            NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
            cubmsgs = [viewMsgsObj loadMessages:rowArray :@"linkImport"];
            
            // msgs.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            //[self presentViewController:msgs animated:YES completion:nil];
            
            
            //UINavigationController *navCMsgs = [[UINavigationController alloc] init];
            
            [self.navigationController pushViewController:viewMsgsObj animated:YES];
            
            NSLog(@"%@",self.navigationController);
            
            viewMsgsObj.msgs   = [[NSMutableArray alloc]init];
            [[viewMsgsObj msgs] addObjectsFromArray:cubmsgs];
            
            //    [viewtest msgs] = [cubmsgs mutableCopy];
            
            //    [[viewtest msgs]:cubmsgs,nil] ;
            
            
            //[viewtest msgs] = cubmsgs;
            
            
        }
        else
        {
            NSLog(@"No data returned from server");
        }
        
    
   
}

- (IBAction)alerts:(id)sender
{
    workbookCell *cell;
    NSIndexPath *selectedIndexPath = [[self WbSheetdetails] indexPathForSelectedRow];
    if (selectedIndexPath)
    {
        cell = (workbookCell *) [[self WbSheetdetails] cellForRowAtIndexPath:selectedIndexPath];
        NSString *wbname = [[cell wbname] text];
        NSLog(@"----select workbook name-----");
        NSLog(wbname);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"New" message:@"Comming Soon..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Selection Error" message:@"Please select a Sheet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex > 0)
    {
    workbookCell *cell;
    NSIndexPath *selectedIndexPath = [[self WbSheetdetails] indexPathForSelectedRow];
    cell = (workbookCell *) [[self WbSheetdetails] cellForRowAtIndexPath:selectedIndexPath];
    NSString *wbname = [[cell wbname] text];
    NSLog(@"----select Cuboid name-----");
    NSLog(wbname);
    
    NSLog(@"----select Cuboid id-----");
    NSLog([CuboidIds objectAtIndex:selectedIndexPath.row]);
    
     AllUpdatesVC *AUVC = [[AllUpdatesVC alloc]init];
     AUVC.TableID = [[CuboidIds objectAtIndex:selectedIndexPath.row] integerValue];
     AUVC.sheetname = [NSString stringWithFormat:@"%@ Updates", wbname];
     //get the period of details
    if(buttonIndex == 1)
    {
       AUVC.period = @"Week";
    }
    else if(buttonIndex == 2)
    {
        AUVC.period = @"Month";
    }
    else if(buttonIndex == 3)
    {
        AUVC.period = @"Year";
    }
    
    [self.navigationController pushViewController:AUVC animated:YES];
    
    //NSLog(@"%@",self.navigationController);
    //[self presentViewController:AUVC animated:YES completion:nil];
    }


}

- (IBAction)allupdates:(id)sender
{
    workbookCell *cell;
    NSIndexPath *selectedIndexPath = [[self WbSheetdetails] indexPathForSelectedRow];
    if (selectedIndexPath)
    {
        /*
        cell = (workbookCell *) [[self WbSheetdetails] cellForRowAtIndexPath:selectedIndexPath];
        NSString *wbname = [[cell wbname] text];
        NSLog(@"----select Cuboid name-----");
        NSLog(wbname);
        
        NSLog(@"----select Cuboid id-----");
        NSLog([CuboidIds objectAtIndex:selectedIndexPath.row]);
         */
        
        UIAlertView *GetTimeFrame = [[UIAlertView alloc]initWithTitle:@"Select Time Period" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Week",@"Month", @"Year", nil];
        [GetTimeFrame performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
       // [GetTimeFrame show];
        
        /*
        AllUpdatesVC *AUVC = [[AllUpdatesVC alloc]init];
        AUVC.TableID = [[CuboidIds objectAtIndex:selectedIndexPath.row] integerValue];
        AUVC.sheetname = [NSString stringWithFormat:@"%@ Updates", wbname];
        //get the period of details
        [self presentViewController:AUVC animated:YES completion:nil];
         */
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Selection Error" message:@"Please select a Sheet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end

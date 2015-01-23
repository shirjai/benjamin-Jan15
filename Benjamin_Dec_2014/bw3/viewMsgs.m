//
//  viewMsgs.m
//  bw3
//
//  Created by Shirish Jaiswal on 7/18/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "viewMsgs.h"
#import "TableViewCellMessages.h"
#import "MainVC.h"
#import "LinkImport.h"
#import "Refresh.h"

@interface viewMsgs()
{
    
    UIRefreshControl *refreshControlObj;
}

@end


@implementation viewMsgs

@synthesize msgs;


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // NSLog(@"Inside heightForRowAtIndexPath : %ld",(long)[indexPath row]);
    
    NSDictionary *rowData = self.msgs[indexPath.row];
    //NSString *cellText = rowData[@"Comment"];
    /*   int cellHt = [self heightForText:rowData[@"User"]] +
     [self heightForText:rowData[@"Date"]]+
     [self heightForText:rowData[@"sheet"]]+
     [self heightForText:rowData[@"Type"]]+
     [self heightForText:rowData[@"Comment"]];
     */
    
    int cellHt = [self heightForText:
                  [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",
                   rowData[@"User"],rowData[@"Date"],rowData[@"sheet"],rowData[@"Type"],rowData[@"Comment"]]];
    
    return cellHt;
    
    // return 100;
}

// /**old**/@synthesize colorNames;
// /**old**/ @synthesize table;

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 500;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 320, MAX_HEIGHT)];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:12];
    [textView sizeToFit];
    //NSLog(@"*********** :%f",textView.frame.size.height);
    return textView.frame.size.height;
}



static NSString *CellIdentifier = @"CellTableIdentifer";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Messages";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //something here
    // font color for title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    // color for font of navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:204/255.0 alpha:1.0];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:161/255.0 green:209/255.0 blue:255/255.0 alpha:1.0]];
    
    //self.navigationItem.backBarButtonItem.tintColor = [UIColor redColor];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    refreshControlObj = [[UIRefreshControl alloc]init];
    [refreshControlObj addTarget:self action:@selector(refreshMessages) forControlEvents:UIControlEventValueChanged];
    [self.msgsTableView addSubview:refreshControlObj];
    
    //[self.msgsTableView setBackgroundView:nil];
    // self.msgsTableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:220/255.0 alpha:1.0];
    
    self.msgsTableView.separatorColor = [UIColor greenColor];
    //self.msgsTableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLineEtched;
    //self.msgsTableView.separatorInset =  UIEdgeInsetsZero;
    
    //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
    //initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh                                                                                          target:self action:@selector(refreshMessages)];
    
    
    //self.msgsTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    //self.msgsTableView.delegate = self;
    //self.msgsTableView.dataSource = self;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Inside NumberOfSectionsInTableView");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" NumberOf RowsInSection = %d",[self.msgs count]);
    //return [self.colorNames count];
    return [self.msgs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Inside cellForRowAtIndexPath");
    
    /*   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     }
     
     
     NSDictionary *rowData = self.msgs[indexPath.row];
     
     
     
     cell.textLabel.text = rowData[@"Comment"];
     
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:[%@]",rowData[@"User"],[self dateFromExcelSerialDate:[rowData[@"Date"] doubleValue]]];
     
     //NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"chat_icon"] ofType:@"png"];
     //UIImage *theImage = [UIImage imageWithContentsOfFile:path];
     
     UIImage *theImage   = [UIImage imageNamed:@"chat_icon.png"];
     cell.imageView.image = theImage;
     return cell;
     */
    
    
    /*      APPROACH 1 */
    
    
    TableViewCellMessages *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[TableViewCellMessages alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] ;
        
    }
    
    
    NSDictionary *rowData = self.msgs[indexPath.row];
    
    
    cell.user       = [NSString stringWithFormat:@"%@:",rowData[@"User"]];
    cell.tx         = [NSString stringWithFormat:@"[%@]" ,[self dateFromExcelSerialDate:[rowData[@"Date"] doubleValue]]];//rowData[@"Date"];
    cell.sheet      = rowData[@"sheet"];
    cell.type       = rowData[@"Type"];
    cell.comment    = rowData[@"Comment"];
    
    // uncomment to get standard image
    //UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,5, 20, 25)];
    //imv.image=[UIImage imageNamed:@"spready.png"];
    
    // to get user specific image
    //UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,5, 50, 50)];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,5, 55, 55)];
    
    if([self getImageFromURL:rowData[@"User"]] == nil)
        imv.image=[UIImage imageNamed:@"spready.png"];
    else
        imv.image = [self getImageFromURL:rowData[@"User"]];
    
    imv.layer.cornerRadius = imv.frame.size.height/2;
    imv.layer.masksToBounds = YES;
    imv.layer.borderWidth   = 0;
    [cell addSubview:imv];
    
    return cell;
    
    
    //NSLog(@"begin of cellForRowAtIndexPath");
    /* old
     
     
     //NSDate *retDate = [self dateFromExcelSerialDate:[rowData[@"Date"] doubleValue]];
     // NSLog(@"retDate=%@", retDate);
     static NSString *CellIdentifier = @"Cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     // NSDictionary *rowData = self.colorNames[indexPath.row];
     
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
     }
     
     if ([indexPath row] <5) {
     cell.textLabel.text = [self.colorNames objectAtIndex: [indexPath row]];
     }else
     cell.textLabel.text = nil;
     
     
     NSLog(@"cellForRowAtIndexPath=%@", cell.textLabel.text);
     return cell;
     old */
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//{

// cell.contentView.backgroundColor  = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];

/* if(indexPath.row % 2 == 0){
 cell.contentView.backgroundColor  = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:204/255.0 alpha:1.0];
 }
 else
 cell.contentView.backgroundColor  = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:255/255.0 alpha:1.0];*/

//}

/** Get The Images**/

-(UIImage *) getImageFromURL:(NSString *)user{
    
    /* logic to retrieve image from database
     //assign query id
     NSString *queryId = @"69";
     
     //assign tagValue cuboid id
     NSString *usrImgName = [user substringToIndex:4];
     
     ExternalQuery *extQueryObj = [[ExternalQuery alloc] init];
     NSString *requestBuffer = [extQueryObj getExternalData :2000281 :@" " :queryId :usrImgName];
     NSArray *response = [extQueryObj ExtractResponseExternalData :requestBuffer];
     result = response[4];
     */
    UIImage * result = nil;
    NSString *usrImgName = [user substringToIndex:4];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains (NSPicturesDirectory, NSUserDomainMask, YES);
    NSString * picturePath = [paths objectAtIndex:0];
    
    
    NSString *fileURL = [NSString stringWithFormat:@"%@/%@.png",picturePath,usrImgName];
    //NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    if (fileURL == nil) 
        fileURL =[NSString stringWithFormat:@"%@/spready.png",picturePath];
        
    result = [UIImage imageWithContentsOfFile:fileURL];
    
    return result;
}


-(NSString *) dateFromExcelSerialDate:(double) serialdate
{
    if (serialdate > 31 + 28)
        serialdate -= 1.0;      // Fix Excel bug where it thinks 1900 is a leap year
    const NSTimeInterval numberOfSecondsInOneDay = 86400;
    NSTimeInterval theTimeInterval = serialdate * numberOfSecondsInOneDay; //number of days
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [calendar setTimeZone:timeZone];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter.timeZone = timeZone;
    
    NSDateComponents *excelBaseDateComps = [[NSDateComponents alloc] init];
    [excelBaseDateComps setYear:1900];
    [excelBaseDateComps setMonth:1];
    [excelBaseDateComps setDay:0];
    [excelBaseDateComps setHour:0];
    [excelBaseDateComps setMinute:0];
    [excelBaseDateComps setSecond:0];
    [excelBaseDateComps setTimeZone:timeZone];
    NSDate *excelBaseDate = [calendar dateFromComponents:excelBaseDateComps];
    
    NSDate *inputDate = [NSDate dateWithTimeInterval:theTimeInterval
                                           sinceDate:excelBaseDate];
    
    NSString *convertedString = [dateFormatter stringFromDate:inputDate];
    
    return convertedString;
}

- (IBAction)backAction:(id)sender {
    
    MainVC *MVC = [[MainVC alloc] initWithNibName:nil bundle:nil];
    
    
    MVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self.navigationController pushViewController:MVC animated:YES];
    [self presentViewController:MVC animated:YES completion:nil];
}

//-(NSMutableArray *)loadTestData :(NSMutableArray *)array
-(void)loadTestDataFromArray:(NSMutableArray *)array
{
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:0];
    for (int i=1; i<[array count]; i++) {
        [indexes addIndex:i];
    }
    [self.msgs insertObjects:array atIndexes:indexes];
    //return array;
}

-(NSMutableArray *)loadTestData
{
    NSMutableDictionary *dictmsgs = [[NSMutableDictionary alloc] init];
    NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
    [dictmsgs setObject:@"Updates" forKey:@"Type"];
    [dictmsgs setObject:@"s@j.com" forKey:@"User"];
    [dictmsgs setObject:@"Issues" forKey:@"sheet"];
    [dictmsgs setObject:@"41876" forKey:@"Date"];
    [dictmsgs setObject:@"TestingRefresh4" forKey:@"Comment"];
    //[dictmsgs setObject:@"80246" forKey:@"TX_ID"];
    //[dictmsgs setObject:@"" forKey:@"DateString"];
    
    [cubmsgs addObject:dictmsgs];
    
    [dictmsgs removeAllObjects];
    
    [dictmsgs setObject:@"Updates" forKey:@"Type"];
    [dictmsgs setObject:@"shir@jai.com" forKey:@"User"];
    [dictmsgs setObject:@"Issues" forKey:@"sheet"];
    [dictmsgs setObject:@"41880" forKey:@"Date"];
    [dictmsgs setObject:@"TestingRefresh44" forKey:@"Comment"];
    //[dictmsgs setObject:@"80246" forKey:@"TX_ID"];
    //[dictmsgs setObject:@"" forKey:@"DateString"];
    
    [cubmsgs addObject:dictmsgs];
    
    return cubmsgs;
}

-(void)refreshMessages
{
    
    
    LinkImport *linkImportMsg = [LinkImport alloc];
    
    Refresh *refreshObj = [[Refresh alloc]init];
    Cuboid *cubMsg = [[Cuboid alloc] init];
    int intMsgCuboidId = (int)_msgCubId;
    cubMsg = [refreshObj RefreshAPI:intMsgCuboidId:1];
    //cubMsg = [linkImportMsg LinkImportApi:_msgCubId];
    
    NSLog(@"Inside Refresh Messages");
    
    if (cubMsg != Nil)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *rowArray =[cubMsg GetRow];
        //NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        
        NSMutableArray *mutarrRefreshMsgs = [self loadMessages:rowArray :@"import"];
        //NSMutableArray *mutarrRefreshMsgs = [self loadTestData];
        
        
        if ([mutarrRefreshMsgs count])
        {
            [self loadTestDataFromArray:mutarrRefreshMsgs];
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *indexPath = [[NSIndexPath alloc]init];
            
            for (int i=0; i<[mutarrRefreshMsgs count]; i++) {
                indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            //self.msgs   = [[NSMutableArray alloc]init];
            
            //self.msgsTableView.delegate = self;
            //self.msgsTableView.dataSource = self;
            //[[self msgs] addObjectsFromArray:mutarrRefreshMsgs];
            //[self.msgs  addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.msgsTableView beginUpdates];
            [self.msgsTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
            [self.msgsTableView endUpdates];
            //[self.msgsTableView reloadData];
        }
        else{
            NSLog(@"No changes from the cloud");
        }
        [refreshControlObj endRefreshing];
        
        //    [viewtest msgs] = [cubmsgs mutableCopy];
        
        //    [[viewtest msgs]:cubmsgs,nil] ;
        
        
        //[viewtest msgs] = cubmsgs;
        
        
    }
    else{
        NSLog(@"Error in refreshing Messages cuboid");
    }
}


-(NSMutableArray *)loadMessages:(NSMutableArray *)msgRowArray : (NSString *)action
{
    NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
    NSLog(@"Inside loadMessages");
    if (![msgRowArray count]) {
        
        NSLog(@"No changes or new rows from the server");
        
    }
    else{
        NSString *strColName = nil;
        NSString *strColVal = nil;
        Row *eachRow = nil;
        int irowCnt = 1;
        if ([action isEqualToString:@"import"]) {
            irowCnt = 0;
        }
        
        
        //for (Row *eachRow in msgRowArray)
        for ( irowCnt = irowCnt;  irowCnt < [msgRowArray count];irowCnt++)
        {
            eachRow = msgRowArray[irowCnt];
            NSLog(@"eachRow:%@",eachRow);
            NSLog(@"Rowid:%d",[eachRow RowId]);
            
            NSString *msgElement = nil;
            NSMutableDictionary *dictmsgs = [[NSMutableDictionary alloc] init];
            
            for (int i=0; i <[[eachRow ColName] count];i++)
            {
                
                strColName = [[eachRow ColName] objectAtIndex:i];
                strColVal = [[eachRow Value] objectAtIndex:i];
                NSLog(@"colname:%@",strColName);
                NSLog(@"colvalue:%@",strColVal);
                
                if ([strColName isEqualToString:@"1"])
                {
                    //msgElement = [NSString stringWithFormat:@"{%@:%@",strColName,strColVal];
                    [dictmsgs setObject:strColVal forKey:@"User"];
                    //[cubmsgs addObject:strColVal];
                    //[msgs objectatindex:i] = @{@"User %@",strColVal};
                    //[cubmsgs objectatindex:i] = @{@"%@:%@":strColName,strColVal};
                    
                }
                if ([strColName isEqualToString:@"3"])
                {
                    //msgElement = [NSString stringWithFormat:@"%@,Date:%@",msgElement,strColVal];
                    
                    // Formatter configuration
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                    [formatter setLocale:posix];
                    [formatter setDateFormat:@"M.d.y"];
                    
                    // Date to string
                    NSString *dateString = strColVal;
                    NSDate *prettyDate = [formatter dateFromString:dateString];
                    
                    NSLog(@"strColVal:%@", prettyDate);
                    
                    [dictmsgs setObject:strColVal forKey:@"Date"];
                }
                if ([strColName isEqualToString:@"2"])
                {
                    
                    [dictmsgs setObject:strColVal forKey:@"sheet"];
                    
                }
                if ([strColName isEqualToString:@"0"])
                {
                    
                    [dictmsgs setObject:strColVal forKey:@"Type"];
                    
                }
                if ([strColName isEqualToString:@"4"])
                {
                    
                    [dictmsgs setObject:strColVal forKey:@"Comment"];
                    
                }
            }
            //[cubmsgs addObject:msgElement];
            [cubmsgs addObject:dictmsgs];
        }
    }
    return cubmsgs;
    
}

/*
 -(NSMutableArray *)loadMsgs:(Cuboid *)cubMsg
 {
 NSString *strColName = nil;
 NSString *strColVal = nil;
 NSLog(@"Data returned from server");
 
 NSMutableArray *rowArray =[cubMsg Rows];
 NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
 
 for (Row *eachRow in rowArray)
 {
 NSLog(@"eachRow:%@",eachRow);
 NSLog(@"Rowid:%d",[eachRow RowId]);
 
 NSString *msgElement = nil;
 NSMutableDictionary *dictmsgs = [[NSMutableDictionary alloc] init];
 
 for (int i=0; i <[[eachRow ColName] count];i++)
 {
 
 strColName = [[eachRow ColName] objectAtIndex:i];
 strColVal = [[eachRow Value] objectAtIndex:i];
 NSLog(@"colname:%@",strColName);
 NSLog(@"colvalue:%@",strColVal);
 
 if ([strColName isEqualToString:@"User"])
 {
 //msgElement = [NSString stringWithFormat:@"{%@:%@",strColName,strColVal];
 [dictmsgs setObject:strColVal forKey:@"User"];
 //[cubmsgs addObject:strColVal];
 //[msgs objectatindex:i] = @{@"User %@",strColVal};
 //[cubmsgs objectatindex:i] = @{@"%@:%@":strColName,strColVal};
 
 }
 if ([strColName isEqualToString:@"LastUpdate"])
 {
 //msgElement = [NSString stringWithFormat:@"%@,Date:%@",msgElement,strColVal];
 
 // Formatter configuration
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
 [formatter setLocale:posix];
 [formatter setDateFormat:@"M.d.y"];
 
 // Date to string
 NSString *dateString = strColVal;
 NSDate *prettyDate = [formatter dateFromString:dateString];
 
 NSLog(@"strColVal:%@", prettyDate);
 
 [dictmsgs setObject:strColVal forKey:@"Date"];
 }
 if ([strColName isEqualToString:@"Worksheet"])
 {
 
 [dictmsgs setObject:strColVal forKey:@"sheet"];
 
 }
 if ([strColName isEqualToString:@"Type"])
 {
 
 [dictmsgs setObject:strColVal forKey:@"Type"];
 
 }
 if ([strColName isEqualToString:@"Comment"])
 {
 
 [dictmsgs setObject:strColVal forKey:@"Comment"];
 
 }
 }
 //[cubmsgs addObject:msgElement];
 [cubmsgs addObject:dictmsgs];
 }
 
 return cubmsgs;
 
 
 }
 */
@end


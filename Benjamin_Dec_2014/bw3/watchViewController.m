    //
//  watchViewController.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 10/31/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "watchViewController.h"

// import the custom cell
#import "watchCellViewController.h"

// import the custom layout
//#import "watchCellViewLayout.h"

#import "LinkImport.h"
#import "Refresh.h"
#import "common.h"
#import "Database.h"
#import "ExternalQuery.h"

@interface watchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource//>
,UICollectionViewDelegateFlowLayout>
{
    UIRefreshControl *refreshControlObj;
    
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *watchCollectionView;

//@property (strong, nonatomic) IBOutlet watchCellViewLayout *cellViewLayout;


@end

@implementation watchViewController

@synthesize watchArray;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Watch";

    }
    return self;
}


- (void)viewDidLoad
{
    
  //  [self.watchCollectionView setCollectionViewLayout:[[watchCellViewLayout alloc]init]];
    
    [super viewDidLoad];
    
    refreshControlObj = [[UIRefreshControl alloc]init];
    [refreshControlObj addTarget:self action:@selector(refreshWatch) forControlEvents:UIControlEventValueChanged];
    [self.watchCollectionView addSubview:refreshControlObj];
    
    [self.watchCollectionView registerClass:[watchCellViewController class] forCellWithReuseIdentifier:@"watchCell"];
    
    //[self.watchCollectionView reloadData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_logo.png"]];
 
   /// self.watchCollectionView.collectionViewLayout = [[watchCellViewLayout alloc] init];
    
    // Configure layout
    //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(150, 55)];
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //[self.watchCollectionView setCollectionViewLayout:flowLayout];


    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	// important to reload data when view is redrawn
    [self.watchCollectionView reloadItemsAtIndexPaths:[self.watchCollectionView indexPathsForVisibleItems]];
	[self.watchCollectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Collection View Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //NSLog(@"numberOfSectionsInCollectionView:%d",[watchArray count]);
    return [watchArray count];
    //return 30;//[watchArray count];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"[watchArray[section] count]:%d",[watchArray[section] count]);
    return [watchArray[section] count];
    //return 3;//[watchMasterArray count];
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    watchCellViewController *cell = (watchCellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"watchCell" forIndexPath:indexPath];
    
   cell.cellLabel.frame=CGRectMake(5, 13, 98, 0);
    
    NSString *cellValue = watchArray[indexPath.section][indexPath.row];
    
    NSRange rngSep = [cellValue rangeOfString:@"\u00B5"
                                     options:NSBackwardsSearch
                                       range:NSMakeRange(0, cellValue.length)];
    
    int changeFlag = 0;
    if(rngSep.location == NSNotFound){
        NSLog(@"Separator Not Present");
    }
    else{
        NSLog(@":::::%@",[cellValue substringFromIndex:rngSep.location+1]);
        changeFlag = [[cellValue substringFromIndex:rngSep.location+1] intValue];
        cellValue = [cellValue substringToIndex:rngSep.location];
    }
    cell.cellLabel.text=cellValue;
    
    //NSLog(@"cellValue at Section%d Row%d = %@",indexPath.section,indexPath.row, cell.cellLabel.text);
    
    
    if (changeFlag == 1){
        [cell.layer setBorderColor:[UIColor redColor].CGColor];
        [cell.layer setBorderWidth:1.5f];
        watchArray[indexPath.section][indexPath.row] = [NSString stringWithFormat:@"%@\u00B50",cellValue];
    }
    else{
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.layer setBorderWidth:1.0f];
    }
    
    cell.cellLabel.backgroundColor = [UIColor clearColor];
    
    cell.cellLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //cell.cellLabel.preferredMaxLayoutWidth = CGRectGetWidth(collectionView.bounds);
    [cell.cellLabel  setNumberOfLines:0];
    
    //CGSize textSize=CGSizeMake(100, 100);
    
    //textSize = [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    
    //[cell.cellLabel sizeThatFits:textSize];
    
    [cell.cellLabel sizeToFit];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    watchCellViewController *cell = (watchCellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"watchCell" forIndexPath:indexPath];
    
    NSLog(@"value ::::: %@",cell.cellLabel.text);
    NSLog(@"value ::::: %@",watchArray[indexPath.section][indexPath.row]);
    NSLog(@"indexPath.section ::::: %ld",(long)indexPath.section);
    NSLog(@"row ::::: %ld",(long)indexPath.row);
    
    //[cell.watchCellValue shouldChangeTextInRange:];
}

-(void)refreshWatch
{

    NSLog(@"Inside Refresh Watch Tag Value cuboid");
    
    // get user email address
    //Database *db =[Database alloc];
    //[db getPropertiesFile];
    //NSString *userEmailId    = [db GetPropertyValue:@"UserName"];
    //db = nil;
    
    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"watchProperties"];
    
    //assign query id
    //NSString *queryId = [propDict objectForKey:@"queryId"];//@"68";
    
    //assign tagValue cuboid id
    int intWatchTagValId = [[propDict objectForKey:@"tableId"] intValue];//2000284;
   
    /*
    ExternalQuery *extQueryObj = [[ExternalQuery alloc] init];
    NSString *extQueryParam = [NSString stringWithFormat:@"%@,|1|User Id|1",userEmailId];
    
    NSString *requestBuffer = [extQueryObj getExternalData :intWatchTagValId :@" " :queryId :extQueryParam];
    
    NSArray *response = [extQueryObj ExtractResponseExternalData :requestBuffer]; */
    
    
    NSString *response = [common getMyDataFrmServer :@"" :@"GetLatestTagValue"];
    
    
    if (response == nil) {
        NSLog(@"Error in updating Tag Cuboid");
    }

    
    NSLog(@"Refresh Cell Changes");
    Refresh *refreshObj = [[Refresh alloc]init];
    Cuboid *cubWatch = [[Cuboid alloc] init];
    
    cubWatch = [refreshObj RefreshAPI:intWatchTagValId:1];
    
    NSString *rowColName        = [propDict objectForKey:@"rowIdKey"];
    NSString *strTagColName     = [propDict objectForKey:@"tagValCol"];
    NSString *strValColName     = [propDict objectForKey:@"valCol"];
    NSString *strTimeColName    = [propDict objectForKey:@"timeStampCol"];
    //NSString *strUserColName    = [propDict objectForKey:@"userColName"];
    //NSString *strCubColName    = [propDict objectForKey:@"cubColName"];
    //NSMutableString *strOnDemandParam = [[propDict objectForKey:@"dynamicQuery"] mutableCopy];
    NSArray *arrSelColNames = [NSArray arrayWithObjects: strTagColName, strValColName, strTimeColName, rowColName, nil];
    
    if([[cubWatch GetRow] count])
    {
        NSMutableArray *mutArrCellChnge = [cubWatch GetRow];

        
        //re-arrange data in watch format and get it in an array
        mutArrCellChnge = [common prepareDataFromBuffer:mutArrCellChnge ColNames:arrSelColNames RowIdCol:rowColName];
        
        // assuming postion for cols as 1:Tag Name;2:Value;3:Timestamp, 4:RowId
        for(int cellCnt=0; cellCnt < [mutArrCellChnge count]; cellCnt++)
        {
            NSDictionary *eachCell = mutArrCellChnge[cellCnt];
            for(int watchArrCnt=0; watchArrCnt < [watchArray count]; watchArrCnt++)
            {
                NSMutableArray *eachRowArr = watchArray[watchArrCnt];
                if([(NSString *)[eachCell objectForKey:rowColName]isEqualToString:eachRowArr[3]])
                {
                    for( NSString *aKey in [eachCell allKeys] )
                    {
 
                            
                        if([aKey caseInsensitiveCompare:strTagColName] == NSOrderedSame){
                            watchArray[watchArrCnt][0] = (NSString *)
                                                            [NSString stringWithFormat:@"%@%@1",
                                                                [eachCell objectForKey:aKey],@"\u00B5"];
                        }
                        if([aKey caseInsensitiveCompare:strValColName] == NSOrderedSame){
                            watchArray[watchArrCnt][1] = (NSString *)
                                                            [NSString stringWithFormat:@"%@%@1",[eachCell objectForKey:aKey],@"\u00B5"];
                        }
                        
                        if([aKey caseInsensitiveCompare:strTimeColName] == NSOrderedSame)
                        {
                            NSString *time = (NSString *)[eachCell objectForKey:aKey];
                            watchArray[watchArrCnt][2]  = [NSString stringWithFormat:@"%@%@1",
                                                           [common dateFromGMTtoLocal:time],@"\u00B5"];
                            
                        }
                        
                    }
                }
                    
            }
        }
        
    }
    
    NSLog(@"Remove absent Rows");
/** Delete Row Logic to be uncommented when server side code ready**/
    
    /*
    Database *DB = [[Database alloc]init];
    NSArray *presentRows = [[DB Getcuboid:intMsgCuboidId] GetRowIds];
    
    NSMutableArray *watchArrayRowIds = [[NSMutableArray alloc] init];
        
    [watchArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSMutableArray *eachRowArr, NSUInteger idx, BOOL *stop) {
            //if([eachRowArr[3] isKindOfClass:[NSNumber class]])
    if(![eachRowArr[3] isEqualToString:@"RowId"])
        [watchArrayRowIds addObject:eachRowArr[3]];
    }];
        
    [watchArrayRowIds removeObjectsInArray:presentRows];
        
    if([watchArrayRowIds count])
    {
        for(int i=0; i < [watchArray count]; i++)
        {
            NSMutableArray *eachRowArr = watchArray[i];
            if([watchArrayRowIds containsObject:eachRowArr[3]])
                [watchArray removeObjectAtIndex:i];
        }
    } */


    NSLog(@"Refresh New Rows");
    NSDictionary *newRows = (NSDictionary *)[cubWatch getNewRows] ;
    
    if ([newRows count])
    {
        
        NSLog(@"Data returned from server");
        
        
        NSMutableArray *mutarrNewRows =[cubWatch GetRow];
        //NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        
        //re-arrange data in watch format and get it in an array
        mutarrNewRows = [common prepareDataFromBuffer:mutarrNewRows ColNames:arrSelColNames RowIdCol:@"RowId"];
        
        // add data        
        NSPredicate *predicate = nil;
        NSString *col1 = nil;
        NSString *col2 = nil;
        NSString *col3 = nil;
        NSString *strRowId = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrNewRows)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] init];
            for (NSString *key in mutdictRow)
            {
                predicate = [NSPredicate predicateWithFormat:@"(%@ ==[c] %@)", strTagColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col1 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ ==[c] %@)", strValColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ ==[c] %@)", strTimeColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                {
                    col3 = [mutdictRow valueForKey:key];
                    col3 = [common dateFromGMTtoLocal:col3];
                }
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ ==[c] %@)", rowColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    strRowId = [mutdictRow valueForKey:key];
                
            }

            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B51",col1]];
            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B51",col2]];
            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B51",col3]];
            [arrRow addObject:strRowId];
            
            
           [newRows enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
               
               NSLog(@"%@ => %@", key, value);
               NSString *prevRowId = (NSString *)key;
               NSString *newRowId = (NSString *)value;
               
               if([newRowId isEqualToString:[NSString stringWithFormat:@"%@",arrRow[3]]])
                {
                    Boolean exit = 0;
                    for(NSArray *eachRow in watchArray)
                    {
                        if([prevRowId isEqualToString:@"-1"])
                        {
                            int prevRowIndex = [watchArray indexOfObject:eachRow];
                            [watchArray insertObject:arrRow atIndex:prevRowIndex +1];
                            exit = 1;
                        }
                        if([[NSString stringWithFormat:@"%@",eachRow[3]]isEqualToString:prevRowId])
                        {
                            int prevRowIndex = [watchArray indexOfObject:eachRow];
                            [watchArray insertObject:arrRow atIndex:prevRowIndex +1];
                            exit = 1;
                            
                        }
                        if(exit == 1)
                            break;
                    }
                }
               
               
            }];
            
        }
        
        
        
    }
    else{
        NSLog(@"No changes from the cloud");
    }
    // reload data to show the changes on display
    [self.watchCollectionView reloadData];
    NSLog(@"Reload Data Done");
    
    [refreshControlObj endRefreshing];
    NSLog(@"Refresh Ends");
}

#pragma mark – UICollectionViewDelegateFlowLayout

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *cellData = watchArray[indexPath.section][indexPath.row];
    
  //  return [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:nil];
    
    return CGSizeMake(100, 100);
    
} */
    


@end

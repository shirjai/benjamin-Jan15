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
    
   cell.cellLabel.frame=CGRectMake(12, 13, 98, 0);
    
    cell.cellLabel.text=watchArray[indexPath.section][indexPath.row];
    
    //NSLog(@"cellValue at Section%d Row%d = %@",indexPath.section,indexPath.row, cell.cellLabel.text);
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
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
    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"watchProperties"];
    
    //assign query id
    NSString *queryId = [propDict objectForKey:@"queryId"];//@"68";
    //assign tagValue cuboid id
    int intWatchTagValId = [[propDict objectForKey:@"tableId"] intValue];//2000284;
    
    ExternalQuery *extQueryObj = [[ExternalQuery alloc] init];
    NSString *requestBuffer = [extQueryObj getExternalData :intWatchTagValId :@" " :queryId :@"20000234|88"];
    NSArray *response = [extQueryObj ExtractResponseExternalData :requestBuffer];
    
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
    NSString *strUserColName    = [propDict objectForKey:@"userColName"];
    NSString *strCubColName    = [propDict objectForKey:@"cubColName"];
    NSMutableString *strOnDemandParam = [[propDict objectForKey:@"dynamicQuery"] mutableCopy];     
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
                        if([aKey isEqualToString:strTagColName])
                            watchArray[watchArrCnt][0] = (NSString *)[eachCell objectForKey:aKey];
                        if([aKey isEqualToString:strValColName])
                            watchArray[watchArrCnt][1] = (NSString *)[eachCell objectForKey:aKey];
                        if([aKey isEqualToString:strTimeColName])
                        {
                            NSString *time = (NSString *)[eachCell objectForKey:aKey];
                            watchArray[watchArrCnt][2]  = [common dateFromExcelSerialDate:[time doubleValue]];
                            //watchArray[watchArrCnt][2] = (NSString *)[eachCell objectForKey:aKey];
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
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTagColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col1 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strValColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTimeColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                {
                    col3 = [mutdictRow valueForKey:key];
                    col3 = [common dateFromExcelSerialDate:[col3 doubleValue]];
                }
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", rowColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    strRowId = [mutdictRow valueForKey:key];
                
            }
            
            [arrRow addObject:col1];
            [arrRow addObject:col2];
            [arrRow addObject:col3];
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

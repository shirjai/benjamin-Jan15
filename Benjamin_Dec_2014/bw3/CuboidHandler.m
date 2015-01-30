//
//  CuboidHandler.m
//  bw3
//
//  Created by Shirish Jaiswal on 11/7/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "CuboidHandler.h"
#import "CuboidViewController.h"
#import "AppDelegate.h"
#import "LinkImport.h"
#import "common.h"
#import "Database.h"
#import "WBclass.h"
#import "Submit.h"

@implementation CuboidHandler

-(NSArray *)loadBenjaminWatch{
    
    NSMutableArray *watchRowArray = [[NSMutableArray alloc]init];
    

    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"CuboidProperties"];
    
    //assign watch properties
    NSInteger *intWatchTagValId = [[propDict objectForKey:@"tableId"] integerValue];//2000284;
    
    NSString *rowColName        = [propDict objectForKey:@"rowIdKey"];//@"RowId";
    NSString *strCol1     = [propDict objectForKey:@"col1"];
    NSString *strCol2     = [propDict objectForKey:@"col2"];
    NSString *strCol3    = [propDict objectForKey:@"col3"];
    NSString *strCol4    = [propDict objectForKey:@"col4"];
    NSString *strCol5    = [propDict objectForKey:@"col5"];
    NSString *strCol6    = [propDict objectForKey:@"col6"];
    NSString *strCol7    = [propDict objectForKey:@"col7"];
    NSString *strCol8    = [propDict objectForKey:@"col8"];
    
    NSString *strCritCol1    = [propDict objectForKey:@"critCol1"];
    NSString *strCritCol2   = [propDict objectForKey:@"critCol2"];
    NSMutableString *strOnDemandParam = [[propDict objectForKey:@"dynamicQuery"] mutableCopy]; //@"?UserId="
    
 
/*     // get cuboidIds
    NSString *critSeparator = [NSString stringWithFormat:@"|%@=",strCritCol1];
    WBclass *WBC = [[WBclass alloc]init];
    NSArray *WorkbookNames = [WBC getworkbooks];
    
   NSMutableArray *arrCuboidId = [[NSMutableArray alloc] init];
    NSString *cuboidCriteria = [[NSString alloc] init];
    
    for(NSString *eachWorkbook in WorkbookNames)
    {
        WBDetails *accessibleCuboid = [WBC GetWorkbookDetails:eachWorkbook];
        NSMutableArray *accessCuboidIds = [accessibleCuboid GetCuboidId];
        
        [arrCuboidId addObject:[accessCuboidIds componentsJoinedByString:critSeparator]];
    }
    
    if([arrCuboidId count] == 1)
        cuboidCriteria = arrCuboidId[0];
    else
        cuboidCriteria = [arrCuboidId componentsJoinedByString:critSeparator];
 

    // prepare dynamic query
    NSRange rngUserId = [strOnDemandParam rangeOfString: [NSString stringWithFormat:@"%@=",strCritCol2]];
    
    if (rngUserId.location != NSNotFound) {
        NSInteger indexInsert = rngUserId.location + rngUserId.length;
        [strOnDemandParam insertString:UserIDVal atIndex:indexInsert];
    }
    
    rngUserId = [strOnDemandParam rangeOfString: [NSString stringWithFormat:@"%@=",strCritCol1]];
    */
/*    if (rngUserId.location != NSNotFound) {
        NSInteger indexInsert = rngUserId.location + rngUserId.length;
        [strOnDemandParam insertString:cuboidCriteria atIndex:indexInsert];
    } */
        
    LinkImport *linkImportWatch = [LinkImport alloc];
    
    
    // ondemand link import cuboid
    Cuboid *cuboidTagVal = [linkImportWatch LinkImportApiOnDemand:intWatchTagValId onDemandParam:strOnDemandParam];
    
    int TagValTableId = [cuboidTagVal GetTableId];
 
    if ( TagValTableId != 0)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *mutarrRowTagVal =[cuboidTagVal GetRow];
        NSMutableArray *mutarrTagVal = [[NSMutableArray alloc] init];
        NSArray *arrSelColNames = [NSArray arrayWithObjects: rowColName,strCol1, strCol2, strCol3, strCol4,strCol5,strCol6,strCol7,strCol8, nil];
        
        //re-arrange data in watch format and get it in an array
        mutarrTagVal = [common prepareDataFromBuffer:mutarrRowTagVal ColNames:arrSelColNames RowIdCol:rowColName];
        
        // add header
        [watchRowArray addObject:arrSelColNames];
        
      /*  NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:0];
        for (int i=1; i<[arrSelColNames count]; i++) {
            [indexes addIndex:i];
        }
        [watchArray insertObjects:arrSelColNames atIndexes:indexes]; */
        
        // add data
         NSLog(@"Adding data to array for display");
        NSPredicate *predicate = nil;
        NSString *col1 = nil;
        NSString *col2 = nil;
        NSString *col3 = nil;
        NSString *col4 = nil;
        NSString *col5 = nil;
        NSString *col6 = nil;
        NSString *col7 = nil;
        NSString *col8 = nil;
        
        NSString *strRowId = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrTagVal)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] init];
            for (NSString *key in mutdictRow)
            {
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol1, key];
                if([predicate evaluateWithObject:mutdictRow])
                     col1 = [mutdictRow valueForKey:key];
 
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol2, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];

                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol3, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col3 = [mutdictRow valueForKey:key];

                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol4, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col4 = [mutdictRow valueForKey:key];

                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol5, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col5 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol6, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col6 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol7, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col7 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strCol8, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col8 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", @"RowId", key];
                if([predicate evaluateWithObject:mutdictRow])
                    strRowId = [mutdictRow valueForKey:key];
            }
            
            [arrRow addObject:strRowId];
            [arrRow addObject:col1];
            [arrRow addObject:col2];
            [arrRow addObject:col3];
            [arrRow addObject:col4];
            [arrRow addObject:col5];
            [arrRow addObject:col6];
            [arrRow addObject:col7];
            [arrRow addObject:col8];
            
            [watchRowArray addObject:arrRow];
        }    

    }
    else{
        NSLog(@"No data returned from server");
    }
    
    return [watchRowArray copy];
}

// navigate screen to Benjamin Watch
-(void)callBenjaminWatch:(MainVC *)mainVCObj :(NSArray *)watchRowArray
{
    NSLog(@"Initialize CuboidViewController");
    
    CuboidViewController  *watchVC = [[CuboidViewController alloc] initWithNibName:@"CuboidViewController" bundle:nil];
    
    
    NSLog(@"Initialize navigationcontroller");
    UINavigationController *watchNavCtrl = [[UINavigationController alloc] initWithRootViewController:watchVC];
    
    NSLog(@"Set viewcontroller for navigationcontroller");
    [watchNavCtrl setViewControllers:[NSArray arrayWithObject:mainVCObj]];
    
    NSLog(@"Initialize appdelegate");
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"Set rootviewcontroller in appdelegate");
    NSLog(@"appDelegate: %@",appDelegate);
    NSLog(@"appDelegate.window: %@",appDelegate.window);
    NSLog(@"watchNavCtrl: %@",watchNavCtrl);
    NSLog(@"watchVC: %@",watchVC);
    
    //appDelegate.window.rootViewController = watchNavCtrl;
    [appDelegate.window setRootViewController:watchNavCtrl];
    // [appDelegate.window makeKeyAndVisible];
    
    NSLog(@"Push CuboidViewController to current view ");
    
    [mainVCObj.navigationController pushViewController:watchVC animated:YES];
    
    NSLog(@"Add data to Array of CuboidViewController for display");
    watchVC.watchArray   = [[NSMutableArray alloc]init];
    
    [[watchVC watchArray] addObjectsFromArray:watchRowArray];
    
    NSLog(@"Code block loadBenjaminWatch ends");
    
}

+(void)submitNotes:(NSDictionary *)dictChanges{
    
    //set a cuboid object from the incoming dictonary object
    Cuboid *submitCub = [[Cuboid alloc] init];
    
    NSString *rowId = [[dictChanges allKeys] objectAtIndex:0];
    NSString *colParam = [dictChanges objectForKey:rowId];
    NSString *colName = [[colParam componentsSeparatedByString:@":"] objectAtIndex:0];
    NSString *colVal = [[colParam componentsSeparatedByString:@":"] objectAtIndex:1];
    
    Row *newRow = [[Row alloc]init];
    [newRow setRowid: [rowId intValue]];
    [newRow setColumnData:colName :colVal];

    [submitCub SetTableId:2000284];
    NSMutableArray *changes = [[NSMutableArray alloc] init];
    [changes addObject:newRow];
    [submitCub SetRow:changes];
    
    [[[Submit alloc]init] SubmitAPI:submitCub];
    
}
@end

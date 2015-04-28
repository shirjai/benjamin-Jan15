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

-(NSArray *)loadBenjaminCuboid :(NSInteger )cuboidId {
    
    NSMutableArray *watchRowArray = [[NSMutableArray alloc]init];
    

    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"CuboidProperties"];
    
    //assign watch properties
    NSInteger *intWatchTagValId = cuboidId;//[[propDict objectForKey:@"tableId"] integerValue];//2000284;
    
    NSString *rowColName  = [propDict objectForKey:@"rowIdKey"];//@"RowId";
    
    //get the colPositions to be displayed.
    NSMutableString *strColsPos = [[propDict objectForKey:@"colPos"] mutableCopy];
    NSMutableArray *strColsPosArr = (NSMutableArray *)[strColsPos componentsSeparatedByString:@","] ;
    
    // max rows to be displayed due to limited memory
    NSInteger integerRowCnt = [[propDict objectForKey:@"rowCount"] integerValue];
    
   // NSMutableString *strOnDemandParam = [[propDict objectForKey:@"dynamicQuery"] mutableCopy]; //@"?UserId="
    
    // linkImport cuboid
    LinkImport *linkImportCuboid = [LinkImport alloc];
    Cuboid *cuboidTagVal = [linkImportCuboid LinkImportApi:intWatchTagValId];
    int TagValTableId = [cuboidTagVal GetTableId];
 
    if ( TagValTableId != 0)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *arrRowTagValFull =[cuboidTagVal GetRow];
        NSMutableArray *mutarrRowTagVal =[[NSMutableArray alloc] init];
        if ([arrRowTagValFull count] > integerRowCnt) {
            NSArray *arrRowTagValTemp = [arrRowTagValFull subarrayWithRange:NSMakeRange(0,integerRowCnt)];
            mutarrRowTagVal = [arrRowTagValTemp mutableCopy];
        }
        else
            mutarrRowTagVal = [arrRowTagValFull mutableCopy];
        
        arrRowTagValFull = nil;
        NSMutableArray *mutarrTagVal = [[NSMutableArray alloc] init];
        
        // add the first column as RowId column
        NSMutableArray *arrSelColNames = [NSMutableArray arrayWithObjects: rowColName, nil];
        
        // get all cols for cuboid.Assuming colNames are in sequence
        NSArray *cubCols = [mutarrRowTagVal[0] GetColNames];
        
        // prepare selected col header array
        [cubCols enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSString *cubColName = (NSString *)obj;
            NSString *cubColPos = [NSString stringWithFormat:@"%lu",(idx + 1)] ;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",cubColPos];
            NSUInteger selColCount = [[strColsPosArr filteredArrayUsingPredicate:predicate] count];
            if (selColCount > 0){
                [arrSelColNames addObject:cubColName];
                [strColsPosArr removeObject:cubColPos];
            }
            if ([strColsPosArr count] == 0 ) {
                *stop = YES;
            }
        }
        ];
        
                
        //re-arrange data in colname:value format and get it in an array
        mutarrTagVal = [common prepareOrderedDataFromBuffer:mutarrRowTagVal ColNames:arrSelColNames RowIdCol:rowColName];
        
        // add col header
        [watchRowArray addObject:arrSelColNames];
        
      /*  NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:0];
        for (int i=1; i<[arrSelColNames count]; i++) {
            [indexes addIndex:i];
        }
        [watchArray insertObjects:arrSelColNames atIndexes:indexes]; */
        
        // add data
         NSLog(@"Adding data to array for display");
        int colPos = -1;
        NSMutableString *colName = nil;
        
        // loop through all the rows
        for(NSArray *mutdictRow in mutarrTagVal)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] initWithCapacity:[arrSelColNames count]];
            for (int i = 0; i < [arrSelColNames count]; i++)
                [arrRow addObject:[NSNull null]];
            
            // loop through all the columns of a single row
            for (NSString *key in mutdictRow)
            {
                NSLog(@"colPosition->%@",[common getSubstring:key defineStartChar:@"" defineEndChar:@":"]);
                colPos = [[common getSubstring:key defineStartChar:@"" defineEndChar:@":"] intValue];
               // [colName setString:[common getSubstring:key defineStartChar:@":" defineEndChar:@""]];
                
               // NSPredicate *predicateColName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",colName];
                
                //[[arrSelColNames filteredArrayUsingPredicate:predicateColName] objectAtIndex:0];
                
                [arrRow replaceObjectAtIndex:colPos withObject:[mutdictRow valueForKey:key]];
                
            }            
            
            [watchRowArray addObject:arrRow];
        }    

    }
    else{
        NSLog(@"No data returned from server");
    }
    
    return [watchRowArray copy];
}

// navigate screen to Grid View
-(void)callBenjaminCuboid:(MainVC *)mainVCObj :(NSArray *)watchRowArray :(NSString *)cuboidName
{
    NSLog(@"Initialize CuboidViewController");
    
    CuboidViewController  *watchVC = [[CuboidViewController alloc] initWithNibName:@"CuboidViewController" bundle:nil];
    
    
    NSLog(@"Initialize navigationcontroller");
    UINavigationController *watchNavCtrl = [[UINavigationController alloc] initWithRootViewController:watchVC];
    
    NSLog(@"Set viewcontroller for navigationcontroller");
    [watchNavCtrl setViewControllers:[NSArray arrayWithObject:mainVCObj]];
    
    NSLog(@"Initialize appdelegate");
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
    //appDelegate.window.rootViewController = watchNavCtrl;
    [appDelegate.window setRootViewController:watchNavCtrl];
    // [appDelegate.window makeKeyAndVisible];
    
    NSLog(@"Push CuboidViewController to current view ");
    [mainVCObj.navigationController pushViewController:watchVC animated:YES];
    
    
    NSLog(@"Add data to Array of CuboidViewController for display");
    watchVC.watchArray   = [[NSMutableArray alloc]init];
    watchVC.CuboidName = cuboidName;
    
    [[watchVC watchArray] addObjectsFromArray:watchRowArray];
    
    NSLog(@"Code block loadBenjaminWatch ends");
    
}

+(void)submitNotes:(NSDictionary *)dictChanges{
    
    //set a cuboid object from the incoming dictonary object
    Cuboid *submitCub = [[Cuboid alloc] init];
    NSMutableArray *changes = [[NSMutableArray alloc] init];
    for (NSString *rowId in [dictChanges allKeys]){
    
   // NSString *rowId = [[dictChanges allKeys] objectAtIndex:0];
    NSString *colParam = [dictChanges objectForKey:rowId];
    NSString *colName = [[colParam componentsSeparatedByString:@":"] objectAtIndex:0];
    NSString *colVal = [[colParam componentsSeparatedByString:@":"] objectAtIndex:1];
    
    Row *newRow = [[Row alloc]init];
    [newRow setRowid: [rowId intValue]];
    [newRow setColumnData:colName :colVal];
    [changes addObject:newRow];
    }
    
    [submitCub SetTableId:2000268];


    [submitCub SetRow:changes];
    
    [[[Submit alloc]init] SubmitAPI:submitCub];
    
}
@end

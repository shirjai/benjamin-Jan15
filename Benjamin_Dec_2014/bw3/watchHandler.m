//
//  watchHandler.m
//  bw3
//
//  Created by Shirish Jaiswal on 11/7/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "watchHandler.h"
#import "watchViewController.h"
#import "AppDelegate.h"
#import "LinkImport.h"
#import "common.h"
#import "Database.h"
#import "WBclass.h"

@implementation watchHandler

-(NSArray *)loadBenjaminWatch{
    
    NSMutableArray *watchRowArray = [[NSMutableArray alloc]init];
    
    NSCharacterSet *chngSeparator = [NSCharacterSet
                                characterSetWithCharactersInString:@"\u00B5"];

    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"watchProperties"];
    
    //assign watch properties
    NSInteger *intWatchTagValId = [[propDict objectForKey:@"tableId"] integerValue];//2000284;
    
    NSString *rowColName        = [propDict objectForKey:@"rowIdKey"];//@"RowId";
    NSString *strTagColName     = [propDict objectForKey:@"tagValCol"]; //@"Tag Name";
    NSString *strValColName     = [propDict objectForKey:@"valCol"]; //@"Value";
    NSString *strTimeColName    = [propDict objectForKey:@"timeStampCol"];//@"Timestamp";
    NSString *strUserColName    = [propDict objectForKey:@"userColName"];
    NSString *strCubColName     = [propDict objectForKey:@"cubColName"];
    NSString *strOnDemandParam ;
    
    //get userid
    Database *db =[Database alloc];
    [db getPropertiesFile];
    NSString *UserIDVal    = [db GetPropertyValue:@"UserName"];
    db = nil;
    
    // get cuboidIds
    //NSString *critSeparator = [NSString stringWithFormat:@"|%@=",strCubColName];
    NSString *critSeparator = [NSString stringWithFormat:@"&%@|%@=",strUserColName,strCubColName];
    
    WBclass *WBC = [[WBclass alloc]init];
    NSArray *WorkbookNames = [WBC getworkbooks];
    
    NSMutableArray *arrCuboidId = [[NSMutableArray alloc] init];
    NSMutableString *cuboidCriteria = [[NSMutableString alloc] init];
    
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
    

    [cuboidCriteria setString: [cuboidCriteria stringByReplacingOccurrencesOfString:
            [NSString stringWithFormat:@"%@",strUserColName]
            withString:[NSString stringWithFormat:@"%@=%@",strUserColName,UserIDVal]]];
    
    // prepare dynamic query
    /*
    NSRange rngUserId = [strOnDemandParam rangeOfString: [NSString stringWithFormat:@"%@=",strUserColName]];
    
    if (rngUserId.location != NSNotFound) {
        NSInteger indexInsert = rngUserId.location + rngUserId.length;
        [strOnDemandParam insertString:UserIDVal atIndex:indexInsert];
    }
    
    rngUserId = [strOnDemandParam rangeOfString: [NSString stringWithFormat:@"%@=",strCubColName]];
    
    if (rngUserId.location != NSNotFound) {
        NSInteger indexInsert = rngUserId.location + rngUserId.length;
        [strOnDemandParam insertString:cuboidCriteria atIndex:indexInsert];
    } */
    
    strOnDemandParam = [NSString stringWithFormat:@"?%@=%@&%@=%@",strCubColName,cuboidCriteria,strUserColName,UserIDVal];
    
    LinkImport *linkImportWatch = [LinkImport alloc];
    
    
    // ondemand link import cuboid
    Cuboid *cuboidTagVal = [linkImportWatch LinkImportApiOnDemand:intWatchTagValId onDemandParam:strOnDemandParam];
    
    int TagValTableId = [cuboidTagVal GetTableId];
    if ( TagValTableId != 0)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *mutarrRowTagVal =[cuboidTagVal GetRow];
        NSMutableArray *mutarrTagVal = [[NSMutableArray alloc] init];
        NSArray *arrSelColNames = [NSArray arrayWithObjects: strTagColName, strValColName, strTimeColName, rowColName, nil];
        
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
        NSString *strRowId = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrTagVal)
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
                predicate = [NSPredicate predicateWithFormat:@"(%@ ==[c] %@)", @"RowId", key];
                if([predicate evaluateWithObject:mutdictRow])
                    strRowId = [mutdictRow valueForKey:key];
            }
            
            
            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B50",col1]];
            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B50",col2]];
            [arrRow addObject:[NSString stringWithFormat:@"%@\u00B50",col3]];
            [arrRow addObject:strRowId];
            
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
    NSLog(@"Initialize watchViewController");
    
    watchViewController  *watchVC = [[watchViewController alloc] initWithNibName:@"watchViewController" bundle:nil];
    
    
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
    
    NSLog(@"Push watchviewcontroller to current view ");
    
    [mainVCObj.navigationController pushViewController:watchVC animated:YES];
    
    NSLog(@"Add data to Array of watchViewController for display");
    watchVC.watchArray   = [[NSMutableArray alloc]init];
    
    [[watchVC watchArray] addObjectsFromArray:watchRowArray];
    
    NSLog(@"Code block loadBenjaminWatch ends");
    
}

@end

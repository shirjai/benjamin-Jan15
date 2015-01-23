//
//  WIC.m
//  bw3
//
//  Created by Ashish on 7/18/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "WIC.h"
#import "LinkImport.h"
#import "Refresh.h"
#import "Submit.h"
#import "Row.h"
#import "Database.h"
#import "ServerSettingsVC.h"

@implementation WIC
{
    NSInteger *wictbl;
}

-(NSString *)SetWIC
{
    Database *DB = [[Database alloc]init];
    [DB getPropertiesFile];
    
    
    NSString *tableidwic = [DB GetPropertyValue:@"Server1WICID"];
    int tbl = [tableidwic intValue]; //Get this from properties.
    wictbl = tbl;
    LinkImport *LI = [LinkImport alloc];
    Cuboid *wic = [LI LinkImportApi:wictbl];
    
    if([[wic GetRow]count] == 0)
    {
        return @"Failure";
        
    }
    else
        return @"Success";
    
}


-(Cuboid *)GetWBProperties
{
    Database *DB = [[Database alloc]init];
    [DB getPropertiesFile];
    NSString *tableidwic = [DB GetPropertyValue:@"Server1WICID"];
    int tbl = [tableidwic intValue]; //Get this from properties.
    wictbl = tbl;
    
    BwCuboid *WBC = [DB Getcuboid:(int)wictbl];
    Cuboid *cub = [[Cuboid alloc]init];
    [cub SetCuboid:WBC];
    return cub;
}


-(NSInteger *)GetWBProperty:(NSString *)Server :(NSString *)Wbname :(NSString *)PropertyName
{
    WIC *wic = [[WIC alloc]init];
    Cuboid *WBP = [wic GetWBProperties];
    NSString *returntblid;
    int returnid;
    int rowcount = [WBP GetNumRows];
    NSArray *rows = [WBP GetRow];
    
    for(int i =0; i<rowcount;i++)
    {
        Row *r = [rows objectAtIndex:i];
        NSArray *colname = [r GetColNames];
        NSArray *val = [r GetValues];
        for(int j=0;j<[WBP GetNumCols];j++)
        {
            if([[colname objectAtIndex:j] isEqual:@"WorkbookName"])
            {
                if([Wbname isEqualToString:[val objectAtIndex:j]])
                {
                    for(int k=0;k<[WBP GetNumCols];k++)
                    {
                        if([[colname objectAtIndex:k] isEqual:@"CuboidType"])
                        {
                            if([PropertyName isEqualToString:[val objectAtIndex:k]])
                            {
                                for(int l=0;l<[WBP GetNumCols];l++)
                                {
                                    if([[colname objectAtIndex:l] isEqual:@"CuboidID"])
                                    {
                                        returntblid = [val objectAtIndex:l];
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    returnid = [returntblid intValue];
    return returnid;

}



@end

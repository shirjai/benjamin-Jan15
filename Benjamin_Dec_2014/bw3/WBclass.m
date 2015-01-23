//
//  WBclass.m
//  bw3
//
//  Created by Ashish on 5/27/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "WBclass.h"
#import "LinkImport.h"
#import "Cuboid.h"
#import "Row.h"
#import "WIC.h"


@implementation WBclass

-(NSArray*)getworkbooks
{
    WIC *wic = [[WIC alloc]init];
    Cuboid *WBP = [wic GetWBProperties];
    NSMutableArray *WorkbookNames = [[NSMutableArray alloc]init];
    
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
                [WorkbookNames addObject:[val objectAtIndex:j]];
            }
        }
    }
    
    NSSet *temp = [NSSet setWithArray:WorkbookNames];
    WorkbookNames = [temp allObjects];
    NSLog(@"%@", WorkbookNames);
    return WorkbookNames;
}

-(WBDetails *)GetWorkbookDetails:(NSString *)workBookName
{
    WBDetails *WBD = [[WBDetails alloc]init];
    NSMutableArray *cname = [[NSMutableArray alloc]init];
    NSMutableArray *updon = [[NSMutableArray alloc]init];
    NSMutableArray *updby = [[NSMutableArray alloc]init];
    NSMutableArray *Cubid = [[NSMutableArray alloc]init];
    
    WIC *wic = [[WIC alloc]init];
    Cuboid *WBP = [wic GetWBProperties];
    NSMutableArray *WorkbookNames = [[NSMutableArray alloc]init];
    
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
                if([workBookName isEqualToString:[val objectAtIndex:j]])
                {
                    for(int k=0;k<[WBP GetNumCols];k++)
                    {
                        if([[colname objectAtIndex:k] isEqual:@"CuboidName"])
                        {
                            [cname addObject:[val objectAtIndex:k]];
                        }
                        else if([[colname objectAtIndex:k] isEqual:@"Updated By"])
                        {
                            [updby addObject:[val objectAtIndex:k]];
                        }
                        else if([[colname objectAtIndex:k] isEqual:@"Updated On"])
                        {
                            [updon addObject:[val objectAtIndex:k]];
                        }
                        else if([[colname objectAtIndex:k] isEqual:@"CuboidID"])
                        {
                            [Cubid addObject:[val objectAtIndex:k]];
                        }
                    }
                }
                //if([)[val objectAtIndex:j]
            }
        }
    }
    
    //NSSet *temp = [NSSet setWithArray:WorkbookNames];
    //WorkbookNames = [temp allObjects];
    //NSLog(@"%@", WorkbookNames);
    //return WorkbookNames;
    
    [WBD SetCuboidName:cname];
    [WBD SetUpdateOn:updon];
    [WBD SetUpdateBy:updby];
    [WBD SetCuboidId:Cubid];
    return WBD;
}

@end

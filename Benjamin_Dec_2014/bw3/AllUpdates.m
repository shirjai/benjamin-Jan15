//
//  AllUpdates.m
//  bw4
//
//  Created by Srinivas on 10/20/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "AllUpdates.h"
#import "Updates.h"

@implementation AllUpdates
{
    NSArray *AllUpdatesArr;
}

-(void)SetAllupdatesArray:(int)TableId :(NSString *)view :(NSString *)period
{
    
    AllUpdatesArr = [[NSMutableArray alloc]init];
    
    Updates *upd = [[Updates alloc]init];
    AllUpdatesArr = [upd AllupdatesApi:TableId :view :period];
    
}

-(NSArray *)GetArrayAllUpdates
{
    return AllUpdatesArr;
}

@end

//
//  MissingUpdates.m
//  bw4
//
//  Created by Srinivas on 10/23/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "MissingUpdates.h"
#import "Updates.h"

@implementation MissingUpdates

-(NSArray *)GetArrayAllUpdates:(int)TableId
{
    NSArray *AllUpdatesArr = [[NSArray alloc]init];
    
    Updates *upd = [[Updates alloc]init];
    AllUpdatesArr = [upd MissingupdatesApi:TableId];
    
    return AllUpdatesArr;
}


@end

//
//  WBDetails.m
//  bw4
//
//  Created by Srinivas on 10/8/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "WBDetails.h"

@implementation WBDetails
{
    NSMutableArray *CuboidName;
    NSMutableArray *updatedBy;
    NSMutableArray *updatedOn;
    NSMutableArray *CuboidId;
}

-(void)SetCuboidName:(NSArray *)Cname
{
    CuboidName = Cname;
}

-(void)SetUpdateBy:(NSArray *)UpdateBy
{
    updatedBy = UpdateBy;
}

-(void)SetUpdateOn:(NSArray *)UpdateOn
{
    updatedOn = UpdateOn;
}

-(void)SetCuboidId:(NSArray *)CubId
{
    CuboidId = CubId;
}


-(NSMutableArray *)GetCuboidName
{
    return CuboidName;
}

-(NSMutableArray *)GetUpdatedBy
{
    return updatedBy;
}

-(NSMutableArray *)GetupdatedOn
{
    return updatedOn;
}

-(NSMutableArray *)GetCuboidId
{
    return CuboidId;
}


@end

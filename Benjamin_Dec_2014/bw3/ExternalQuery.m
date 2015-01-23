//
//  ExternalQuery.m
//  bw3
//
//  Created by Shirish Jaiswal on 12/5/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "ExternalQuery.h"
//#import "Buffer.h"
#import "Http.h"
#import "Database.h"

@implementation ExternalQuery

-(NSString *)getExternalData :(int)TableId :(NSString *)strReportName :(NSString *)strQueryId :(NSString *)strQueryParams
{
    //NSString *CallBuff = [self GetBufferExternalData:TableId :@" " :@"68" :@" "];
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    
    //get existing cuboid from local database
    int tableID = TableId;
    Database *DB = [[Database alloc]init];
   // BwCuboid *BWD = [DB Getcuboid:tableID];
    
    [DB getPropertiesFile];
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    
    //create the buffer from properties of cuboid
    NSString *reqBuffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",UserID,seperator,UserName,seperator,strReportName,seperator,strQueryId,seperator,strQueryParams,seperator];
    
    
    
    //connect to server and link import the cuboid
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk :reqBuffer :@"Get_Boardwalk_Template_Prop"];
    
    return Res;
}

/*
-(NSString *)GetBufferExternalData:(NSInteger *)TableID :(NSString *)strReportName :(NSString *)strQueryId :(NSString *)strQueryParams
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    //NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    //get existing cuboid from local database
    int tableID = TableID;
    Database *DB = [[Database alloc]init];
    BwCuboid *BWD = [DB Getcuboid:tableID];
    
    [DB getPropertiesFile];
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    
    //create the buffer from properties of cuboid
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",UserID,seperator,UserName,seperator,strReportName,seperator,strQueryId,seperator,strQueryParams,seperator];
    
    
    NSLog(@"BufferExternalData = %@" ,buffer);
    return buffer;
    
} */

-(NSArray *)ExtractResponseExternalData :(NSString *)ResBuffer
{
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSArray *resArray = [ResBuffer componentsSeparatedByString:ContentDeLimiter];

    NSArray *hdrArray = [resArray[0] componentsSeparatedByString:seperator];
    
    if (![hdrArray[0] isEqual:@"Success"]) {
        resArray = nil;
    }
    
    return resArray;
    
}

@end

//
//  Submit.m
//  bw3
//
//  Created by Srinivas on 9/11/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Submit.h"
#import "Buffer.h"
#import "Http.h"
#import "utilities.h"
#import "Database.h"

@implementation Submit

-(void)SubmitAPI:(Cuboid *)cub
{
    Buffer *Buff = [[Buffer alloc]init];
    NSString *subReq = [Buff GetBufferSubmit:cub];
    Http *BW = [[Http alloc]init];
    NSString *Res;
    NSLog(@"---------------submit----------");
    NSLog(subReq);
    
    NSString *inputbuff = [NSString stringWithFormat:@"t%@",subReq];
    utilities *utl = [utilities alloc];
    NSString *reqbuff = [utl PrepareRequest:inputbuff];
    
    Res = [BW callBoardwalk:subReq :@"xlExportChangesService"];
    
    NSLog(@"---------------response submit-------------------------------");
    NSLog(Res);
    
    cub = [Buff ExtractResponseSubmit:Res:cub];
    //get bw cuboid from database
    Database *DB = [[Database alloc]init];
    BwCuboid *bwc = [DB Getcuboid:[cub GetTableId]];
    //add cuboid to bw cuboid
    bwc = [utl MergeSubmitCuboid:cub :bwc];
    //save cuboid to database
    [DB writeCuboid:bwc];
    
    
}

@end

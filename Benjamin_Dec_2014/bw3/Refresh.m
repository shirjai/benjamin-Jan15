//
//  Refresh.m
//  bw3
//
//  Created by Ashish on 7/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Refresh.h"
#import "Buffer.h"
#import "Http.h"
#import "Database.h"
#import "utilities.h"

@implementation Refresh

-(Cuboid *)RefreshAPI:(int)TableId:(int)mode
{
    Buffer *Buff = [[Buffer alloc] init];
    NSString *BuffRefresh = [Buff GetBufferRefresh:TableId];
    
    //call boardwalk server with refresh buffer
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk:BuffRefresh:@"xlImportChangesService"];
    BwCuboid *CuboidSer = [Buff ExtractResponseRefresh:Res:mode];
    Cuboid *CuboidRef = [[Cuboid alloc]init];
    [CuboidRef SetCuboidRefresh:CuboidSer];
    
    //read the bwcuboid from database then call the merge to add data from cuboid to bwcuboid
    Database *DB = [[Database alloc]init];
    BwCuboid *bwc = [DB Getcuboid:TableId];
    
    utilities *Utl = [[utilities alloc]init];
    bwc = [Utl MergeRefreshCuboid:CuboidRef :bwc];
    [DB writeCuboid:bwc];
    
    return CuboidRef;
}

@end

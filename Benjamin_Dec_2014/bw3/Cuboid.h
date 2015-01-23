//
//  Cuboid.h
//  bw3
//
//  Created by Ashish on 7/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Row.h"

@interface Cuboid : NSObject

-(void)SetCuboid:(BwCuboid*) BWC;
-(void) SetCuboidRefresh:(BwCuboid *)BWC;

-(void)SetRow:(NSMutableArray *)rows;
-(NSMutableArray*)GetRow;

-(void)Settx_id:(int) txid;
-(int)Gettx_id;

-(void)SetNumRows:(int) Rowcount;
-(int)GetNumRows;

-(void)SetNumCols:(int) ColCount;
-(int)GetNumCols;

-(void)SetTableId:(int)tblID;
-(int)GetTableId;

/** added by shirish on 11/27/2014 **/
-(NSArray *)getNewRows;
/** added by shirish on 11/27/2014 **/

@end

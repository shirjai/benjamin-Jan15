//
//  BwCuboid.h
//  bw3
//
//  Created by Ashish on 6/10/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Cuboid.h"

@interface BwCuboid : NSObject

-(void)SetTableId:(int) TblId;
-(int)GetTableId;

-(void)SetTableName:(NSString*) TblName;
-(NSString*)GetTableName;

-(void)SetTableDes:(NSString*) TblDes;
-(NSString*)GetTableDes;

-(void)SetView:(NSString*) Viw;
-(NSString*)GetView;

-(void)SetCriteriaTblId:(int) CrtTblId;
-(int)GetCriteriaTblId;

-(void)SetMode:(int) TblMode;
-(int)GetMode;

-(void)Settx_id:(int) txid;
-(int)Gettx_id;

-(void)SetExportTid:(int) ETid;
-(int)GetExportTid;

-(void)SetNumRows:(int) Rowcount;
-(int)GetNumRows;

-(void)SetNumCols:(int) ColCount;
-(int)GetNumCols;

-(void)SetRowIds:(NSArray *) RowId;
-(NSArray *)GetRowIds;

-(void)SetColumnIds:(NSArray *) ColumnId;
-(NSArray *)GetColumnIds;

-(void)SetColumnNames:(NSArray *) ColumnName;
-(NSArray *)GetColumnNames;

-(void)SetCells:(NSArray *) Cell;
-(NSArray *)GetCells;


/** added by shirish for new rows on refresh 11/24/14 **/

-(void)setNewRows:(NSArray *) newRowsParam;
-(NSArray *)getNewRows;

/** added by shirish for new rows on refresh 11/24/14 **/

@end




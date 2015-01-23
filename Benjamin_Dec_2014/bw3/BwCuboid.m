//
//  BwCuboid.m
//  bw3
//
//  Created by Ashish on 6/10/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "BwCuboid.h"
//#import "Row.h"

@implementation BwCuboid
{
    int TableId;
    NSString *TableName;
    NSString *TableDes;
    NSString *View;
    int CriteriaTblId;
    int Mode;
    int tx_id;
    int ExportTid;
    int NumRows;
    int NumCols;
    NSArray *RowIds;
    NSArray *ColumnIds;
    NSArray *ColumnNames;
    NSArray *Cells;
    
    /** added by shirish for new rows on refresh 11/24/14 **/
    NSArray *newRows;
    /** added by shirish for new rows on refresh 11/24/14**/
}

//-----
-(void)SetTableId:(int) TblId
{
    TableId = TblId;
}

-(int)GetTableId
{
    return TableId;
}

//-----
-(void)SetTableName:(NSString*) TblName
{
    TableName = TblName;
}

-(NSString*)GetTableName
{
    return TableName;
}

//-----
-(void)SetTableDes:(NSString*) TblDes
{
    TableDes = TblDes;
}

-(NSString*)GetTableDes
{
    return TableDes;
}

//-----
-(void)SetView:(NSString*) Viw
{
    View = Viw;
}

-(NSString*)GetView
{
    return View;
}

//-----
-(void)SetCriteriaTblId:(int) CrtTblId
{
    CriteriaTblId = CrtTblId;
}

-(int)GetCriteriaTblId
{
    return CriteriaTblId;
}

//-----
-(void)SetMode:(int) TblMode
{
    Mode = TblMode;
}

-(int)GetMode
{
    return  Mode;
}

//-----
-(void)Settx_id:(int) txid
{
    tx_id =txid;
}

-(int)Gettx_id
{
    return tx_id;
}

//-----
-(void)SetExportTid:(int) ETid
{
    ExportTid = ETid;
}

-(int)GetExportTid
{
    return ExportTid;
}

//-----
-(void)SetNumRows:(int) Rowcount
{
    NumRows = Rowcount;
}

-(int)GetNumRows
{
    return NumRows;
}

//-----
-(void)SetNumCols:(int) ColCount
{
    NumCols = ColCount;
}

-(int)GetNumCols
{
    return NumCols;
}

//-----
-(void)SetRowIds:(NSArray *) RowId
{
    RowIds = RowId;
}

-(NSArray *)GetRowIds
{
    return  RowIds;
}

//-----
-(void)SetColumnIds:(NSArray *) ColumnId
{
    ColumnIds = ColumnId;
}

-(NSArray *)GetColumnIds
{
    return ColumnIds;
}

//-----
-(void)SetColumnNames:(NSArray *) ColumnName
{
    ColumnNames = ColumnName;
}

-(NSArray *)GetColumnNames
{
    return ColumnNames;
}

//-----
-(void)SetCells:(NSArray *) Cell
{
    Cells = Cell;
}

-(NSArray *)GetCells
{
    return Cells;
}

/** added by shirish for new rows on refresh 11/24/14 **/
-(void)setNewRows:(NSArray *) newRowsParam
{
    newRows = newRowsParam;
}

-(NSArray *)getNewRows
{
    return newRows;
}
/** added by shirish for new rows on refresh 11/24/14 **/

@end

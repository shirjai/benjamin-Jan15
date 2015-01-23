//
//  Cuboid.m
//  bw3
//
//  Created by Ashish on 7/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Cuboid.h"

@implementation Cuboid{
    
    int TableId;
    NSString *TableName;
    int NumRows;
    int NumCols;
    int tx_id;
    //array of row objects
    NSMutableArray *Rows;
    
    /** added by shirish on 11/27/2014 **/
    //array of new row and corresponding previous row
    NSArray *newRows;
    /** added by shirish on 11/27/2014 **/
}

-(void)SetCuboid:(BwCuboid *)BWC
{
    TableId = [BWC GetTableId];
    TableName = [BWC GetTableName];
    NumRows = [BWC GetNumRows];
    NumCols = [BWC GetNumCols];
    Rows = [[NSMutableArray alloc] init];
    
    NSArray *RowIds = [[NSArray alloc] init];
    NSArray *ColumnNames = [[NSArray alloc] init];
    NSArray *Cells = [[NSArray alloc] init];
    
    RowIds = [BWC GetRowIds];
    ColumnNames = [BWC GetColumnNames];
    Cells = [BWC GetCells];
    
    for(int i = 0; i < NumRows; i++)
    {
        Row *R1 = [[Row alloc] init];
        [R1 setRowid:[[RowIds objectAtIndex:i] intValue]];
        
        for(int j= 0 ;j<NumCols;j++)
        {
            [R1 setColumnData:[ColumnNames objectAtIndex:j] :[Cells objectAtIndex:(i+(j*NumRows))]];
        }
    
    [Rows addObject:R1];
    }
    
    /** added by shirish on 11/27/2014 **/
    //new row array not required during linkImport
    newRows = nil;
    /** added by shirish on 11/27/2014 **/
}



-(void)SetCuboidRefresh:(BwCuboid *)BWC
{
    Rows = [[NSMutableArray alloc] init];
    
    int rowid = -1;
    
    NSArray *cellv = [BWC GetCells];
    NSArray *rowids = [BWC GetRowIds];
    NSArray *colid = [BWC GetColumnIds];
    NSArray *colname = [BWC GetColumnNames];
    Row *R1;
    
    NumCols = [BWC GetNumCols];
    NumRows = [BWC GetNumRows];
    tx_id = [BWC Gettx_id];
    
    if([cellv count]>0)
    {
    
    for(int i = 0; i < [cellv count]; i++)
    {
        if(rowid != [[rowids objectAtIndex:i] intValue])
        {
            if(i>0)
            {
                 [Rows addObject:R1];
            }
             R1 = [[Row alloc] init];
            [R1 setRowid:[[rowids objectAtIndex:i] intValue]];
        }
        
        [R1 setColumnData:[colname objectAtIndex:i] :[cellv objectAtIndex:i]];

        rowid = [[rowids objectAtIndex:i] intValue];
        
    }
    [Rows addObject:R1];
    }
    
    /** added by shirish on 11/27/2014 **/
    //array of new row and corresponding previous row
    newRows = [BWC getNewRows];
    /** added by shirish on 11/27/2014 **/
    
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
-(void)SetRow:(NSMutableArray *)rows
{
    Rows = rows;
}

-(NSMutableArray *)GetRow
{
    return Rows;
}


//-----
-(void)SetTableId:(int)tblID
{
    TableId = tblID;
}
-(int)GetTableId
{
    return  TableId;
}


/** added by shirish on 11/27/2014 **/
-(NSArray *)getNewRows{
    return newRows;
}
/** added by shirish on 11/27/2014 **/


@end

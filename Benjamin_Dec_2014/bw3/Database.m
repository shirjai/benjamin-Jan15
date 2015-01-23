//
//  Database.m
//  bw3
//
//  Created by Ashish on 5/27/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Database.h"

@implementation Database
{
    NSMutableArray *ProperiesArry;
}

-(void)getPropertiesFile
{
    ProperiesArry = [[NSMutableArray alloc]init];
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    //setup path and file name to write the properties
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:@"Properties.txt"]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :@"Properties.txt"]];
    
    bool fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullpath];
    if(!fileExists)
    {
        [NFM createFileAtPath:fullpath contents:nil attributes:nil];
    }

    
    NSString *PropData = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];
    ProperiesArry = [PropData componentsSeparatedByString:seperator];
    
}

-(void)writePropertiesFile
{
    
    //convert array to string Name1=value1;name2=value2
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    
    if([ProperiesArry count] > 0)
    {
    NSString *Properties = [ProperiesArry componentsJoinedByString:seperator];
    
    //write to file
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    //setup path and file name to write the properties
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:@"Properties.txt"]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :@"Properties.txt"]];
    
    bool fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullpath];
    if(!fileExists)
    {
        [NFM createFileAtPath:fullpath contents:nil attributes:nil];
    }
    
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
    NSData *PropStr;
    const char *bytecount = [Properties UTF8String];
    PropStr = [NSData dataWithBytes:bytecount length:strlen(bytecount)];
    [PropStr writeToFile:fullpath atomically:YES];
    
    }
}


-(void)UpdateProperties:(NSString *)Name :(NSString *)Value
{
    NSMutableArray *ProperiesArry1 = [ProperiesArry mutableCopy];
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    bool found = NO;
    NSString *prop = [NSString stringWithFormat:@"%@=%@",Name,Value];

    NSInteger len = [ProperiesArry1 count];
    if (len == 1)
    {
         NSString *propstrarr = [ProperiesArry1 objectAtIndex:0];
        if([propstrarr isEqualToString:@""])
        {
         ProperiesArry1 = [[NSMutableArray alloc]init];
        }
    }
    len = [ProperiesArry1 count];
    for (int i = 0; i<len; i++)
    {
        NSString *propstr = [ProperiesArry1 objectAtIndex:i];
        NSMutableArray *proparr = [propstr componentsSeparatedByString:@"="];
        if([[proparr objectAtIndex:0] isEqualToString:Name])
        {
            [ProperiesArry1 replaceObjectAtIndex:i withObject:prop];
            found = YES;
        }
        
    }
    if(found == NO)
    {
        @try{
        NSLog(@"----database---=%d",len);
        [ProperiesArry1 addObject:prop];
        }
    @catch (NSException *e) {
        NSLog(e);
    }
    }
    
    ProperiesArry = ProperiesArry1;
}



-(NSString *)GetPropertyValue:(NSString *)Name
{
    NSMutableArray *ProperiesArry1 = [ProperiesArry mutableCopy];
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *returnValue;
    
    NSInteger len = [ProperiesArry1 count];
    for (int i = 0; i<len; i++)
    {
        NSString *propstr = [ProperiesArry1 objectAtIndex:i];
        NSMutableArray *proparr = [propstr componentsSeparatedByString:@"="];
        if([[proparr objectAtIndex:0] isEqualToString:Name])
        {
            returnValue = [proparr objectAtIndex:1];
        }
    }
    
    return returnValue;
}

-(void)writeCuboid:(BwCuboid *)BWC
{
    
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter;
    ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSString *WriteToDb;
    NSString *TempStr;
    TempStr = [NSString stringWithFormat:@"%d%@%@%@%@%@%@%@",[BWC GetTableId],seperator,[BWC GetTableName],seperator,[BWC GetTableDes],seperator,[BWC GetView],seperator];
    
    WriteToDb = TempStr;
    
    TempStr = [NSString stringWithFormat:@"%d%@%d%@%d%@%d%@%d%@%d%@",[BWC GetCriteriaTblId],seperator,[BWC GetMode],seperator,[BWC Gettx_id],seperator,[BWC GetExportTid],seperator,[BWC GetNumRows],seperator,[BWC GetNumCols],seperator];
    
    WriteToDb = [NSString stringWithFormat:@"%@%@",WriteToDb,TempStr];
    
    TempStr = @"";
    //RowIds
    NSArray *RowIds = [BWC GetRowIds];
    for(int i=0;i<[BWC GetNumRows]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[RowIds objectAtIndex:i],ContentDeLimiter];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,seperator];
    WriteToDb = [NSString stringWithFormat:@"%@%@",WriteToDb,TempStr];
    
    TempStr = @"";
    //ColumnIds;
    NSArray *ColumnIds = [BWC GetColumnIds];
    for(int i=0;i<[BWC GetNumCols]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[ColumnIds objectAtIndex:i],ContentDeLimiter];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,seperator];
    WriteToDb = [NSString stringWithFormat:@"%@%@",WriteToDb,TempStr];
    
    TempStr = @"";
    //ColumnNames;
    NSArray *ColumnNames = [BWC GetColumnNames];
    for(int i=0;i<[ColumnNames count]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[ColumnNames objectAtIndex:i],ContentDeLimiter];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,seperator];
    WriteToDb = [NSString stringWithFormat:@"%@%@",WriteToDb,TempStr];
    
    TempStr = @"";
    //Cells;
    NSArray *Cells = [BWC GetCells];
    for(int i=0;i<[Cells count]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[Cells objectAtIndex:i],ContentDeLimiter];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,seperator];
    WriteToDb = [NSString stringWithFormat:@"%@%@",WriteToDb,TempStr];
    
    
    //*******************write to file****************************
    //write to file
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    //setup path and file name to write the properties
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.txt",[BWC GetTableId]]]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :[NSString stringWithFormat:@"%d.txt",[BWC GetTableId]]]];
    
    bool fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullpath];
    if(!fileExists)
    {
        [NFM createFileAtPath:fullpath contents:nil attributes:nil];
    }
    
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
    NSData *PropStr;
    const char *bytecount = [WriteToDb UTF8String];
    PropStr = [NSData dataWithBytes:bytecount length:strlen(bytecount)];
    [PropStr writeToFile:fullpath atomically:YES];
    
}



-(BwCuboid *)Getcuboid:(int)TableId
{
    //read file from database
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    //setup path and file name to write the properties
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.txt",TableId]]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :[NSString stringWithFormat:@"%d.txt",TableId]]];
    
    NSString *PropData = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];
    
    //split the file string to an array
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter;
    ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSArray *CuboidArr = [[NSMutableArray alloc]init];
    CuboidArr = [PropData componentsSeparatedByString:seperator];
    
    //create the bwcuboid object
    BwCuboid *BWC = [[BwCuboid alloc]init];
    
    //update the cuboid object from array
   /*
    0int TableId;
    1NSString *TableName;
    2NSString *TableDes;
    3NSString *View;
    4int CriteriaTblId;
    5int Mode;
    6int tx_id;
    7int ExportTid;
    8int NumRows;
    9int NumCols;
    10 NSArray *RowIds;
    11 NSArray *ColumnIds;
    12 NSArray *ColumnNames;
    13 NSArray *Cells;
    */
    [BWC SetTableId:[[CuboidArr objectAtIndex:0] intValue]];
    [BWC SetTableName:[CuboidArr objectAtIndex:1]];
    [BWC SetTableDes:[CuboidArr objectAtIndex:2]];
    [BWC SetView:[CuboidArr objectAtIndex:3]];
    [BWC SetCriteriaTblId:[[CuboidArr objectAtIndex:4] intValue]];
    [BWC SetMode:[[CuboidArr objectAtIndex:5] intValue]];
    [BWC Settx_id:[[CuboidArr objectAtIndex:6] intValue]];
    [BWC SetExportTid:[[CuboidArr objectAtIndex:7] intValue]];
    [BWC SetNumRows:[[CuboidArr objectAtIndex:8] intValue]];
    [BWC SetNumCols:[[CuboidArr objectAtIndex:9] intValue]];
    
    
    //rowids
    [BWC SetRowIds:[[CuboidArr objectAtIndex:10] componentsSeparatedByString:ContentDeLimiter]];
    
    //columnids
    [BWC SetColumnIds:[[CuboidArr objectAtIndex:11] componentsSeparatedByString:ContentDeLimiter]];
    
    //columnnames
    [BWC SetColumnNames:[[CuboidArr objectAtIndex:12] componentsSeparatedByString:ContentDeLimiter]];
    
    //cells
    [BWC SetCells:[[CuboidArr objectAtIndex:13] componentsSeparatedByString:ContentDeLimiter]];
    
    return BWC;
    
}

@end

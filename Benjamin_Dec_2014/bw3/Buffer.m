//
//  Buffer.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Buffer.h"
#import "Database.h"
#import "Row.h"


@implementation Buffer


-(NSString *)GetBufferLogin
{
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@",self.user,seperator,self.pass];
    return buffer;
}

-(NSString *)ExtractResponseLogin:(NSString *)ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    
    NSLog(@"===response buffer=>%@===",ResBuffer);
    NSArray *resParts = [ResBuffer componentsSeparatedByString:@":"];
    NSString *ResBool = [resParts objectAtIndex:0];
    
    if ([ResBool isEqualToString: @"Success"])
    {
    NSArray *Resparts2 = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
    NSString *UserID = [Resparts2 objectAtIndex:0];
    NSString *MemberID = [Resparts2 objectAtIndex:1];
    NSString *NHID = [Resparts2 objectAtIndex:2];
    NSString *NhName = [Resparts2 objectAtIndex:3];
    
        //save info to database
        Database *db =[Database alloc];
        [db getPropertiesFile];
        [db UpdateProperties:@"UserId" :  UserID];
        [db UpdateProperties:@"MemberId" : MemberID];
        [db UpdateProperties:@"NhId" :  NHID];
        [db UpdateProperties:@"NhName" :NhName];
        [db writePropertiesFile];
    
    }
    
    return ResBool;
    
}



//linkImport buffer
-(NSString *)GetBufferLinkImport:(NSInteger *)TableID
{
    //get saved information from DB
    Database *db =[Database alloc];
    [db getPropertiesFile];
    NSString *UserID = [db GetPropertyValue:@"UserId"];
    NSString *UserName = [db GetPropertyValue:@"UserName"];
    NSString *UserPass = [db GetPropertyValue:@"UserPass"];
    NSString *MemberId = [db GetPropertyValue:@"MemberId"];
    NSString *NhId = [db GetPropertyValue:@"NhId"];

    NSString *TblId = [NSString stringWithFormat: @"%ld",TableID];

    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@-1%@%@0",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,TblId,seperator,seperator,seperator];
    NSLog(@"BufferLI = %@" ,buffer);
    return buffer;
}


-(BwCuboid *)ExtractResponseLinkImport:(NSString *)ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    NSLog(@"-------------------------------------------------------Res LI =%@",ResBuffer);
    
    //creae the cuboid object
    BwCuboid *Cuboid; //= [BwCuboid alloc];
   
    NSArray *resparts1 = [[resParts objectAtIndex:0] componentsSeparatedByString:seperator];
    NSString *ResBool = [resparts1 objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        Cuboid = [BwCuboid alloc];
        //header info extract
        NSString *TableId = [resparts1 objectAtIndex:1];
        NSLog(@"==table id=>%@===",TableId);
        NSString *TableName = [resparts1 objectAtIndex:2];
        NSString *TableDes = [resparts1 objectAtIndex:3];
        NSString *View = [resparts1 objectAtIndex:4];
        //NSString *UserId = [resparts1 objectAtIndex:5];
        //NSString *MemberId = [resparts1 objectAtIndex:6];
        //NSString *NhId = [resparts1 objectAtIndex:7];
        NSString *NumCols = [resparts1 objectAtIndex:8];
        NSString *NumRows = [resparts1 objectAtIndex:9];
        NSString *Tx_id = [resparts1 objectAtIndex:10];
        NSString *ExportTid = [resparts1 objectAtIndex:11];
        NSString *CriteriaTableId = [resparts1 objectAtIndex:12];
        NSString *Mode = [resparts1 objectAtIndex:13];
        
        [Cuboid SetTableId:[TableId intValue]];
        [Cuboid SetTableName:TableName];
        [Cuboid SetTableDes:TableDes];
        [Cuboid SetView:View];
        [Cuboid SetNumCols:[NumCols intValue]];
        [Cuboid SetNumRows:[NumRows intValue]];
        [Cuboid Settx_id:[Tx_id intValue]];
        [Cuboid SetExportTid:[ExportTid intValue]];
        [Cuboid SetCriteriaTblId:[CriteriaTableId intValue]];
        [Cuboid SetMode:[Mode intValue]];
        
        //column info
        NSLog(@"==NumCols=>%@===",NumCols);
        //convert nsstring to int
        int colcount = [NumCols intValue];
        NSArray *ColArr = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
        NSMutableArray *ColID = [[NSMutableArray alloc] init];
        NSMutableArray *ColName = [[NSMutableArray alloc] init];
        for(int i =0;i < colcount; i++)
        {
           // NSLog(@"==col id%d=>%@===",i,[ColArr objectAtIndex:i*5]);
            [ColID addObject:[ColArr objectAtIndex:i*5]];
            NSLog(@"==col name=>%@===",[ColArr objectAtIndex:(i*5)+1]);
            [ColName addObject:[ColArr objectAtIndex:(i*5)+1]];
        }
        
        [Cuboid SetColumnIds:ColID];
        [Cuboid SetColumnNames:ColName];
        
        //row info
        NSLog(@"==NumCols=>%@===",NumRows);
        //convert nsstring to int
        int rowcount = [NumRows intValue];
        NSArray *RowArr = [[resParts objectAtIndex:2] componentsSeparatedByString:seperator];
        NSMutableArray *RowIds = [[NSMutableArray alloc] init];
        for(int i =0;i < rowcount; i++)
        {
            [RowIds addObject:[RowArr objectAtIndex:i]];
        }
        
        [Cuboid SetRowIds:RowIds];
        
        
        //celldata
        NSMutableArray *Cells = [[NSMutableArray alloc] init];
        for(int i=0;i<colcount;i++)
        {
            NSArray *CellArr = [[resParts objectAtIndex:3+(i*2)] componentsSeparatedByString:seperator];
            for(int j =0;j < rowcount; j++)
            {
                [Cells addObject:[CellArr objectAtIndex:j]];
            }
        }
        
        [Cuboid SetCells:Cells];
        
    }
    else{
       // Cuboid = nil;
    }

    return Cuboid;
    
}



-(NSString *)GetBufferRefresh:(NSInteger *)TableID
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    //get existing cuboid from local database
    int tableID = TableID;
    Database *DB = [[Database alloc]init];
    BwCuboid *BWD = [DB Getcuboid:tableID];
    
    [DB getPropertiesFile];
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    NSString *UserPass = [DB GetPropertyValue:@"UserPass"];
    NSString *MemberId = [DB GetPropertyValue:@"MemberId"];
    NSString *NhId = [DB GetPropertyValue:@"NhId"];
    
    //create the buffer from properties of cuboid
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%d%@-1%@%@%@%d%@%d%@%d%@0%@%@",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,tableID,seperator,seperator,[BWD GetView],seperator,[BWD Gettx_id],seperator,[BWD GetExportTid],seperator,[BWD GetMode],seperator,seperator,ContentDeLimiter];
    
    
    //get string of rowids
    NSString *TempStr = @"";
    NSArray *RowIds = [BWD GetRowIds];
    for(int i=0;i<[BWD GetNumRows]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[RowIds objectAtIndex:i],seperator];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,ContentDeLimiter];
    buffer = [NSString stringWithFormat:@"%@%@",buffer,TempStr];

    
    NSLog(@"BufferRefresh = %@" ,buffer);
    return buffer;
    
}


-(BwCuboid *)ExtractResponseRefresh:(NSString *)ResBuffer:(int) mode
{
    NSLog(@"Refresh response = %@" ,ResBuffer);
    BwCuboid *BWC = [[BwCuboid alloc]init];
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    NSLog(@"-------------------------------------------------------Res Refresh =%@",ResBuffer);
    
    //creae the cuboid object
    NSArray *resparts1 = [[resParts objectAtIndex:0] componentsSeparatedByString:seperator];
    NSString *ResBool = [resparts1 objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        NSString *numcolumns = [resparts1 objectAtIndex:1];
        NSString *numRows = [resparts1 objectAtIndex:2];
        NSString *maxTid = [resparts1 objectAtIndex:3];
        
        [BWC SetNumCols:[numcolumns intValue]];
        [BWC SetNumRows:[numRows intValue]];
        [BWC Settx_id:[maxTid intValue]];

        
        //------column names
        int colcount = [numcolumns intValue];
        NSArray *ColArr = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
        NSMutableArray *ColID = [[NSMutableArray alloc] init];
        NSMutableArray *ColName = [[NSMutableArray alloc] init];
        for(int i =0;i < colcount*3; i++)
        {
            // NSLog(@"==col id%d=>%@===",i,[ColArr objectAtIndex:i*5]);
            [ColID addObject:[ColArr objectAtIndex:i]];
            //NSLog(@"==col name=>%@===",[ColArr objectAtIndex:(i*5)+1]);
            [ColName addObject:[ColArr objectAtIndex:i+1]];
            i = i+2;
        }
        
        //------get cell
        NSArray *CellArr = [[resParts objectAtIndex:3] componentsSeparatedByString:seperator];
        NSMutableArray *ColumnID = [[NSMutableArray alloc] init];
        NSMutableArray *rowID = [[NSMutableArray alloc] init];
        NSMutableArray *cellv = [[NSMutableArray alloc] init];
        NSMutableArray *ColumnName = [[NSMutableArray alloc] init];
        
        if ([CellArr count]>1)
        {
            for(int i =0;i < [CellArr count] ; i++)
            {
               // NSLog(@"==col id%d=>%@===",i,[CellArr objectAtIndex:i]);
                [rowID addObject:[CellArr objectAtIndex:i]];
                //NSLog(@"==col name=>%@===",[CellArr objectAtIndex:i+1]);
                [ColumnID addObject:[CellArr objectAtIndex:i+1]];
                [cellv addObject:[CellArr objectAtIndex:i+2]];
            
                //get column name
                for(int j = 0;j<colcount;j++)
                {
                    NSString *colidstr = [ColID objectAtIndex:j];
                    NSString *colnamestr = [CellArr objectAtIndex:i+1];
                    if( [colnamestr isEqualToString: colidstr])
                    {
                        [ColumnName addObject:[ColName objectAtIndex:j]];
                    }
                }
            
                i = i+4;
            }
        }
        
        [BWC SetRowIds:rowID];
        [BWC SetColumnIds:ColumnID];
        [BWC SetColumnNames:ColumnName];
        [BWC SetCells:cellv];
        
    }

    
    /** Start: added by shirish for new rows on refresh 11/24/14 **/
    // get new rows
    NSMutableDictionary *newRowsDict = [[NSMutableDictionary alloc] init];
    NSArray *newRowsArr = [[NSArray alloc] init];
    
    NSRange newRowIdentifier = [[resParts objectAtIndex:2] rangeOfString:@"N"];
    if (newRowIdentifier.location != NSNotFound)
    {
        NSString *prevRowId = @"";
        NSString *newRowId  = @"";
        
        NSArray *RowsArr = [[resParts objectAtIndex:2] componentsSeparatedByString:seperator];
        
        for (int rowsArrCnt=0;rowsArrCnt < [RowsArr count];rowsArrCnt++)
        {
            newRowId =[RowsArr objectAtIndex:rowsArrCnt];
            if ([[RowsArr objectAtIndex:rowsArrCnt+1] isEqualToString:@"N"])
            {
                if (rowsArrCnt == 0)
                    [newRowsDict setObject:newRowId forKey:@"-1"];
                //[newRowsDict addObject:[NSString stringWithFormat:@"-1:%@", newRowId]];
                else
                    [newRowsDict setObject:newRowId forKey:prevRowId];
                //[newRowsDict addObject:[NSString stringWithFormat:@"%@:%@",prevRowId,newRowId]];
                
            }
            
            prevRowId = newRowId;
            rowsArrCnt+= 1;
        }
        //[newRowsArr addObject:newRowsDict];
        newRowsArr = (NSArray *)newRowsDict;
        [BWC setNewRows:newRowsArr];
    }
    else
        [BWC setNewRows:nil];
    /** end: added by shirish for new rows on refresh 11/24/14 **/
    return BWC;
    
}




//---------------Submit
-(NSString *)GetBufferSubmit:(Cuboid *)cub
{
    
    //header
    Database *DB = [[Database alloc]init];
    [DB getPropertiesFile];
    BwCuboid *BWD = [DB Getcuboid:[cub GetTableId]];
    
    
    //extract cuboid new row array old row array
    NSMutableArray *NewRowArr = [[NSMutableArray alloc]init];
    NSMutableArray *OldRowArr = [[NSMutableArray alloc]init];
    int newrowcount = 0;
    int oldrowcount = 0;
    //new rows
    NSArray *NRows = [cub GetRow];
    for(int nri = 0;nri<[NRows count];nri++)
    {
        Row *Nr = [NRows objectAtIndex:nri];
        int rowid = [Nr GetRowID];
        if(rowid == -1)
        {
            [NewRowArr addObject:Nr];
            newrowcount = newrowcount + 1;
        }
        else
        {
            [OldRowArr addObject:Nr];
            oldrowcount = oldrowcount +1;
        }
    }
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    //get all the properties of the user from database
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    NSString *UserPass = [DB GetPropertyValue:@"UserPass"];
    NSString *MemberId = [DB GetPropertyValue:@"MemberId"];
    NSString *NhId = [DB GetPropertyValue:@"NhId"];
    int TableID = [cub GetTableId];
    NSString *View = [BWD GetView];
    int colcount = [BWD GetNumCols];
    int rowcount = [BWD GetNumRows] + newrowcount;
    int importid = [BWD Gettx_id];
    int exportid = [BWD GetExportTid];
    int critical = 0;
    int criticalLevel = 1;
    NSString *comments = @"update from Iphone";
    
    NSString *returnStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%d%@%@%@%d%@%d%@%d%@%d%@%d%@%d%@%@%@",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,TableID,seperator,View,seperator,colcount,seperator,rowcount,seperator,importid,seperator,exportid,seperator,critical,seperator,criticalLevel,seperator,comments,ContentDeLimiter];
    
    
    //------------------get column string------------------
    NSString *colstr = @"";
    //colid,colname..
    NSArray *Colids = [BWD GetColumnIds];
    NSArray *colnames = [BWD GetColumnNames];
    
    for(int i=0;i<[Colids count]; i++)
    {
        colstr = [NSString stringWithFormat:@"%@%@%@%@%@",colstr,[Colids objectAtIndex:i],seperator,[colnames objectAtIndex:i],seperator];
    }
    
    colstr = [colstr substringToIndex:[colstr length]-1];
    
    
    
    //------------------get row string------------------
    NSString *rowstr = @"";
    //rowid,..
    NSArray *Rowids = [BWD GetRowIds];
    
    for(int i=0;i<[Rowids count]; i++)
    {
        rowstr = [NSString stringWithFormat:@"%@%@%@",rowstr,[Rowids objectAtIndex:i],seperator];
    }
    
    
    
    for(int i=0;i<[NewRowArr count]; i++)
    {
        Row *Rnew = [NewRowArr objectAtIndex:i];
        if([Rnew GetRowID] <= 0)
        {
            rowstr = [NSString stringWithFormat:@"%@%@%@",rowstr,@" ",seperator];
        }
    }
    
    rowstr = [rowstr substringToIndex:[rowstr length]-1];
    
    
    
    //------------------get cell string------------------
    //rowindex,colindex,cellval,formulaval,4
    NSString *cellstr = @"";
    Row *r = [[Row alloc]init];
    NSMutableArray *Cname = [[NSMutableArray alloc]init];
    NSMutableArray *val = [[NSMutableArray alloc]init];
    
    //newrows
    for(int i=0;i<[NewRowArr count]; i++)
    {
        r = [NewRowArr objectAtIndex:i];
        Cname = [r GetColNames];
        val = [r GetValues];
        
        for(int j = 0;j< [Cname count];j++)
        {
            cellstr = [NSString stringWithFormat:@"%@%d%@%d%@%@%@%@%@%@%@",cellstr,[Rowids count]+i,seperator,j,seperator,[val objectAtIndex:j],seperator,[val objectAtIndex:j],seperator,@"4",seperator];
        }
        
    }
    //orldrows
    for(int i=0;i<[OldRowArr count]; i++)
    {
        r = [NRows objectAtIndex:i];
        Cname = [r GetColNames];
        val = [r GetValues];
        int rowid = [r GetRowID];
        int rowindex = 0;
        int colindex = 0;
        for(int k = 0;k<[Rowids count];k++)
        {
            int oldrowid = [[Rowids objectAtIndex:k] intValue];
            if(oldrowid == rowid)
            {
                rowindex = k;
            }
        }
        
        for(int j = 0;j< [Cname count];j++)
        {
            for(int l = 0;l<[colnames count];l++)
            {
                NSString *oldcolname = [colnames objectAtIndex:l];
                if([oldcolname isEqualToString:[Cname objectAtIndex:j]])
                {
                    colindex = l;
                }
            }
            
            cellstr = [NSString stringWithFormat:@"%@%d%@%d%@%@%@%@%@%@%@",cellstr,rowindex,seperator,colindex,seperator,[val objectAtIndex:j],seperator,[val objectAtIndex:j],seperator,@"1",seperator];
        }
        
    }
    //cellstr = [cellstr substringToIndex:[cellstr length]-1];
    
    
    returnStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",returnStr,colstr,ContentDeLimiter,rowstr,ContentDeLimiter,cellstr,ContentDeLimiter];
    
    NSLog([NSString stringWithFormat:@"Submit call Buffer: %@",returnStr]);
    return returnStr;
    
    
    
}


-(Cuboid *)ExtractResponseSubmit:(NSString *)ResBuffer:(Cuboid *) cub
{
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    Row *r = [[Row alloc]init];
    
    NSString *ResBool = [resParts objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        int tid = [[resParts objectAtIndex:1] intValue];
        NSString *NewRowsstr = [resParts objectAtIndex:2];
        NSString *NewColsstr = [resParts objectAtIndex:3];
        int numrows = [[resParts objectAtIndex:6] intValue];
        int numcols = [[resParts objectAtIndex:7] intValue];
        
        [cub SetNumCols:numcols];
        [cub SetNumRows:numrows];
        [cub Settx_id:tid];
        NSArray *rows = [cub GetRow];
        NSMutableArray *returnrows = [[NSMutableArray alloc]init];
        
        NSArray * newrows = [NewRowsstr componentsSeparatedByString:seperator];
        for(int i = 0;i<[rows count];i++)
        {
            r = [rows objectAtIndex:i];
            if([r GetRowID] == -1)
            [r setRowid:[[newrows objectAtIndex:(i*2)+1] intValue]];
            
            [returnrows addObject:r];
        }
        [cub SetRow:returnrows];
    }
    
    
    return cub;
    
}




-(NSString *)GetBufferAllUpdates:(NSInteger)TableID:(NSString *)View:(NSString *)Period
{
    Database *db =[Database alloc];
    [db getPropertiesFile];
    NSString *UserID = [db GetPropertyValue:@"UserId"];
    NSString *MemberId = [db GetPropertyValue:@"MemberId"];
    NSString *NhId = [db GetPropertyValue:@"NhId"];
    
    long long int dblstartdate = 0;
    long long int dblenddate = 0;
    long long int localtimeafter = 0;
    int daysToAdd = 0;
    
   
    //-----set the time period
    NSDate *now = [NSDate date];
    NSLog(@"Today: %@", now);
    
    if([Period isEqualToString:@"Week"])
    {
        daysToAdd = -7;
    }
    else if([Period isEqualToString:@"Month"])
    {
        daysToAdd = -30;
    }
    else if([Period isEqualToString:@"Year"])
    {
        daysToAdd = -365;
    }
    
    // set up date components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    // create a calendar
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *StartPeriod = [gregorian dateByAddingComponents:components toDate:now options:0];
    NSLog(@"StartPeriod: %@", StartPeriod);
    
    
    //------start date and end date in mS
    dblstartdate = ([StartPeriod timeIntervalSince1970]);
    dblstartdate = dblstartdate * 1000;
    dblenddate = ([now timeIntervalSince1970]);
    dblenddate = dblenddate * 1000;
    localtimeafter = dblenddate;
    
    
    
    //------------------
    NSString *TblId = [NSString stringWithFormat: @"%d",(int)TableID];
    NSString *strtdate = [@(dblstartdate) stringValue];
    NSString *enddate = [NSString stringWithFormat:@"%lld",dblenddate];
    NSString *LocalTimeAfter = [NSString stringWithFormat:@"%lld",dblenddate];
   
    NSLog(@"dblStartPeriod: %@", strtdate);
    NSLog(@"dblEndPeriod: %@", enddate);
    
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@-1%@Duration%@%@%@",UserID,seperator,NhId,seperator,View,seperator,TblId,seperator,Period,seperator,strtdate,seperator,enddate,seperator,LocalTimeAfter,seperator,seperator,seperator,MemberId,seperator];
    NSLog(@"BufferAllUpdates = %@" ,buffer);
    return buffer;

}




-(NSArray *)ExtractResponseAllUpdates:(NSString *) ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSMutableArray *retArr = [[NSMutableArray alloc]init];
    
    
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    NSString *ResBool = [resParts objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        for(int i = 1;i<[resParts count]-1;i++)
        {
            NSArray *obj = [[NSArray alloc]init];
            obj = [[resParts objectAtIndex:i] componentsSeparatedByString:seperator];
            [retArr addObject:obj];
        }
    }
    
    return retArr;
}


-(NSString *)GetBufferMissingUpdates:(NSInteger)TableID
{
    Database *DB =[Database alloc];
    [DB getPropertiesFile];
    
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    NSString *UserPass = [DB GetPropertyValue:@"UserPass"];
    NSString *MemberId = [DB GetPropertyValue:@"MemberId"];
    NSString *NhId = [DB GetPropertyValue:@"NhId"];
    NSString *NhName = [DB GetPropertyValue:@"NhName"];
    
    //-----set the time period
    NSDate *now = [NSDate date];
    NSLog(@"Today: %@", now);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
    
    NSString *formattedDateString = [NSString stringWithFormat:@"%@ PST",[dateFormatter stringFromDate:now]];
    
    //------------------
    NSString *TblId = [NSString stringWithFormat: @"%d",(int)TableID];
    NSString *actionId = @"1";
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDelimitter;
    ContentDelimitter = [NSString stringWithFormat:@"%c",2];
    
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,NhName,seperator,actionId,seperator];
    
    //append table info
    buffer = [NSString stringWithFormat:@"%@%@%@LATEST%@-91578%@-1%@%@%@",buffer,TblId,ContentDelimitter,ContentDelimitter,ContentDelimitter,ContentDelimitter,formattedDateString,ContentDelimitter];
    
    buffer = [NSString stringWithFormat:@"%@%@%@",buffer,seperator,seperator];
    
    NSLog(@"BufferAllUpdates = %@" ,buffer);
    return buffer;
}

-(NSArray *)ExtractResponseMissingUpdates:(NSString *)ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    NSArray *retArr = [[NSArray alloc]init];
    
    NSArray *resParts = [ResBuffer componentsSeparatedByString:seperator];
    
    NSString *ResBool = [resParts objectAtIndex:0];
    if ([ResBool isEqualToString: @"Failure"])
    {
        retArr = [[NSArray alloc]init];
    }
    else
    {
        
    if([resParts count] >= 3)
    {
        NSString *ResBool = [resParts objectAtIndex:0];
        NSLog(@"===response bool=>%@===",ResBool);
        if ([ResBool isEqualToString: @"Success"])
        {
            retArr = [[resParts objectAtIndex:1] componentsSeparatedByString:ContentDeLimiter];
        }
    }
    else
    {
        resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
        
    }
    }
    return retArr;
}



/***** start: ondemand linkImport buffer added by shirish on 11/13/14*****/
-(NSString *)GetBufferLinkImportOnDemand:(NSInteger)TableID onDemandParam:(NSString *)query
{
    //get saved information from DB
    Database *db =[Database alloc];
    [db getPropertiesFile];
    NSString *UserID    = [db GetPropertyValue:@"UserId"];
    NSString *UserName  = [db GetPropertyValue:@"UserName"];
    NSString *UserPass  = [db GetPropertyValue:@"UserPass"];
    NSString *MemberId  = [db GetPropertyValue:@"MemberId"];
    NSString *NhId      = [db GetPropertyValue:@"NhId"];
    
    NSString *TblId = [NSString stringWithFormat: @"%ld",TableID];
    //query = [NSString stringWithFormat:@"%@%@", query,UserName];
    
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@-1%@%@%@0",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,TblId,seperator,seperator,query,seperator];
    NSLog(@"BufferLI = %@" ,buffer);
    return buffer;
}
/***** end: ondemand linkImport buffer added by shirish on 11/13/14*****/



@end

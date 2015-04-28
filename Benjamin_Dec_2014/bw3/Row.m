//
//  Row.m
//  bw3
//
//  Created by Ashish on 7/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Row.h"

@implementation Row
{
    int RowId;
    NSMutableArray *ColName;
    NSMutableArray *Value;
    
}

/*added by shirish starts 7/28/14 */
@synthesize RowId;
@synthesize ColName;
@synthesize Value;
/*added by shirish ends 7/28/14 */

-(id)init
{
    ColName = [[NSMutableArray alloc] init];
    Value = [[NSMutableArray alloc] init];
    RowId = -1;
    return self;
}

-(void)setRowid:(int)Rid
{
    RowId = Rid;
}

-(void)setColumnData:(NSString *)Name :(NSString *)val
{
    [ColName addObject:Name];
    [Value addObject:val];
}

-(NSMutableArray *)GetColNames
{
    return ColName;
}

-(NSMutableArray *)GetValues
{
    return Value;
}
-(int)GetRowID
{
    return RowId;
}


@end

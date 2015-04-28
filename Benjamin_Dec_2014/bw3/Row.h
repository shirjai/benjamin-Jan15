//
//  Row.h
//  bw3
//
//  Created by Ashish on 7/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Row : NSObject

-(void) setRowid:(int) Rid;
-(void) setColumnData:(NSString*) Name:(NSString*) val;
-(NSMutableArray *)GetColNames;
-(NSMutableArray *)GetValues;
-(int)GetRowID;

/*added by shirish starts 7/28/14 */
@property (nonatomic, readonly) int RowId;
@property (nonatomic, readonly) NSMutableArray *ColName;
@property (nonatomic, readonly) NSMutableArray *Value;
/*added by shirish ends 7/28/14 */


@end

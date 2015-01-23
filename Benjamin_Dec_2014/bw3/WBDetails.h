//
//  WBDetails.h
//  bw4
//
//  Created by Srinivas on 10/8/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBDetails : NSObject

-(void)SetCuboidName:(NSArray*)Cname;
-(void)SetUpdateOn:(NSArray*)UpdateOn;
-(void)SetUpdateBy:(NSArray*)UpdateBy;
-(void)SetCuboidId:(NSArray*)CubId;

-(NSMutableArray *)GetCuboidName;
-(NSMutableArray *)GetUpdatedBy;
-(NSMutableArray *)GetupdatedOn;
-(NSMutableArray *)GetCuboidId;

@end

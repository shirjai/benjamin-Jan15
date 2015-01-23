//
//  Database.h
//  bw3
//
//  Created by Ashish on 5/27/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"

@interface Database : NSObject

-(void) getPropertiesFile;
-(void) writePropertiesFile;

-(void) UpdateProperties:(NSString *) Name : (NSString *) Value ;
-(NSString *)GetPropertyValue:(NSString *)Name;

-(void) writeCuboid:(BwCuboid*) BWC;
-(BwCuboid *)Getcuboid:(int) TableId;

@end

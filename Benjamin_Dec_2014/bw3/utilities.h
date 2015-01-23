//
//  utilities.h
//  bw3
//
//  Created by Ashish on 5/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cuboid.h"
#import "BwCuboid.h"

@interface utilities : NSObject
-(NSString *) PrepareRequest: (NSString *)usrpass;
-(NSString *) PrepareResponse: (NSString *)usrpass;
-(BwCuboid *) MergeRefreshCuboid:(Cuboid *) CUB:(BwCuboid *)BWC;
-(BwCuboid *) MergeSubmitCuboid:(Cuboid *)CUB:(BwCuboid *)BWC;

@end

//
//  ExternalQuery.h
//  bw3
//
//  Created by Shirish Jaiswal on 12/5/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface ExternalQuery : NSObject

-(NSString *)getExternalData:(int)TableId :(NSString *)strReportName :(NSString *)strQueryId :(NSString *)strQueryParams;

-(NSArray *)ExtractResponseExternalData :(NSString *)ResBuffer;

@end

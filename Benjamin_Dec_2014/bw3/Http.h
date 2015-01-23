//
//  Http.h
//  bw3
//
//  Created by Ashish on 4/29/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Http : NSObject

-(NSString *) callBoardwalk: (NSString*) buffer:(NSString*) requestType;
@property bool downloadComplete;

@end

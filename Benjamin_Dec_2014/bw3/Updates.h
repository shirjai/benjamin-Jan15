//
//  Updates.h
//  bw4
//
//  Created by Srinivas on 10/20/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Updates : NSObject

-(NSArray *) AllupdatesApi:(int)TableId:(NSString *)view:(NSString *)Period;
-(NSArray *) MissingupdatesApi:(int)TableId;

@end

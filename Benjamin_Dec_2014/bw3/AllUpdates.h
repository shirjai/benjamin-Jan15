//
//  AllUpdates.h
//  bw4
//
//  Created by Srinivas on 10/20/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllUpdates : NSObject

-(void)SetAllupdatesArray:(int)TableId:(NSString *)view:(NSString *)period;
-(NSArray *) GetArrayAllUpdates;


@end

//
//  CuboidHandler.h
//  bw3
//
//  Created by Shirish Jaiswal on 11/7/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainVC.h"

@interface CuboidHandler : NSObject

-(NSArray *)loadBenjaminCuboid :(NSInteger )cuboidId;
-(void)callBenjaminCuboid:(MainVC *)mainVCObj :(NSArray *)watchRowArray :(NSString *)cuboidName;
+(void)submitNotes:(NSDictionary *)dictChanges;

@end

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

-(NSArray *)loadBenjaminWatch;
-(void)callBenjaminWatch:(MainVC *)mainVCObj :(NSArray *)watchRowArray;
+(void)submitNotes:(NSDictionary *)dictChanges;

@end

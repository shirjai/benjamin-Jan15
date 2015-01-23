//
//  WIC.h
//  bw3
//
//  Created by Ashish on 7/18/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface WIC : NSObject

-(NSString *) SetWIC;
-(Cuboid *) GetWBProperties;
-(NSInteger *) GetWBProperty:(NSString *) Server:(NSString *) Wbname:(NSString *) PropertyName;

@end

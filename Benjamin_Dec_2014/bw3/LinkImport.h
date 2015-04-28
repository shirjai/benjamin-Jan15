//
//  LinkImport.h
//  bw3
//
//  Created by Ashish on 6/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface LinkImport : NSObject

-(Cuboid *)LinkImportApi:(NSInteger *) TableId;

/***** added by shirish for ondemand linkImport API 11/13/14 *****/
-(Cuboid*)LinkImportApiOnDemand:(NSInteger)TableId onDemandParam:(NSString *)query;
/***** added by shirish for ondemand linkImport API 11/13/14 *****/

@end

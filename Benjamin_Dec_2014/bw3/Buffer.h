//
//  Buffer.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface Buffer : NSObject

@property NSString *user;
@property NSString *pass;

-(NSString *) GetBufferLogin;
-(NSString *) ExtractResponseLogin: (NSString*) ResBuffer;

-(NSString *) GetBufferLinkImport:(NSInteger *)TableID;
-(BwCuboid *) ExtractResponseLinkImport:(NSString*) ResBuffer;

-(NSString *) GetBufferRefresh:(NSInteger *)TableID;
-(BwCuboid *) ExtractResponseRefresh:(NSString*) ResBuffer:(int) mode;

-(NSString *) GetBufferSubmit:(Cuboid *) cub;
-(Cuboid *) ExtractResponseSubmit:(NSString *) ResBuffer:(Cuboid *) cub;

-(NSString *) GetBufferAllUpdates:(NSInteger) TableID:(NSString *) View:(NSString *)Period;
-(NSArray *) ExtractResponseAllUpdates:(NSString *)ResBuffer;

-(NSString *) GetBufferMissingUpdates:(NSInteger) TableID;
-(NSArray *) ExtractResponseMissingUpdates:(NSString *)ResBuffer;

/***** start: added by shirish on 11/13/14*****/

//ondemand linkImport buffer
-(NSString *)GetBufferLinkImportOnDemand:(NSInteger)TableID onDemandParam:(NSString *)query;

/***** end:  added by shirish on 11/13/14*****/


@end

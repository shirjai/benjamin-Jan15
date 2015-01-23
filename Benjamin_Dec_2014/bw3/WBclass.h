//
//  WBclass.h
//  bw3
//
//  Created by Ashish on 5/27/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBDetails.h"

@interface WBclass : NSObject
-(NSArray*) getworkbooks;
-(WBDetails*) GetWorkbookDetails:(NSString*) workBookName;

@end

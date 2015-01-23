//
//  NotesHandler.h
//  bw3
//
//  Created by Shirish Jaiswal on 10/14/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainVC.h"

@interface NotesHandler : NSObject

-(void)loadBenjaminNotes  :(MainVC *) mainVCObj;
+(void)submitNotes:(NSArray *)newNote;
+(NSDictionary *)loadValuesfromProperties;


@end

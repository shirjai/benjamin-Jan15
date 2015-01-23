//
//  hdrLayout.m
//  BW6
//
//  Created by Shirish Jaiswal on 1/21/15.
//  Copyright (c) 2015 Ashish. All rights reserved.
//

#import "hdrLayout.h"

@implementation hdrLayout

- (instancetype)copyWithZone:(NSZone *)zone {
    hdrLayout *copy = [super copyWithZone:zone];
    copy.bkgrndClr = self.bkgrndClr;
    return copy;
}


@end

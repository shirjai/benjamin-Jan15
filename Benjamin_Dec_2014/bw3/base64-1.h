//
//  base64-1.h
//  bw3
//
//  Created by Ashish on 5/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface base64_1 : NSObject

- (NSString *) base64EncodeString: (NSString *) strData;
- (NSString *) base64EncodeData: (NSData *) objData ;
- (NSData *) base64DecodeString: (NSString *) strBase64;

@end

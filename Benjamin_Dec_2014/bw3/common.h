//
//  common.h
//  bw3
//
//  Created by Shirish Jaiswal on 10/14/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface common : NSObject

+(NSDictionary *)loadValuesfromPropertiesFile:(NSString *)propertyFileName;

+(CATransition *)getViewTransistionStylePageCurl;
+(NSString *)getSubstring:(NSString *)stringParam defineStartChar:(NSString *)start defineEndChar:(NSString *)end;

+(NSMutableArray *)prepareDataFromBuffer:(NSMutableArray *)mutarrCubRows ColNames:(NSArray *)arrSelColNames RowIdCol:(NSString *)rowIdColName;

+(NSString *) dateFromExcelSerialDate:(double) serialdate;

@end

//
//  common.m
//  bw3
//
//  Created by Shirish Jaiswal on 10/14/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "common.h"
#import "Row.h"
#import "Database.h"
#import "Http.h"

#import <QuartzCore/QuartzCore.h>

@implementation common


// get the values from property File
+(NSDictionary *)loadValuesfromPropertiesFile:(NSString *)propertyFileName{
    
    NSString *propertyPath = [[NSBundle mainBundle] pathForResource:propertyFileName ofType:@"plist"];
    
    NSDictionary *propDict = [[NSDictionary alloc] initWithContentsOfFile:propertyPath];
    
    return propDict;
    
}


/*available transitions
 
 kCATransitionFade,kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, @"cameraIris", @"cameraIrisHollowOpen", @"cameraIrisHollowClose", @"cube", @"alignedCube", @"flip", @"alignedFlip", @"oglFlip", @"rotate", @"pageCurl"
 @"pageUnCurl", @"rippleEffect", @"suckEffect"
 */

+(CATransition *)getViewTransistionStylePageCurl{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = @"pageUnCurl";//kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    return transition;
}



// returns a substring from start char to end char
// if start char "", take the first char of the string
// if end char "", consider the end of the string

+(NSString *)getSubstring:(NSString *)stringParam defineStartChar:(NSString *)start defineEndChar:(NSString *)end{
    
    NSString *subString = nil;
    NSRange startRange = [stringParam rangeOfString:start];
    if (startRange.location != NSNotFound)
    {
        subString = [stringParam substringFromIndex:startRange.location];
    }
    else{
        subString = [stringParam substringFromIndex:0];
    }
    
    NSRange endRange = [stringParam rangeOfString:end];
    if (endRange.location != NSNotFound)
    {
        subString = [stringParam substringToIndex:endRange.location];
    }
    else{
        subString = [stringParam substringToIndex:stringParam.length];
    }
    return subString;
}

// rearrange cuboid data as columnName maintaining the order - Value pair
+(NSMutableArray *)prepareOrderedDataFromBuffer:(NSMutableArray *)mutarrCubRows ColNames:(NSArray *)arrSelColNames RowIdCol:(NSString *)rowIdColName{
    
    NSMutableArray *mutarrKeyValData = [[NSMutableArray alloc] init];
    
    NSLog(@"Inside prepareDateFromBuffer");
    if (![mutarrCubRows count]) {
        
        NSLog(@"No changes or new rows from the server");
        
    }
    else{
        NSString *strColName = nil;
        NSString *strColVal = nil;
        NSString *strRowId = nil;
        NSString *colkey = nil;
        Row *eachRow = nil;
        int irowCnt = 0;
        
        
        //for (Row *eachRow in msgRowArray)
        for ( irowCnt = irowCnt;  irowCnt < [mutarrCubRows count];irowCnt++)
        {
            eachRow = mutarrCubRows[irowCnt];
            // NSLog(@"eachRow:%@",eachRow);
            // NSLog(@"Rowid:%d",[eachRow RowId]);
            
            // to set the colPosition for display
            int colPos = 0;
            
            NSMutableDictionary *mutdictCubData = [[NSMutableDictionary alloc] init];
            //numRowId = [NSNumber numberWithInt:[eachRow RowId]];
            strRowId = [NSString stringWithFormat:@"%d", [eachRow RowId]];
            colkey = [NSString stringWithFormat:@"%d:%@",colPos,rowIdColName];
            [mutdictCubData setObject:strRowId forKey:colkey];
            
            for (int i=0; i <[[eachRow ColName] count];i++)
            {
                
                strColName = [[eachRow ColName] objectAtIndex:i];
                strColVal = [[eachRow Value] objectAtIndex:i];
                
                
                //NSLog(@"colname:%@",strColName);
                //NSLog(@"colvalue:%@",strColVal);
                
                if ([arrSelColNames containsObject:strColName])
                {
                    colPos += 1;
                    colkey = [NSString stringWithFormat:@"%d:%@",colPos,strColName];
                    [mutdictCubData setObject:strColVal forKey:colkey];
                }
                
            }
            //[cubmsgs addObject:msgElement];
            [mutarrKeyValData addObject:mutdictCubData];
        }
    }
    return mutarrKeyValData;
    
}



// rearrange cuboid data as columnName - Value pair
+(NSMutableArray *)prepareDataFromBuffer:(NSMutableArray *)mutarrCubRows ColNames:(NSArray *)arrSelColNames RowIdCol:(NSString *)rowIdColName{
    
    NSMutableArray *mutarrKeyValData = [[NSMutableArray alloc] init];
    
    NSLog(@"Inside prepareDateFromBuffer");
    if (![mutarrCubRows count]) {
        
        NSLog(@"No changes or new rows from the server");
        
    }
    else{
        NSString *strColName = nil;
        NSString *strColVal = nil;
        NSString *strRowId = nil;
        Row *eachRow = nil;
        int irowCnt = 0;
        
        //for (Row *eachRow in msgRowArray)
        for ( irowCnt = irowCnt;  irowCnt < [mutarrCubRows count];irowCnt++)
        {
            eachRow = mutarrCubRows[irowCnt];
            // NSLog(@"eachRow:%@",eachRow);
            // NSLog(@"Rowid:%d",[eachRow RowId]);
            
            NSMutableDictionary *mutdictCubData = [[NSMutableDictionary alloc] init];
            //numRowId = [NSNumber numberWithInt:[eachRow RowId]];
            strRowId = [NSString stringWithFormat:@"%d", [eachRow RowId]];
            [mutdictCubData setObject:strRowId forKey:rowIdColName];
            
            for (int i=0; i <[[eachRow ColName] count];i++)
            {
                
                strColName = [[eachRow ColName] objectAtIndex:i];
                strColVal = [[eachRow Value] objectAtIndex:i];
                
                //NSLog(@"colname:%@",strColName);
                //NSLog(@"colvalue:%@",strColVal);
                
                if ([[arrSelColNames valueForKey:@"lowercaseString"] containsObject:[strColName lowercaseString]])
                {
                    [mutdictCubData setObject:strColVal forKey:strColName];
                }
                
            }
            //[cubmsgs addObject:msgElement];
            [mutarrKeyValData addObject:mutdictCubData];
        }
    }
    return mutarrKeyValData;
    
}

// convert date offset to date string
+(NSString *) dateFromExcelSerialDate:(double) serialdate
{
    if (serialdate > 31 + 28)
        serialdate -= 1.0;      // Fix Excel bug where it thinks 1900 is a leap year
    const NSTimeInterval numberOfSecondsInOneDay = 86400;
    NSTimeInterval theTimeInterval = serialdate * numberOfSecondsInOneDay; //number of days
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [calendar setTimeZone:timeZone];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter.timeZone = timeZone;
    
    NSDateComponents *excelBaseDateComps = [[NSDateComponents alloc] init];
    [excelBaseDateComps setYear:1900];
    [excelBaseDateComps setMonth:1];
    [excelBaseDateComps setDay:0];
    [excelBaseDateComps setHour:0];
    [excelBaseDateComps setMinute:0];
    [excelBaseDateComps setSecond:0];
    [excelBaseDateComps setTimeZone:timeZone];
    NSDate *excelBaseDate = [calendar dateFromComponents:excelBaseDateComps];
    
    NSDate *inputDate = [NSDate dateWithTimeInterval:theTimeInterval
                                           sinceDate:excelBaseDate];
    
    NSString *convertedString = [dateFormatter stringFromDate:inputDate];
    
    return convertedString;
}


// Convert date GMT to local
+(NSString *) dateFromGMTtoLocal:(NSString *)strDateGMT
{

    if ([strDateGMT length] > 0) {
        
    
        NSDateFormatter *dateFormatterGMT = [[NSDateFormatter alloc] init];
        [dateFormatterGMT setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [dateFormatterGMT setLocale:[NSLocale currentLocale]];
        [dateFormatterGMT setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
   
    
        //strDateGMT = @"2015-04-17 09:06:57.380";// 09:06:57:380";
        // NSDate *dateGMT = [[NSDate alloc] init];
        NSDate *dateGMT = [dateFormatterGMT dateFromString:strDateGMT];
    
    
        NSDateFormatter *dateFormatterLocal = [[NSDateFormatter alloc] init];
        [dateFormatterLocal setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatterLocal setLocale:[NSLocale currentLocale]];
        //[dateFormatterLocal setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatterLocal setDateFormat: @"yyyy-MM-dd hh:mm:ss a"];
    
        NSString *convertedString = [dateFormatterLocal stringFromDate:dateGMT];
    
    
        return convertedString;
    }
    else
        return @"";
}

// custom java code specific to a functionality or feature
+(NSString *)getMyDataFrmServer :(NSString *)myParam :(NSString *)myEndpoint
{
    //NSString *CallBuff = [self GetBufferExternalData:TableId :@" " :@"68" :@" "];
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    
    Database *dbObject = [[Database alloc]init];
    // BwCuboid *BWD = [DB Getcuboid:tableID];
    
    [dbObject getPropertiesFile];
    NSString *UserID = [dbObject GetPropertyValue:@"UserId"];
    NSString *UserName = [dbObject GetPropertyValue:@"UserName"];
    NSString *UserPass = [dbObject GetPropertyValue:@"UserPass"];
    NSString *NhId = [dbObject GetPropertyValue:@"NhId"];
    NSString *NhName = [dbObject GetPropertyValue:@"NhName"];
    NSString *MemberId = [dbObject GetPropertyValue:@"MemberId"];

    
    //create the buffer from properties of cuboid
    NSString *reqBuffer = [NSString stringWithFormat:@"InvokeFetchForReview%@%@%@%@%@%@%@ %@ %@%@%@%@%@%@%@ %@",seperator,UserID,seperator,UserName,seperator,UserPass,seperator,seperator,seperator,NhId,seperator,NhName,seperator,MemberId,seperator,seperator];

   // reqBuffer = [NSString stringWithFormat:@"%@%@%@",reqBuffer,myParam,seperator];
    
    //connect to server and link import the cuboid
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk :reqBuffer :myEndpoint];
    
    return Res;
}
@end

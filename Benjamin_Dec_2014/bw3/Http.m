//
//  Http.m
//  bw3
//
//  Created by Ashish on 4/29/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Http.h"
#import "utilities.h"
#import "Database.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation Http{
    NSMutableData *responseData ;
   
}

-(NSString *)callBoardwalk:(NSString *)buffer:(NSString *) requestType
{
    NSString *ResDecoded ;
    //httpt_vb_Login
    NSString *inputbuff = [NSString stringWithFormat:@"t%@",buffer];
    utilities *utl = [utilities alloc];
    NSString *reqbuff = [utl PrepareRequest:inputbuff];
    NSLog(@"====request===>%@----",reqbuff);
    //connect to server with the request
    self.downloadComplete = NO;
    
    Database *DB = [[Database alloc]init];
    [DB getPropertiesFile];
    NSString *ServerAdd = [DB GetPropertyValue:@"ServerAddress1"];
    /*
    //@"http://pa.boardwalktech.com/bw_internal/";*/
    
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@%@",ServerAdd,requestType]] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:150];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", reqbuff.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[reqbuff dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error:&error];
    
    NSString *res = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];

    if([res isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
      ResDecoded = @"Failure";
        ViewController *VC = [[ViewController alloc]init];
        //[self presentViewController:VC animated:YES completion:nil];
       // AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        //UIViewController *RVC = [appDelegate.window rootViewController];
        //[RVC presentViewController: VC animated:YES completion:nil];
    }
    
    else
    {
    //decode the response from server
    ResDecoded = [utl PrepareResponse:res];
    }
    return ResDecoded;
    
    
}

@end

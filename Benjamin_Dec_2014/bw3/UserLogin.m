//
//  UserLogin.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "UserLogin.h"
#import "Buffer.h"
#import "Http.h"
#import "Database.h"

@implementation UserLogin

-(NSString *)authenticateuser:(NSString *)user :(NSString *)pass
{
    Buffer *buff = [Buffer alloc];
    [buff setUser:user];
    [buff setPass:pass];
    NSString *bufferlog = [buff GetBufferLogin];
    NSLog(@"%@",bufferlog);
    
    
   // [self writetofile:msg];
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk:bufferlog:@"httpt_vb_Login"];
    
    //process the responce in buffer class and save info
    NSString *resbool = [buff ExtractResponseLogin:Res];
    NSLog(@"resbool =(%@)",resbool);
    
    //save info to database
    Database *db =[Database alloc];
    [db getPropertiesFile];
    [db UpdateProperties:@"UserName" :user];
    [db UpdateProperties:@"UserPass" :pass];
    [db writePropertiesFile];

    
    return resbool;
}



@end

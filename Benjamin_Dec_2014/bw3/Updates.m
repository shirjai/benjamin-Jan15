//
//  Updates.m
//  bw4
//
//  Created by Srinivas on 10/20/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Updates.h"
#import "Buffer.h"
#import "Http.h"

@implementation Updates

-(NSArray *)AllupdatesApi:(int)TableId:(NSString *)view:(NSString *)Period
{
    Buffer *Buff = [[Buffer alloc]init];
    NSString *CallBuff = [Buff GetBufferAllUpdates:TableId :view:Period];
    
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk:CallBuff:@"xlGetTransactions"];
    NSLog(@"----transactions res----");
    NSLog(Res);
    
    NSArray *Transactions = [Buff ExtractResponseAllUpdates:Res];
    
    return Transactions;
}

-(NSArray *)MissingupdatesApi:(int)TableId
{
    Buffer *Buff = [[Buffer alloc]init];
    NSString *CallBuff = [Buff GetBufferMissingUpdates:TableId];
    
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk:CallBuff:@"http_vb_getTableInfo"];
    NSLog(@"----transactions res----");
    NSLog(Res);
    
    NSArray *TblDetails = [Buff ExtractResponseMissingUpdates:Res];
    
    return TblDetails;
}

@end
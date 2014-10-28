//
//  ChangeIdToName.m
//  车商官家
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ChangeIdToName.h"

@implementation ChangeIdToName

-(NSString *)changeIdToNameWith:(NSArray *)idArray
{
    NSString * returnStr = nil;
    NSLog(@"asdasd");
    NSString * idStr = nil;
    for (int i = 0; i<[idArray count]; i++) {
        if (i==0) {
            idStr = [idArray objectAtIndex:0];
        }else{
            idStr = [idStr stringByAppendingFormat:@",%@",[idArray objectAtIndex:i]];
        }
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api.php?c=member&a=getdata_byids&ids=%@",URL_HEAD_STR,idStr]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSData * received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:nil];
    
    int errorNumber = [[jsonDict valueForKey:@"error"] intValue];
    if (errorNumber != 0) {
        //注册失败，提示失败原因
        NSLog(@"注册失败！原因：=%@",[jsonDict valueForKey:@"message"]);
        NSLog(@"responseDict=%@",jsonDict);
//        [self showAlertViewWithMessage:[jsonDict valueForKey:@"message"]];
        return @"";
    }else{
        NSLog(@"ChangeIDToName:成功：jsonDict=%@",jsonDict);
        
        returnStr = [[[jsonDict valueForKey:@"list"] objectAtIndex:0] valueForKey:@"username"];
    }
    
    return returnStr;
}

@end

//
//  SetGetUIDCID.m
//  CarLoan
//
//  Created by mac on 14-9-28.
//  Copyright (c) 2014年 左海飞. All rights reserved.
//

#import "SetGetUIDCID.h"

@implementation SetGetUIDCID

- (void)setUID:(NSString *)uidStr setCID:(NSString *)cidStr
{
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * plistPath = [documentPath stringByAppendingPathComponent:@"plist.plist"];
    NSLog(@"plistpath=%@",plistPath);
    
    NSFileManager * fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:plistPath]) {
        NSMutableDictionary * plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        [plistDict removeAllObjects];
        [plistDict setObject:uidStr forKey:@"uid"];
        [plistDict setObject:cidStr forKey:@"cid"];
        [plistDict writeToFile:plistPath atomically:YES];
    }else{
        NSMutableDictionary * plistDict = [[NSMutableDictionary alloc]init];
        [plistDict setObject:uidStr forKey:@"uid"];
        [plistDict setObject:cidStr forKey:@"cid"];
        [plistDict writeToFile:plistPath atomically:YES];
    }
    
}
- (int)getUID
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * plistPath = [documentPath stringByAppendingPathComponent:@"plist.plist"];
    NSFileManager * fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:plistPath]) {
        NSDictionary * plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSString * uidStr = [plistDict valueForKey:@"uid"];
        
        int uid = [uidStr intValue];
        return uid;
    }else{
        return 0;
    }
}
- (int)getCID
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * plistPath = [documentPath stringByAppendingPathComponent:@"plist.plist"];
    
    NSFileManager * fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:plistPath]) {
        NSDictionary * plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSString * cidStr = [plistDict valueForKey:@"cid"];
        
        int cid = [cidStr intValue];
        return cid;
    }else{
        return 0;
    }
}

@end

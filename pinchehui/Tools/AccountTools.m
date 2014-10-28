//
//  AccountTools.m
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#import "AccountTools.h"
#import "Account.h"

@implementation AccountTools
singleton_implementation(AccountTools)


- (instancetype)init{
    
    if (self =[super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
        
       
    }
    return self;

}


- (void)saveAccount:(Account *)account{
    
    _account = account;
    
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile ];
    
}




@end

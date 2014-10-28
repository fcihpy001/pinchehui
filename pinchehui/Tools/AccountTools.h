//
//  AccountTools.h
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Singleton.h"

@interface AccountTools : NSObject
singleton_interface(AccountTools)

@property (nonatomic,strong) Account *account;

-(void)saveAccount:(Account *)account;


@end

//
//  Account.m
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Account.h"

@implementation Account

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:_uid forKey:@"uid"];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    if (self =[super init]) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;

}
@end

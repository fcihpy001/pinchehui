//
//  SetGetUIDCID.h
//  CarLoan
//
//  Created by mac on 14-9-28.
//  Copyright (c) 2014年 左海飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetGetUIDCID : NSObject

- (void)setUID:(NSString *)uidStr setCID:(NSString *)cidStr;
- (int)getUID;
- (int)getCID;

@end

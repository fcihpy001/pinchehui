//
//  HttpTool.h
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpTool : NSObject



singleton_interface(HttpTool)

+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params  success:(HttpSuccessBlock)success   failure:(HttpFailureBlock)failure method:(NSString *)method;

+ (void)getWithPath:(NSString *)path    params:(NSDictionary *)params   success:(HttpSuccessBlock)success   failure:(HttpFailureBlock)failure;

+ (void)postWithPath:(NSString *)path    params:(NSDictionary *)params   success:(HttpSuccessBlock)success   failure:(HttpFailureBlock)failure;


+ (void)downloadImage:(NSString *)url   place:(UIImage *)place  imageView:(UIImageView *)imageView;



@end

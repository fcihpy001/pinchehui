//
//  HttpTool.m
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool
singleton_implementation(HttpTool)

//+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method{
//    //1、创建POST请求
//        //1.1
//        AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
//        //1.2拼接传来的参数
//        NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
//        if (params) {
//            [allParams setDictionary:params];
//        }
//        //1.3 创建request
//    NSURLRequest *request = [client requestWithMethod:method path:path parameters:allParams];
//    
//    //2.创建AFJSONRequestOperation对象
//    
//    NSOperation *operation  = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        
//        if (success == nil) return ;
//        success(JSON);
//            
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        
//        if (failure == nil)   return ;
//        failure(error);
//        
//    }];
//    
//    //3、发起请求
//    [operation start];
//    
//}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];
}

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView{
    
}

@end

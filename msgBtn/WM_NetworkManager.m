//
//  WM_NetworkManager.m
//  msgBtn
//
//  Created by 云媒 on 17/1/19.
//  Copyright © 2017年 Ritchie. All rights reserved.
//

#import "WM_NetworkManager.h"

@implementation WM_NetworkManager
{
    AFHTTPSessionManager * _sessionManager;
}
+(WM_NetworkManager *)shareInstance
{
    static WM_NetworkManager * shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setSessionManagerParameter];
    }
    return self;
}

- (void)setSessionManagerParameter
{
    //设置请求头参数
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _sessionManager.requestSerializer.timeoutInterval = 20;
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

//    [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

#pragma mark 数据请求封装
-(void)postPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *, NSError *))block
{
    
    [_sessionManager POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject,nil);
       
   

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
   
        block(nil,[error description]);
        
    }];
}


@end

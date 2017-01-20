//
//  WM_NetworkManager.h
//  msgBtn
//
//  Created by 云媒 on 17/1/19.
//  Copyright © 2017年 Ritchie. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface WM_NetworkManager : AFHTTPSessionManager
+ (WM_NetworkManager *)shareInstance;
-(void)postPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *, NSError *))block;
@end

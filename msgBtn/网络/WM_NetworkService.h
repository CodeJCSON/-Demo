//
//  WM_NetworkService.h
//  msgBtn
//
//  Created by 云媒 on 17/1/19.
//  Copyright © 2017年 Ritchie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WM_NetworkService : NSObject
//判断手机号是否已经被注册
+ (void)getPDACountGetListCountingWithiphone:(NSString *)iphone withUrl:(NSString *)url withBlock:(void(^)(NSDictionary * result, NSError * error))block;
@end

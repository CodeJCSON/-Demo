//
//  WM_NetworkService.m
//  msgBtn
//
//  Created by 云媒 on 17/1/19.
//  Copyright © 2017年 Ritchie. All rights reserved.
//

#import "WM_NetworkService.h"
#import "WM_NetworkManager.h"
@implementation WM_NetworkService

+ (void)getPDACountGetListCountingWithiphone:(NSString *)iphone withUrl:(NSString *)url withBlock:(void(^)(NSDictionary * result, NSError * error))block
{
    NSDictionary * params = @{@"mobile":iphone
                              };
    [[WM_NetworkManager shareInstance] postPath:url parameters:params withBlock:block];
}
@end

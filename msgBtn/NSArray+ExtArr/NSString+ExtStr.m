//
//  NSString+ExtStr.m
//  news1.0
//
//  Created by abc on 15/7/19.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "NSString+ExtStr.h"

@implementation NSString (ExtStr)
-(NSMutableArray *)substringByRegular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        
        int i=0;
        
        while (r.length != NSNotFound &&r.length != 0) {
            
            NSLog(@"index = %i regIndex = %lu loc = %lu",(++i),(unsigned long)r.length,(unsigned long)r.location);
            
            NSString* substr = [self substringWithRange:r];
            
            NSLog(@"substr = %@",substr);
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            
            r=[self rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}
@end

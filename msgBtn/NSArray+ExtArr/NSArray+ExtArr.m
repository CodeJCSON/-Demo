//
//  NSArray+ExtArr.m
//  iosxml2.0
//
//  Created by abc on 15/7/1.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "NSArray+ExtArr.h"

@implementation NSArray (ExtArr)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end

//
//  NSDictionary+ExtDic.m
//  iosxml2.0
//
//  Created by abc on 15/7/1.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "NSDictionary+ExtDic.h"

@implementation NSDictionary (ExtDic)
 - (NSString *)descriptionWithLocale:(id)locale
 {
       NSArray *allKeys = [self allKeys];
       NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
        for (NSString *key in allKeys) {
                 id value= self[key];
                 [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
             }
         [str appendString:@"}"];
        
         return str;
     }
@end

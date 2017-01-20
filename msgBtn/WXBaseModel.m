//
//  WXBaseModel.m
//  MTWeibo
//
//  Created by wangxinkai on 11-9-22.
//  Copyright 2011年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import "WXBaseModel.h"
#define HttpRegularExp @"http(s)?://([A-Za-z0-9._-]+(/)?)*"
#define AtRegularExp @"@[\\w]*"
#define ShipRegularExp @"#[\\w]*#"


@implementation WXBaseModel

-(id)initWithDataDic:(NSDictionary*)data{
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}

-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
	return nil;
}

- (NSString *)description{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);   
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
//            ITTDINFO(@"attributeName %@ value %@", attributeName, valueObj);
			if (valueObj) {
				[attrsDesc appendFormat:@" [%@=%@] ",attributeName, valueObj];		
				//[valueObj release];			
			}else {
				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];		
			}
			
		}
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 ) {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}else {		
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
    
	return desc;
}
-(void)setAttributes:(NSDictionary*)dataDic{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for (NSString *key in dataDic) {
            [dic setValue:key forKey:key];
            attrMapDic = dic;
        }
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self getSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
           
			NSString *dataDicKey = [attrMapDic objectForKey:attributeName];

            if ([dataDic objectForKey:dataDicKey]) {
                
            id attributeValue = [dataDic objectForKey:dataDicKey];

//            if (attributeValue == nil) {
//                if ([attributeName isEqualToString:@"body"]) {
//                    continue;
//                }
//                attributeValue = @"";
//            }            
            
            
			[self performSelectorOnMainThread:sel 
                                   withObject:attributeValue 
                                waitUntilDone:[NSThread isMainThread]];
                
            }
		}
	}
    
    
//    [self praseText:HttpRegularExp];
//    
//    [self praseText:ShipRegularExp];
//    [self praseText:AtRegularExp];
}

-(void)praseText:(NSString*)string{
    
    if(self.text.length>0){
        NSString* regex=string;
        
        NSRegularExpression* regular=[[NSRegularExpression alloc]initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray* items = [regular matchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length)];
        
        NSMutableArray* stringArr = [[NSMutableArray alloc]initWithCapacity:items.count];
        
        
        
        for(NSTextCheckingResult* resulet in items){
            
            NSRange rang =  resulet.range;
            
            NSString* orign = [self.text substringWithRange:rang];
            [stringArr addObject:orign];
            
            
        }
        
        for (int i = (int)items.count-1; i>=0; i--) {
            
            NSTextCheckingResult *res = items[i];
            
            NSRange range = res.range;
            
            
            NSString*originString = [self.text substringWithRange:range];
            
            
            if([string isEqualToString:HttpRegularExp]){
                
                
                
                self.text = [self.text stringByReplacingCharactersInRange:res.range withString:[NSString stringWithFormat:@"<a href='%@'>%@</a>",originString, @" 🔗网页链接"]];
                
            }else{
                
                NSString*newString = [NSString stringWithFormat:@"<a href='%@'>%@</a>",originString,originString];
                
                self.text = [self.text stringByReplacingCharactersInRange:res.range withString:newString];
            }
            
        }
        
        
        //        for(NSString* oringin in stringArr){
        //
        //            if([string isEqualToString:HttpRegularExp]){
        //
        //
        //                self.text = [self.text stringByReplacingOccurrencesOfString:oringin withString:[NSString stringWithFormat:@"<a href='%@'>%@</a>",oringin, @" 🔗网页链接"]];
        //
        //            }else{
        //                self.text = [self.text stringByReplacingOccurrencesOfString:oringin withString:[NSString stringWithFormat:@"<a href='http://www.baidu.com'>%@</a>",oringin]];
        //            }
        //            
        //        }
        
        
        
    }
    
    
}

- (id)initWithCoder:(NSCoder *)decoder{
	if( self = [super init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
			SEL sel = [self getSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel]) {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel 
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
				[encoder encodeObject:valueObj forKey:attributeName];	
			}
		}
	}
}
- (NSData*)getArchivedData{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (NSString *)cleanString:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@"" 
                                    options:NSCaseInsensitiveSearch 
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@"" 
                                    options:NSCaseInsensitiveSearch 
                                      range:NSMakeRange(0, [cleanString length])];    
    return cleanString;
}

#ifdef _FOR_DEBUG_  
-(BOOL) respondsToSelector:(SEL)aSelector {  
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
    return [super respondsToSelector:aSelector];  
}  
#endif

@end

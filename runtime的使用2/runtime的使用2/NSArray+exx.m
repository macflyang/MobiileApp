//
//  NSArray+exx.m
//  runtime的使用2
//
//  Created by mac on 2017/10/17.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "NSArray+exx.h"

@implementation NSArray (exx)
/*-(NSString *)descriptionWithLocale:(id)locale{
    
    
    NSLog(@"----------数组掉方法没有？？？------");
    
    NSMutableString *mStr=[NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@")"];
    
    
    
    
    return mStr.copy;
    
}*/
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    
    
   
    
    NSMutableString *mStr=[NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@")"];
    
    
    
    
    return mStr.copy;
    
   // NSLog(@"-----------99999000000000000------");
   
    
}
@end

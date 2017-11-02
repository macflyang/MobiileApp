//
//  NSObject+KeyValues.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "NSObject+KeyValues.h"
#import <objc/runtime.h>
@implementation NSObject (KeyValues)
//字典转模型：

+(id)objectWithKeyValues: (NSDictionary*)aDictionary{
    
    id objc=[self new];
    
    for (NSString *key in aDictionary.allKeys) {
        id value=aDictionary[key];
        // 判断当前属性是不是Model
      objc_property_t objectP=class_getProperty(self, key.UTF8String);//key.UTF8String把字符串类型的转换成 <#const char * _Nonnull name#> char * 类型的
        
        unsigned int outCount =0;
        
      objc_property_attribute_t *attributeList=  property_copyAttributeList(objectP, &outCount);
        objc_property_attribute_t attributeStructObject=attributeList[0];//就是取属性的名字
        NSString *typeString=[NSString stringWithUTF8String:attributeStructObject.value];
        if ([typeString isEqualToString:@""]) {

        }
        
        
        
        
        
    }
    return nil;
}
-(NSDictionary*)keyValuesWithObject{
    
    
    return nil;
}
@end

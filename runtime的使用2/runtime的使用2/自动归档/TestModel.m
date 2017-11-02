//
//  TestModel.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>
@implementation TestModel
- (void)encodeWithCoder:(NSCoder *)aCoder{//归档方法
    unsigned int outCount=0;
    Ivar * vars=class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
      const char * ivarName=  ivar_getName(vars[i]);
        
        NSString *key=[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        
        /*
           注意kvc的特性是，如果找到key这个属性的setter方法，则调用setterfangf
           如果找不到setter方法，则查找成员成员变量key或者_key，并且为其赋值
         所以这里不需要再另外处理成员变量名称的“_”前缀
         
         id va]
         
         */
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
        
        
        
        
    }
    
    
    free(vars);
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {//结档
        unsigned int outCount=0;
        Ivar * vars=class_copyIvarList([self class], &outCount);
        
        for (int i=0; i<outCount; i++) {
           const char *nameVar= ivar_getName(vars[i]);
            NSString *key=[NSString stringWithUTF8String:nameVar];
            id value=[aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
            
        
        
        }
        free(vars);
        
    }
    return self;
    
}
@end

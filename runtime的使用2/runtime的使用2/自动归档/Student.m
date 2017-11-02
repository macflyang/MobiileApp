//
//  Student.m
//  runtime的使用2
//
//  Created by mac on 2017/10/4.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>
@implementation Student
- (void)encodeWithCoder:(NSCoder *)aCoder{
    NSLog(@"student类中NSCoding----归档方法---encodeWithCoder");
    
    unsigned int count=0;
    
    // 得到类中的所有的属性列表
    Ivar * ivars=class_copyIvarList([self class], &count);
    
    for (int i=0; i<count; i++) {
        Ivar ivar=ivars[i];//取出i位置对应的属性变量
        //查看属性变量的名字
        const char * ivarName=ivar_getName(ivar);
        //将c转换成NSString类型的作为key值
        NSString *key=[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        id value=[self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
        
        
        
        
    }
    
    //要释放c语言中copy的变量
    free(ivars);
    
    
    
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"student---结档时调用的方法-----initWithCoder");
    unsigned int count=0;
    
    Ivar * ivars=class_copyIvarList([self class], &count);
    for ( int i=0; i<count; i++) {
        
        const char * ivarName=ivar_getName(ivars[i]);
        
        NSString *key=[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        //结档key 赋值给属性value
       id value= [aDecoder decodeObjectForKey:key];
        //在设置成员变量身上
        
       // _age=[aDecoder DE]
        [self setValue:value forKey:key];
        
    }
    free(ivars);
    
    
    
    
    
    
    
    return self;
    
    
    
    
}
@end

//
//  UIImage+JJAdd.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "UIImage+JJAdd.h"
#import <objc/runtime.h>
@implementation UIImage (JJAdd)
-(void)setName:(NSString *)name{
    [self willChangeValueForKey:NSStringFromSelector(@selector(name))];
    objc_setAssociatedObject(self, _cmd, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //[self didChangeValueForKey:NSStringFromSelector(NSStringFromSelector(name))];
    
    
}
-(NSString*)name{
    
    
    
    return objc_getAssociatedObject(self, @selector(setName:));
}
-(void)setAdd:(CGFloat)add{
    [self willChangeValueForKey:NSStringFromSelector(@selector(add))];
    NSValue * value=[NSValue value:&add withObjCType:@encode(CGFloat)];
    
    
    
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:NSStringFromSelector(@selector(add))];
    
}
-(CGFloat)add{
    
    CGFloat cValue={0};
    NSValue *value=objc_getAssociatedObject(self, @selector(setAdd:));
    
    [value getValue:&cValue];
    return cValue;
    
}
@end

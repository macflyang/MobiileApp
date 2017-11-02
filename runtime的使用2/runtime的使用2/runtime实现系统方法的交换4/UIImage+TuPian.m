//
//  UIImage+TuPian.m
//  runtime的使用2
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "UIImage+TuPian.h"
#import <objc/runtime.h>
@implementation UIImage (TuPian)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class=[self class];
        SEL originalSelector=@selector(imageNamed:);
        SEL newSelector=@selector(tuP_imageNamed:);
        
      //实例方法
      /*
        Method origialMethod=class_getInstanceMethod(class, originalSelector);
        Method newMethod=class_getInstanceMethod(class, newSelector);
       */
        
       //我们现在需要的是类方法：
        
        Method origialMethod=class_getClassMethod(class, originalSelector);
        Method newMethod=class_getClassMethod(class, newSelector);
        //方法的添加 先尝试添加原selector是为了做一层的保护：class_addMethod(); 如果这个类中没有实现origalSelector,但是其父类实现了，那么class_getInstanceMethod返回的将是父类的方法。这样就导致method_exchangeImplementations替换的是父类的方法，所以先尝试添加origialSelector。如果已经存在，再用method_exchangeImplementations把原来的方法的实现交换成新方法的实现：
        
        
        
        class_addMethod(class, originalSelector, class_getMethodImplementation(class, originalSelector), method_getTypeEncoding(origialMethod));
        
        
        class_addMethod(class, newSelector, class_getMethodImplementation(class, newSelector), method_getTypeEncoding(newMethod));
        
       
        //交换方法
        
        method_exchangeImplementations(origialMethod, newMethod);
       //总结：方法的交换只能执行一次。不要总是执行，load的意义就在此
        
        
    });
    
    
    
    
}
//
#pragma mark - 交换系统的方法
+(nonnull UIImage*)tuP_imageNamed:(NSString*)name {
    
  /**
   在这里实现我们所需要做的操作
   
   
   */
    
   
    double systemVersion=[[[UIDevice currentDevice]systemVersion] floatValue];
    
    
    if (systemVersion>=9.0) {
        name=[name stringByAppendingString:@"_os"];
    }
    
    UIImage *image=[UIImage tuP_imageNamed:name];
    return image;
    
    
    
}




@end

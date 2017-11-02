//
//  NSObject+Model.m
//  runtime的使用2
//
//  Created by mac on 2017/10/4.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>
@implementation NSObject (Model)

const char* kPropertyListKey="YFPropertyListKey";
//模型转字典
+(NSArray *)cfy_objcProperty{
    //获取关联的对象----
    NSArray *ptyList=objc_getAssociatedObject(self, kPropertyListKey);
    
    if (ptyList) {
        return ptyList;
    }
   // 1.获取类的成员的变量 class_copyIvarList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
   //2.获取类的方法 class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
   //3.获取类的property属性 class_copyPropertyList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
   //4.获取类的代理方法 class_copyProtocolList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)

    unsigned int count=0;
    //获取属性列表
  objc_property_t *objPro=  class_copyPropertyList([self class], &count);
    NSMutableArray *mutableArray=[NSMutableArray arrayWithCapacity:10];
    //遍历属性列表
    for (int i=0; i<count; i++) {
        //objPro[i]-----获取i位置的属性
      const char *properName=  property_getName(objPro[i]);
        //把c字符串转换成oc字符串
        NSString *key=[NSString stringWithCString:properName encoding:NSUTF8StringEncoding];
        
        [mutableArray addObject:key];
     
    }
    //objc_AssociationPolicy
    
    // 设置关联的对象：
    //设置属性列表, 就是把已经生成好的属性列表设置到一个类似于属性的东西储存起来, 下次 get 的时候,直接拿出来用即可,有点类似于懒加载.
    
    objc_setAssociatedObject(self, kPropertyListKey, mutableArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    /*  1.对象self 2.动态添加的属性的key 3.动态添加属性的值 4.对象的引用关系*/
    free(objPro);
    return mutableArray.copy;
    
}

/*
 字典转模型的核心算法思路
 
 以往, 我们字典转模型,总是需要在模型类中定义一个静态方法或者对象方法,来字典转模型, 这样, 我们在不同的模型中, 都必须定义这样一个方法来完成字典转模型, 如果我们写的项目比较大, 模型比较多,这样字典转模型的效率就太低了,耦合性也比较高, 那我们如何做到字典转模型 与 模型类的彻底解耦呢?
 
 我们可以创建一个 NSObject 的分类, 因为所有的类(NSProxy 除外)都继承自 NSObject, 那我们就可以用任意的类去调 NSObject 的这个分类方法, 子类可以任意调用父类方法嘛
 
 
 
 */
//字典转模型
+(instancetype)cfy_objctWithDict:(NSDictionary*)dict{
    //1. 实例化对象
    id objcBen=[self new];//
    //2.获取self的属性列表
    NSArray * propertyList=[self cfy_objcProperty];
     //dict 是传过来的----遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //判断key是否在propertyList中
        if ([propertyList containsObject:key]) {
           
        //说明属性存在 ，可以使用kvc设置数值
            [objcBen setValue :obj forKey:key];
        }
    }];
    //people的模型中---与 传来字典dict的模型key是否相同；
    return objcBen;
}



@end

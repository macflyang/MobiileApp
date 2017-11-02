//
//  main.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface TestClass1 :NSObject
{
    int x;
    int y;
    int z;
    
    
}
@property  int x;
@property int y;
@property int z;

@end
@implementation TestClass1
@synthesize x,y,z;
@end
@interface testKVC: NSObject
{
    NSString * toSetName;
    NSString *isName;
   NSString *_name;
    NSString *_isName;
    
    
}
@end
@implementation testKVC
+(BOOL)accessInstanceVariablesDirectly{
  // 默认返回YES，表示如果没有找到Set方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索
    
    return YES;
}
//-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"取出key的时候出现异常，该key不存在%@",key);
//    return nil;
//}
-(id)valueForUndefinedKey:(NSString *)key{
    
    NSLog(@"取出key的时候出现异常，该key不存在%@",key);
    return nil;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"设置setvalue的时候出现异常，该key不存在%@",key);
}

@end
static NSArray * ClassMethodNames(Class c){
    NSMutableArray *array=[NSMutableArray array];
    unsigned int methodCount=0;
    Method *methodList=class_copyMethodList(c, &methodCount);
    for (int i=0; i<methodCount; i++) {
       SEL methodName= method_getName(methodList[i]);
        NSString *strName=NSStringFromSelector(methodName);
        [array addObject:strName];
        
        //[self valueForKey:]
        // id value=[array valueForKey:strName];
    }
    
    free(methodList);
    return array.copy;
    
}

static void PrintDescription(NSString *name,id obj){
    
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods <%@>",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n", [str UTF8String]);
   // ClassMethodName(<#__unsafe_unretained Class c#>)
   // NSString *str=[NSString stringWithFormat:@"%@:%@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods<%@>",name,obj,class_getName([obj class]), class_getName(obj->isa),[ClassMethodNames(obj->isa) componentsJoinedByString:@", "]];
    
}
@interface Adderss : NSObject
@end
@interface Adderss()
@property(nonatomic,copy)NSString * country;
@property(nonatomic,strong)NSMutableArray * arr;
@property(nonatomic,copy)NSString * province;
@property(nonatomic,copy)NSString * city;
@property(nonatomic,copy)NSString*district;
@property(nonatomic,strong)NSArray * arr1;
@end
@implementation Adderss

-(id)init{
    
    if (self=[super init]) {
        _arr=[NSMutableArray array];
        [self addObserver:self forKeyPath:@"arr" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    NSLog(@"MutableArray---------%@",change);
}
-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"arr"];
    
}
-(void)addItem{
    [_arr addObject:@"1"];
    
}
-(void)addItemObserver{
    [[self mutableArrayValueForKey:@"arr"] addObject:@"2"];
    
}
-(void)removeItemObserver{
    [[self mutableArrayValueForKey:@"arr"] addObject:@"22"];
    
    
}



@end
@interface PeopleTwo : NSObject
@end
@interface PeopleTwo()
@property(nonatomic,copy)NSString * nameP;
@property(nonatomic,strong)Adderss*address;
@property(nonatomic,assign)NSInteger age;

@end
@implementation PeopleTwo
-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"--peopleTwo的键值不能设置为nil----%@",key);
    
}
@end
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        /*第二部分：kvc中使用keyPath**/
        PeopleTwo * twoP=[PeopleTwo new];
        Adderss * add=[Adderss new];
        add.country=@"China";
        twoP.address=add;
        NSString * country1=twoP.address.country;
        NSString * country2=[twoP valueForKeyPath:@"address.country"];
        NSLog(@"country==%@,country2==%@",country1,country2);
        
        [twoP setValue:@"USA" forKeyPath:@"address.country"];
        
        country1=twoP.address.country;
        
        country2=[twoP valueForKeyPath:@"address.country"];
        
        NSLog(@"2222--------%@--country2------%@",country1,country2);
         [twoP setValue:nil forKey:@"age"];
    //而kvc对于KeyPath是搜索机制第一步是分离key,用小数点.来分割key。然后再像普通key一样按照先前介绍的顺序搜索下去。
        
   /*
    第三部分：kvc如何处理异常的
    
    kvc中最常见的异常就是不小心使用了错误的key。或者在设值中不小心传递了nil的值，kvc中有专门的方法来处理这些异常。
    通常在用kvc操作model时。抛出异常的那两个方法是需要重写的。虽然一般很小出现传递了错误的key值这种情况。但是如果不小心出现了。直接抛出异常让app崩溃显然是不合理的。
    
    
     一般在这里直接让这个Key打印出来即可，或者有些特殊情况需要特殊处理。
    通常情况下，kvc不允许你要在调用setValue ：forKey : 时对对象传递一个一个nil的值，很简单，因为只类型是不能为nil的。如果你不小心传了。kvc会调用setNilValueForKey：方法。这个方法默认是抛出异常的。所以一般而言最好还是重写这个方法。
    
    **/
       
        
        
        
        
        /*第四部分： kvc处理非对象和自定义对象*
         
         不是每一个方法都返回对象，但是valueForKey：总是返回一个id 对象，如果原本的变量类是值类型或者结构体，返回值会封装成NSNumber 或者NSValue对象。这两个类会处理从数字，布尔到指针和结构体任何类型。然后开发者需要手动转换成原来的类型。尽管valueForKey：会自动将值类型封装成对象，但是setValue：forKey：却不行。你必须手动将值类型转换成NSNumber或者NSValue类型。才能传递过去。
         
         
         对于自定义对象，kvc也会正确以设值和取值。因为传递进去和取出来的都是id类型，所以需要开发者自己担保类型的正确性。运行obj-c 在发送消息的时候会检查类型。如果错误会直接抛出异常。
         
         
         
         
         */
        Adderss *add2=[Adderss new];
        add2.country=@"England";
        [twoP setValue:add2 forKey:@"address"];
        NSString * country11=twoP.address.country;
        NSString * country22=[twoP valueForKeyPath:@"address.country"];
        NSLog(@"country11-----%@,country22----%@",country11,country22);
        
  /*第四部分：kvc与容器类*
   
   
   
   
   
   
   
   */
        
        Adderss *add12=[Adderss new];
        [add12 addItem];
        [add12 addItemObserver];
        
        [add12 removeItemObserver];
        
        
        add12.country=@"china";
        add12.province=@"guandong";
        add12.city=@"shen zhen";
        add12.district=@"zhongshan";
        NSArray * arrayy=@[@"country",@"province",@"city",@"district"];
        
        NSDictionary * dict=[add12 dictionaryWithValuesForKeys:arrayy];
        NSLog(@"----dict-----%@",dict);
        NSDictionary * moDict=@{@"country":@"USA",@"province":@"jiji",@"city":@"newYork",@"district":@"kkkk"};
        
        [add12 setValuesForKeysWithDictionary:moDict];
        
        NSLog(@"country---%@,province: %@ city:%@,",add12.country,add12.province,add12.district);
        
        
        
        
        
        
        
        
        
        
        
        
        NSArray* arrStr = @[@"9999",@"franch",@"chinese"];
       
        
       NSArray* arrCapStr = [arrStr valueForKey:@"capitalizedString"];//首字母大写
        for (NSString* str  in arrCapStr) {
            NSLog(@"%@",str);
        }
//        NSArray* arrCapStrLength = [arrStr valueForKeyPath:@"capitalizedString.length"];
//        for (NSNumber* length  in arrCapStrLength) {
//            NSLog(@"%ld",(long)length.integerValue);
//        }
        
        
        
        
        
        
        
        
        //KVC----
     testKVC *kvcT=[testKVC new];
        
        [kvcT setValue:@"newName" forKey:@"name"];
    NSString *name=[kvcT valueForKey:@"_isName"];//没有找到Set方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员
        /*  kvc在内部是按什么样的顺序来寻找key的呢：当调用setValue:forKey
         的代码的时候，底层机制如下：
         1.程序优先调用set: 属性值方法，代码通过setter方法完成设置，注意，这里的指的是成员变量名，首字母大小写要符合kvc的全名规则，
         2.如果没有找到setName：方法，kvc机制会检查 +（BOOL）accessInstanceVariablesDirectly方法有没有返回yes ，默认该返回yes，如果你重写了该方法让其返回no的话，那么在这一步kvc会执行setValue：forUNdefinedKey：方法，不过一般开发者不会这么做，所以kvc机制会搜索该类里面有没有名为_的成员变量，无论该变量是在类接口部分定义，还是在类实现部分定义，也无论用了什么样的访问修饰符，只在存在以_命名的变量，kvc都可以对该成员变量赋值。
         3.如果该类中没有set：方法，也没有_成员变量，kvc机制会搜索_is的成员变量。
         4.如果也没_is成员的变量，kvc机制再会继续搜索和is的成员变量，再给他们赋值
         5.如果没有上面所说的====系统将会执行该对象的setValue：forUndefineKey:方法，默认是抛出异常。
         
         
         
         set:方法---》（bool 返回No）setValue:forUndefineKey方法---_name --_isName --name --isName ---》setValue：forUndefineKey方法
         
         */
        
        
        
     NSLog(@"name------%@",name);
        
       
        
        
        
        
        
        TestClass1 *x=[TestClass1 new];
        TestClass1* y=[TestClass1 new];
        TestClass1 *xy=[TestClass1 new];
        
        TestClass1 *control=[TestClass1 new];
        
        [x addObserver:x forKeyPath:@"x" options:0 context:NULL];
        [xy addObserver:xy forKeyPath:@"x" options:0 context:NULL];
        
        [y addObserver:y forKeyPath:@"y" options:0 context:NULL];
        
        [xy addObserver:xy forKeyPath:@"y" options:0 context:NULL];
        
        PrintDescription(@"control", control);
        PrintDescription(@"x", x);
        PrintDescription(@"y", y);
        PrintDescription(@"xy", xy);
        
        NSLog(@"NSObject 的方法：，setX: ---%p  overriden SetX:---%p",[control methodForSelector:@selector(setX:)],
              [x methodForSelector:@selector(setX:) ]);
        
        NSLog(@"USing libObjc  functions, normal setX:---%p,overridden setX: IS===%p",method_getImplementation(class_getInstanceMethod(object_getClass(control), @selector(setX:))),
              method_getImplementation(class_getInstanceMethod(object_getClass(x), @selector(setX:))));
        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

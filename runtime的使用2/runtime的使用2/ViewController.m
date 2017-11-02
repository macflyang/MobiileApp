//
//  ViewController.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIButton+ClickButton.h"
#import "UIImage+JJAdd.h"
#import "BlockButton.h"
#import "Student.h"
#import "PeopleP.h"
#import "NSObject+Model.h"
#import "ViewController01.h"
@interface ClassCustom :NSObject
{
    
    NSString * varTest11;
    NSString *varTest22;
    NSString * varTest33;
    
}



@property(nonatomic,assign)NSString * varTest1;
//@property(nonatomic,assign)NSString * varTest2;
//@property(nonatomic,assign)NSString * varTest3;
-(void)fun1;

@end

@implementation ClassCustom

-(void)fun1{
    
    NSLog(@"FUN1---custom");
    
    ///jjdjjdjdjjdjjkgdjgljf
}

@end

@interface ClassTwo : NSObject
{
    int varTwo;
    
    
}
-(void)twofun;

@end
@implementation ClassTwo
-(void)twofun{
    NSLog(@"twoFun---");
    
    
}


@end

@interface ViewController ()
{
    float myFloat;
    ClassCustom * allobj;
    
    
}
@property(nonatomic,strong)NSString *nameString;
@property(nonatomic,copy)NSString *nameString2;
@end

@implementation ViewController

//6.1获取类中所有的方法
-(void)getAllMethod{
    
    u_int count;
    Method *methods=class_copyMethodList([self class], &count);
    
    for (int i=0; i<count; i++) {
        SEL name=method_getName(methods[i]);
        NSString * strName=[NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",strName);
    
    
    }
    
}
//6.2获取类中所有的方法
-(void)getAllClassMethod{
    
    u_int count;
   /* Method *method=class_copyMethodList([self class], &count);
    for (int i=0; i<count; i++) {
        SEL name=method_getName(method[i]);
        NSString *strName=[NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"方法的名字：%@",strName);
        
        
    }*/
   //  记忆一下：
    
    //1.class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)//获取某个类的 方法列表， 个数：&count
    
   //2. method_getName(<#Method  _Nonnull m#>)//获取方法
    //3.   sel_getName(<#SEL  _Nonnull sel#>)//获取方法的名字
    
    /*
    OBJC_EXPORT const char * _Nonnull
    sel_getName(SEL _Nonnull sel)
    OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0, 2.0);
*/
    
    //4.[NSString stringWithCstring:sel_getName(name) encoding:NSUTF-8StringEncoding];把char类型的字符串转换成字符串类型的
    
    
    Method * methodd=class_copyMethodList([ClassCustom class], &count);
    
    for (int i=0; i<count; i++) {
        SEL name=method_getName(methodd[i]);
        const char * tt=sel_getName(name);
        NSString *strN=[NSString stringWithCString:tt encoding:NSUTF8StringEncoding];
        
        NSLog(@"-------ok------%@",strN);
        
        
    }
    
    
}
//7.1获取类中所有的Property属性：
-(void)getClassProperty{
    
    u_int count;
    
    /*
    Method *method=class_copyMethodList([self class], &count);
    for (int i=0; i<count; i++) {
       SEL sel= method_getName(method[i]);
        
        const char * selName=sel_getName(sel);
        NSString *selNamee=[NSString stringWithCString:selName encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",selNamee);
        
    }
    */
    objc_property_t * objProperty=class_copyPropertyList([ClassCustom class], &count);
    for (int i=0; i<count; i++) {
        const char * properyN= property_getName(objProperty[i]);
        NSString *prpName=[NSString stringWithCString:properyN encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",prpName);
    }
    
    
    
   /* objc_property_t *objProperty=  class_copyPropertyList([ClassCustom class], &count);
    
    for (int i=0; i<count; i++) {
      const char * property=  property_getName(objProperty[i]);
        NSString *properName=[NSString stringWithCString:property encoding:NSUTF8StringEncoding];
        NSLog(@"property---------属性%@",properName);
    
    }
    
   */
    
}

-(void)getinstaceVar{
    
    //获取、设置类的属性变量
    float myFloatValue;//设置一个参数来获取变量myFloat的值
    
   // Ivar varr=  object_getInstanceVariable(self,"myFloat", (void*)&myFloatValue);
   //Ivar iva= object_getInstanceVariable(self,"myFloat",(void*)&myFloatValue);
   // NSLog(@"%f",myFloatValue);
    
   // object_getInstanceVariable(id _Nullable obj, const char * _Nonnull name,
                  //             void * _Nullable * _Nullable outValue)
    
}
-(void)setInstanceVar{
    
   // float newValue=100.00;
    //unsigned int addr=(unsigned int)&newValue;
    
   // object_setInstanceVariable(<#id  _Nullable obj#>, <#const char * _Nonnull name#>, <#void * _Nullable value#>)
    //unsigned int
    
    
    float newvalue=10.00f;
    //float myfloat
    
    //unsigned float addr=(unsigned float)&newvalue;
    
  //  object_setInstanceVariable(self,"myFloat", (float*)&newvalue);
    
    //object_getInstanceVariable(self, "myfloat", *(float**)addr);
    //object_getInstanceVariable(self,"myfloat", (void*)&myFloatValue);
    NSLog(@"%f",myFloat);
    
   /* ClassCustom * cus=[ClassCustom new];
    [cus fun1];
   Class ac= object_setClass(cus, [self class]);
    NSLog(@"ac-----%@",NSStringFromClass(ac));
      [[ac new] fun1];
    NSLog(@"cus-----%@",NSStringFromClass([cus class]));
    [cus getinstaceVar];*/
   // object_setInstanceVariable(self, "myFloat", *(float**)addr);
    
   // NSLog(@"%f",myFloat);
    
    
    [self cateoryTest];
    [self UIIMAGE];
    
}
-(void)UIIMAGE{
    
    UIImage * IM=[UIImage new];
    IM.name=@"jjj";
    
    
}
-(void)cateoryTest{
    
    UIButton *BUTTON=[UIButton buttonWithType:UIButtonTypeCustom];
    BUTTON.frame=self.view.bounds;
    [self.view addSubview:BUTTON];
    BUTTON.click = ^{
        NSLog(@"HAO 类别的属性哦");
    };
    
    
}
- (IBAction)btnbbb:(id)sender {
    NSLog(@"00000");
    ViewController01  * vc=[ViewController01 new];
     //[vc popViewControllr];
    
   // __weak ViewController01 * weakVc=vc;
    __unsafe_unretained ViewController01 * weakVc=vc;
    vc.backBlock = ^(NSString *str, int a) {
        NSLog(@"%@-%d",str,a);
        ViewController01 *strongVc=weakVc;
        [strongVc popViewControllr];
        
    };
    vc.blockb = ^(NSArray *ar) {
        NSLog(@"oo---%@",ar);
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    //TwoViewController * twoView = [[TwoViewController alloc]init];
//    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:navigation animated:YES completion:nil];

}

/**
 快速排序：
 
 */

void  swap(int *a,int *b){
    
//    (*a)=(*a)^(*b);
//    (*b)=(*a)^(*b);
//    (*a)=(*a)^(*b);
    
    int temp;
    temp=*a;
    *a=*b;
    *b=temp;
    

//    int temp;
//
//    temp = *a;
//    *a = *b;
//    *b = temp; 
    
}
//快速排序：时间的复杂度为O（nlogn）
void quitePaiXu(int array[],int maxLen,int begin,int end){
    int i, j;
    
    
    if (begin<end) {
        i=begin +1;
        
        j=end;
        
        while (i<j) {
            // 5.... >2
            
            if (array[i]>array[begin]) {//int   95>5 array[10]={5,95,57,67,88,32,33,45,56,79};
             
                
                swap(&array[i], &array[j]);
                j--;
            }else{
                
                i++;
            }
            
        }
        
        if (array[i]>=array[begin]) {
            i--;
        }
        
        swap(&array[begin], &array[i]);
        quitePaiXu(array, maxLen, begin, i);
        
        quitePaiXu(array, maxLen, j, end);
        
        
        
    }
    
    
}
void dispatchhh(int arr[],int maxL){
    int i;
    
    for(i = 0; i < maxL; i++)
    {
        printf("%-3d", arr[i]);
    }
    printf("\n");
//    for (int i=0; i<maxL; i++) {
//        NSLog(@"----%d",arr[i]);
//    }
    
    
}

//  冒泡排序：时间的复杂度：O(n^2)

void maoPao(int arr[],int len){
    int temp=0;
    for (int i=0; i<len-1; i++) {
        for (int j=0; j<len-i-1; j++) {
            if (arr[j]>arr[j+1]) {
                temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
                
                
                
            }
        }
    }
    
    
}

//选择排序：
void xuZePaiXun(int arr[],int len){
    
    int temp=0;
    for ( int i=0; i<len-1; i++) {
        for (int j=i+1; j<len; j++) {
            if (arr[i]>arr[j]) {
                temp=arr[i];
                arr[i]=arr[j];
                arr[j]=temp;
            }
        }
    }
    
    
    
}
//插入排序：
void chaRuPaiXun(int *a ,int len){
    
    int i,j,key;
    for (j=1; j<len; j++) {
        key=a[j];//取出一个值
        
        i=j-1;//
        
        while (i>=0&&a[i]>key) {
            a[i+1]=a[i];
            i--;
        }
        a[i+1]=key;
        
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *ARR=@[@"奇爱",@"我我"];
    
    NSLog(@"99999----------------%@",ARR);
    
    
    
    
   int arr[10]={5,2,57,67,88,32,33,45,56,79};
   // maoPao(arr, 10);
    //xuZePaiXun(arr, 10);
    chaRuPaiXun(arr, 10);
    
    for (int i=0; i<10; i++) {
        NSLog(@"0000-----------%d",arr[i]);
    }
    
//
//    int maxLen=10;
//    quitePaiXu(array, maxLen, 0, maxLen-1);
//
//    dispatchhh(array, maxLen);
    
    int n;
    int array[10] = {12,85,25,16,34,23,49,95,17,61};
    int maxLen = 10;
    
    printf("排序前的数组\n");
   // display(array, maxlen);
    dispatchhh(array, maxLen);
   // quicksort(array, maxlen, 0, maxlen-1);  // 快速排序
    quitePaiXu(array, maxLen, 0, maxLen-1);
    printf("排序后的数组\n");
   // display(array, maxlen);
   dispatchhh(array, maxLen);
    
    
    
    
    
    myFloat=9.1;
    
    
    Student * student=[Student new];
    student.age=@(18);
    student.name=@"小妹妹";
    student.phoneNumber=@(1999);
    student.height=@(100);
    
    //路径
    NSString *filePath=[NSHomeDirectory() stringByAppendingPathComponent:@"stud.archiver"];
    
    BOOL success=[NSKeyedArchiver archiveRootObject:student toFile:filePath];
    if (success) {
        NSLog(@"student归档成功");
    }
    
    //结档：
    
    Student * str=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    NSLog(@"%@_%@_%@_%@",str.name,str.age,str.phoneNumber,str.height);
    
    /*****2222*使用字典转换成模型**********/

    
    NSDictionary * dict=@{
                          @"name":@"小明",
                          @"age":@18,
                          @"title":@"master",
                          @"height":@1.7,
                          @"something":@"nothing"
                          
                          
                          };
    
    PeopleP *p=[PeopleP cfy_objctWithDict:dict];
    NSLog(@"--------%@",p.name);
    
    
    
    
    
    
    //[self getAllMethod];//获取类中所有的方法
    //[self getClassProperty];//获取property声明的属性
    
   // [self getAllClassMethod];
    
   // [self getinstaceVar];//获取属性的值
    
    
   // [self setInstanceVar];//设置属性的值：
    
   /*
    BlockButton * btn=[BlockButton init];
    btn.frame=self.view.bounds;
    [self.view addSubview:btn];
    btn.blockB = ^(UIButton *btn) {
        NSLog(@"woshibtn");
    };
    
    */
    /**
     block 的基本概念：
     int    （^block名）   (参数int)  =  ^(int a)  { return  a * a; }
     返回值 声明一个block块 它有一个参数      参数的名字 这是定义对象的语法结构 ，这部分就是赋值给block名 变量的值
     
     
     
     void （^myBlock）(void)=^(void){   };
     
     1.有参数有返回值
     2.有参数无返回值
     3.无参数有返回值
     4.无参数无返回值
     void (^block名)()=^(){};
     
     
     */
    
    //1.无参数无返回值的
    void (^myBlock)(void)=^{
        NSLog(@"无参数无返回值");
        
        
    };
    myBlock();
    //2.有参数无返回值
    void (^myBlock2)(int)=^(int b){
        
        NSLog(@"b====%d",b);
    };
      myBlock2(2);
    //3.无参数有返回值：
    int (^myBlock3)()=^{
        
        return 3;
        
    };
    int a=myBlock3();
    NSLog(@"a------%d",a);
    
    //4.有参数有返回值：
    
    NSString *(^myBlock4)(NSString*,int)=^(NSString *str,int K){
        
        
        return [NSString stringWithFormat:@"%@--%d",str,K];
    };
    
    NSString *str4=myBlock4(@"我爱你孟夏",9);
    
    NSLog(@"str4-----%@",str4);
    
    //object_setClass(<#id  _Nullable obj#>, <#Class  _Nonnull cls#>)
    
    // Do any additional setup after loading the view, typically from a nib.
// block 为什么使用block
    /*
     1.BlocK的内部没有调用外部变量时存放在全局区（ARC和MRC下均是）
     2.block 使用了外部变量。这种情况也正是我们平时所常用的方式，block的内存地址显示在栈区，栈区的特点就是创建的对象随时可能被销毁，一旦被销毁后续再次调用对象就可能会造成程序崩溃，在对block进行copy后，block存放在堆区，所以在使用block属性时使用copy 修饰，而在ARC模式下，系统也会默认对block进行copy操作。
     
     
     */
    
    //字符串为什么用copy
    //one 使用strong的时候
    NSMutableString *  str1=[NSMutableString string];
    
    [str1 appendString:@"hello" ];
    
    self.nameString=str1;
    
    
    NSLog(@"nameString-1（strong属性）--%@",self.nameString);//输出hello
    [str1 appendString:@"World"];
    
    NSLog(@"--当给str1又添加属性的时候---2---%@",self.nameString);//输出：helloWorld
    // 因为把可变字符的地址指向了str ，所以string的值改变了，self》nameString的值也跟着改变。
    
    
    
    // two ----使用copy的时候：
    
   // ---------两次都输入：hello
    //int o=8;
    void (^DemoBlock)()=^{
        
        
        NSLog(@"demoBlock");
    };
    NSLog(@"%@",DemoBlock);//全局block NSGlobalBlock__:0x107b6c3b0
   //__block int iii=9;
    __weak NSString *strY=@"AB";
    void (^DemoBlock2)(void)=^{
        
       NSString*SO= [strY stringByAppendingFormat:@"999"];
        NSLog(@"%@",SO);
        
        
        
        
    };
    NSLog(@"%@",DemoBlock2);
    DemoBlock2();
   //2种情况： //(MRC下)<__NSStackBlock__: 0x7fff5cd1b320>
             //(ARC下) <__NSMallocBlock__: 0x60000005ef90>//因为ARC下调用外部变量的时候系统 自动对block进行了copy---
    
    NSLog(@"copy---%@",[DemoBlock2 copy]);//__NSMallocBlock__: 0x60000005ef90>
    
    
    
    
}
/**
 block 的基本概念：
 int    （^block名）   (参数int)  =  ^(int a)  { return  a * a; }
 返回值 声明一个block块 它有一个参数      参数的名字 这是定义对象的语法结构 ，这部分就是赋值给block名 变量的值
 
 
 
 void （^myBlock）(void)=^(void){   };
 
 
 
 */



//字符串为什么用copy ：










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

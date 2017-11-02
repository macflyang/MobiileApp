//
//  UIButton+ClickButton.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "UIButton+ClickButton.h"
#import <objc/runtime.h>
static const void * kAssociated="associated";
@implementation UIButton (ClickButton)
-(void)setClick:(ClickB)click{
    objc_setAssociatedObject(self, kAssociated, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonC) forControlEvents:UIControlEventTouchUpInside];
    if (click) {
         [self addTarget:self action:@selector(buttonC) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
}
-(ClickB)click{
    
   // objc_getAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>)
    return objc_getAssociatedObject(self, @selector(setClick:));
   // return objc_getAssociatedObject(self, kAssociated);
    
    
}
-(void)buttonC{
    
    if (self.click) {
        self.click();
    }
    
}
@end

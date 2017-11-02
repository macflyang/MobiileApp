//
//  ViewController01.h
//  runtime的使用2
//
//  Created by mac on 2017/10/7.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^callBackBlock) (NSString * str,int a);
typedef void(^blockB) (NSArray*ar);

typedef void(^blokBB) (NSNumber * Numm);

@interface ViewController01 : UIViewController

-(void)popViewControllr;
-(void)push;
@property(nonatomic,copy)callBackBlock backBlock;
@property(nonatomic,copy)blockB blockb;

@property(nonatomic,copy)blokBB bll;
@end

//
//  UIButton+ClickButton.h
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickB)(void);
@interface UIButton (ClickButton)
@property(nonatomic,copy)ClickB click;
@end

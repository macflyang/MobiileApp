//
//  Student.h
//  runtime的使用2
//
//  Created by mac on 2017/10/4.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSNumber *age;
@property(nonatomic,copy)NSNumber *phoneNumber;
@property(nonatomic,copy)NSNumber *height;
@end

//
//  TestModel.h
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject<NSCoding>



@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,copy)NSNumber *phoneNumber;
@property(nonatomic,copy)NSNumber *height;
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)TestModel * son;



@end

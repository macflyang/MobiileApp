//
//  NSObject+KeyValues.h
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValues)
+(id)objectWithKeyValues: (NSDictionary*)aDictionary;
-(NSDictionary*)keyValuesWithObject;
@end

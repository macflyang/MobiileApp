//
//  NSObject+Model.h
//  runtime的使用2
//
//  Created by mac on 2017/10/4.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)
+(NSArray *)cfy_objcProperty;//字典转模型
+(instancetype)cfy_objctWithDict:(NSDictionary*)dict;//模型转字典
//+ (NSArray *)yf_objcProperties;
//+ (instancetype)yf_objcWithDict:(NSDictionary *)dict;
@end

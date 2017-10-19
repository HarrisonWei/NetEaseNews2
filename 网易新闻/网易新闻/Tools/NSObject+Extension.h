//
//  NSObject+Extension.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/16.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
+ (instancetype)objcWithDict:(NSDictionary *)dict;
+ (NSArray *)loadPropertis;
@end

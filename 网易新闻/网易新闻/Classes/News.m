//
//  News.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
@implementation News
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)newsWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (NSString *)description{
    //自定义输出
    return [NSString stringWithFormat:@"%@{title = %@,imgsrc = %@}",[super description],self.title,self.imgsrc];
}

+ (void)loadNewsListWithUrlString:(NSString *)urlString{
    [[NetworkTools sharedNetworkTools] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSLog(@"%@",responseObject.keyEnumerator.nextObject);
        //我要拿到数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@",array);
        //遍历数组字典转模型
        NSMutableArray *nmArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            News *news = [News newsWithDict:obj];
            [nmArray addObject:news];
        }];
        NSLog(@"%@",nmArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end






















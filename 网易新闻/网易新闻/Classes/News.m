//
//  News.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import "NSObject+Extension.h"
@implementation News


- (NSString *)description{
    NSArray *propertis = [[self class] loadPropertis];
    //把数组转成字典
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    //自定义输出
    return [NSString stringWithFormat:@"%@: %p %@",self.class,self,dict];
}

+ (void)loadNewsListWithUrlString:(NSString *)urlString finished:(void (^)(NSArray *))finished{
    [[NetworkTools sharedNetworkTools] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSLog(@"%@",responseObject.keyEnumerator.nextObject);
        //我要拿到数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@",array);
        //遍历数组字典转模型
        NSMutableArray *nmArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //字典转模型
            
            [nmArray addObject:[self objcWithDict:obj]];
        }];
        finished(nmArray.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end






















//
//  Channel.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/16.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "Channel.h"
#import "NSObject+Extension.h"
#import "News.h"
@implementation Channel

- (void)setTid:(NSString *)tid{
    _tid = tid;
    _urlString = [NSString stringWithFormat:@"%@/0-40.html",_tid];
}


#pragma mark -- 加载频道数组
+ (NSArray *)channelList{
    //1.加载json二进制数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //2.反序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //3.从字典中得到数组
    NSArray *array = dict[dict.keyEnumerator.nextObject];
    //4.遍历数组,字典转模型
    NSMutableArray *nmArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [nmArray addObject:[self objcWithDict:dic]];
    }
    //根据tid的大小频道数据排序
    
    return [nmArray sortedArrayUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
}
#pragma mark -- description不要抽取出来,容易死循环
- (NSString *)description{
    NSArray *propertis = [[self class] loadPropertis];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"%@: %p %@",self.class,self,dict];
}



@end









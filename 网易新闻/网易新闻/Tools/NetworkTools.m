//
//  NetworkTools.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools
+ (instancetype)sharedNetworkTools{
    static NetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1.注意要带反斜杠,这是AFN要求的,避免错误
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/list/"];
        instance = [[self alloc]initWithBaseURL:url];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}
@end

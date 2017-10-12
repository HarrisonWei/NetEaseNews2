//
//  NetworkTools.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkTools : AFHTTPSessionManager
//单例
+ (instancetype)sharedNetworkTools;
@end

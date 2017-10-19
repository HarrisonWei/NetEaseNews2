//
//  Channel.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/16.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
@property (nonatomic,copy)NSString *tname;
@property (nonatomic,copy)NSString *tid;

@property (nonatomic,copy)NSString *urlString;
#pragma mark -- 加载频道数组
+ (NSArray *)channelList;
@end

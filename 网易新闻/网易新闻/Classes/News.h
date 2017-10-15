//
//  News.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
//1.新闻标题
@property (nonatomic,copy)NSString *title;
//2.新闻来源
@property (nonatomic,copy)NSString *source;
//3.跟帖数量
@property (nonatomic,assign)int replyCount;
//4.配图地址
@property (nonatomic,copy)NSString *imgsrc;
//5.多图数组(两张图)
@property (nonatomic,strong)NSArray *imgextra;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsWithDict:(NSDictionary *)dict;

//网络请求的方法
+ (void)loadNewsListWithUrlString:(NSString *)urlString finished:(void(^)(NSArray *newsList))finished;
@end

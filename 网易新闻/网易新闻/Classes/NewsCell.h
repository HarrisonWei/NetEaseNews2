//
//  NewsCell.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/14.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@interface NewsCell : UITableViewCell
@property (nonatomic,strong)News *news;
//定义重用标识符类方法
+ (NSString *)cellForIdentifier:(News *)news;
@end

//
//  ChannelLabel.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/18.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel
#define KNormalSize 14.0
#define KSelectedSize 18.0
+ (instancetype)channelLabelWithTitle:(NSString *)title{
    ChannelLabel *l = [[ChannelLabel alloc]init];
    l.text = title;
    //1.设置文本对齐方式
    l.textAlignment = NSTextAlignmentCenter;
    //2.先设置成大字体
    l.font = [UIFont systemFontOfSize:KSelectedSize];
    //3.把label撑起来
    [l sizeToFit];
    //4.再设置成小字体
    l.font = [UIFont systemFontOfSize:KNormalSize];
    
    return l;
}

@end

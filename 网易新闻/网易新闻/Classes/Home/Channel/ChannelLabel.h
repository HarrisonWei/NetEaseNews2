//
//  ChannelLabel.h
//  网易新闻
//
//  Created by 曹魏 on 2017/10/18.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChannelLabel;
@protocol ChannelLabelDelegate <NSObject>
//代理方法
- (void)channelLabelDidSelected:(ChannelLabel *)label;
@end
@interface ChannelLabel : UILabel

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@property (nonatomic,assign)float scale;
//定义一个id类型的代理属性
@property (nonatomic,weak)id <ChannelLabelDelegate>delegate;

@end

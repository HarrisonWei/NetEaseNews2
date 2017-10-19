//
//  ChannelCell.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/18.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ChannelCell.h"
#import "NewsTableViewController.h"

@interface ChannelCell ()
@property (nonatomic,strong)NewsTableViewController *newsVC;
@end


@implementation ChannelCell

- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    self.newsVC.urlString = urlString;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //1.加载sb
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    //2.设置控制器和view
    
    self.newsVC = sb.instantiateInitialViewController;
    [self addSubview:self.newsVC.view];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置frame
    self.newsVC.view.frame = self.bounds;
    
}
@end
